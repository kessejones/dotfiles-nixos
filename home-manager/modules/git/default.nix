{pkgs, ...}: {
  programs.git = let
    scripts = import ./scripts.nix {pkgs = pkgs;};
  in {
    enable = true;
    delta = {
      enable = true;
      options = {
        syntax-theme = "catppuccin";
        line-numbers = true;
        side-by-side = true;
        file-modified-label = "modified:";
        light = false;
      };
    };

    userName = "Kesse Jones";

    ignores = [
      ".DS_Store"
      "*.o"
      ".tester.json"
      "node_modules/"
      "vendor/"
      "build/"
    ];

    extraConfig = {
      core = {
        editor = "nvim";
      };

      pull = {
        rebase = true;
      };
      push = {
        default = "current";
        autoSetupRemote = true;
      };
      init = {
        defaultBranch = "main";
      };

      url = {
        "ssh://git@github.com/" = {
          insteadOf = "https://github.com/";
        };
      };
    };

    aliases = {
      a = "!${scripts.git-add}";

      d = "diff";
      b = "branch";
      l = "lg";
      s = "status";
      f = "fetch";

      r = "!${scripts.git-rebase}";
      m = "!${scripts.git-merge}";

      lg = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all";

      ls = "!${scripts.git-show}";

      # add
      aa = "add --all";
      ap = "add --patch";
      ai = "add --interactive";

      # checkout
      co = "!${scripts.git-checkout}";
      cb = "checkout -b";

      # discard files
      cd = "!${scripts.git-discard}";

      # commit
      ci = "commit";
      ca = "commit --amend";
      cu = "reset --soft HEAD^";

      # cherry-pick
      cp = "cherry-pick";

      # push
      ps = "push";
      fp = "push --force-with-lease";

      # pull
      pl = "pull";

      # branch
      bm = "branch -m";
      bM = "branch -M";

      bd = "!${scripts.git-branch-delete} -d";
      bx = "!${scripts.git-branch-delete} -D";

      # diff
      dh = "diff HEAD^";
      dv = "!nvim -c \"DiffviewOpen\"";

      # rebase
      rc = "rebase --continue";
      rs = "rebase --skip";
      ra = "rebase --abort";
      ri = "!${scripts.git-rebase-interactive}";

      # restore
      rt = "!${scripts.git-restore-staged}";

      # merge
      ma = "merge --abort";
      mc = "merge --continue";

      # stash
      ss = "stash";
      sa = "!${scripts.git-stash} apply";
      sd = "!${scripts.git-stash} drop";
      sp = "!${scripts.git-stash} pop";
      sl = "!git stash list | gum choose --limit 1 >/dev/null";
    };

    includes = [
      {path = "~/.gitconfig-local";}
    ];
  };
}
