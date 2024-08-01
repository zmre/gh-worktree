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
          bash
          gnused
          gawk
          git
          direnv
        ];
      in rec {
        packages = {
          gh-worktree = pkgs.stdenv.mkDerivation {
            name = "gh-worktree";
            version = "0.1.0";
            src = ./.;
            buildInputs = dependencies;
            nativeBuildInputs = [pkgs.makeWrapper];
            phases = ["installPhase"];

            installPhase = ''
              mkdir -p $out
              cp $src/README.md $out
              makeWrapper "$src/gh-worktree" "$out/gh-worktree" --prefix PATH : ${
                pkgs.lib.makeBinPath dependencies
              }

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
