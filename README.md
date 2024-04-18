# gh worktree extension

## Intro

This is an extremely basic extension to help me work with github and worktrees.  There is another [gh-worktree](https://github.com/despreston/gh-worktree) extension made by despreston and written in Go.  His is specific to PRs and has nice completions as well, which is great (for my part, I just use `gh pr list` or look at the web page most of the time anyway).  I had [issues using his version](https://github.com/despreston/gh-worktree/issues/4) as it didn't work nicely with certain pull requests like those from forks or dependabot.   

I realize I should name this something else, but I won't remember anything else.  For now I won't publish this and if he fixes that issue, I probably never will.

But I have different needs and so this also encapsulates [Alex Russel's approach to checking out worktrees](https://infrequently.org/2021/07/worktrees-step-by-step/) as a `gh worktree clone` step.

The whole thing is a simple bash script to simplify my life. If it gets much more complicated, it will outgrow bash and probably become a PITA, but for now this more than meets my needs.  

## Usage

Here's how I use it to clone a github repo:

```bash
gh worktree clone zstevearc/oil.nvim
cd oil.nvim
ls -a
```

> .bare    master

(Do this with any repo and if it's your own, no need to put the owner name). It will create a worktree for master or main and a bare repo in a hidden folder.  From inside this directory, you can make a new branch with standard worktree commands like `git worktree add -b my-new-fix` and it will create that as a subdirectory you can switch into.

Also from this cloned folder, you can checkout PRs by doing this:

```bash
gh worktree pr 341
cd pr-341
```

And that's it.  All the commands allow you to specify your preferred folders if you use a different setup or if you aren't in the base dir to start or whatever.  So you could instead say, `gh worktree pr 341 ../joes-new-feature-pr` or whatever and it will put things where you hope named in a way that makes sense to you.

## Install

While it isn't listed, you have to install it like so:

```bash
gh extension install zmre/gh-worktree
```

Or to mess around with it locally, you can call the script directly or make your mods and then install them from the checked out `gh-worktree` like this:

```bash
gh extension install .
```

Note: this may require `jq` to be installed and in your path depending on what happens when you use the `--jq` parameter to `gh`. I could probably remove this requirement if someone asks nicely and PRs welcome.
