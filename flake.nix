{
  inputs = {
    utils.url = "github:numtide/flake-utils";
  };
  outputs = {
    self,
    nixpkgs,
    utils,
  }:
    utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
        dependencies = with pkgs; [
          gh
          bash
          gnused
          gnugrep
          gawk
          git
          direnv
        ];
        binPath = pkgs.lib.makeBinPath dependencies;
      in rec {
        packages = {
          gh-worktree = pkgs.stdenvNoCC.mkDerivation {
            pname = "gh-worktree";
            version = "0.1.0";
            src = ./.;
            buildInputs = dependencies;
            nativeBuildInputs = [pkgs.makeWrapper];
            phases = ["installPhase"];
            installPhase = ''
              install -D -m644 "$src/README.md" "$out/README.md"
              install -D -m755 "$src/gh-worktree" "$out/bin/gh-worktree"
            '';
            postFixup = ''
              wrapProgram "$out/bin/gh-worktree" --prefix PATH : "${binPath}"
            '';
          };
        };
        defaultPackage = packages.gh-worktree;

        devShell = pkgs.mkShell {
          buildInputs = dependencies;
        };
      }
    );
}
