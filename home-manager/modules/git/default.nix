{...}: {
  programs.git.enable = true;

  home.file.".scripts/git" = {
    recursive = true;
    source = ./scripts;
  };

  home.file.".gitignore_global".text = ''
    .DS_Store
    *.o
    .tester.json

    node_modules/
    vendor/
    build/
  '';

  home.file.".gitconfig".text = ''
    [user]
    	name = Kesse Jones

    [core]
    	excludesfile = ~/.gitignore_global
    	editor = nvim

    [pull]
    	rebase = true

    [push]
        default = current

    [init]
    	defaultBranch = main

    [alias]
        a = "!~/.scripts/git/git-add.sh"

        d = diff
        b = branch
        l = lg
        s = status
        f = fetch

        r = "!~/.scripts/git/git-rebase.sh"
        m = "!~/.scripts/git/git-merge.sh"

        lg = log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all
        ls = "!~/.scripts/git/git-show.sh"

        # add
        aa = "add --all"
        ap = "add --patch"
        ai = "add --interactive"

        # checkout
        co = "!~/.scripts/git/git-checkout.sh"
        cb = checkout -b

        # discard files
        cd = "!~/.scripts/git/git-discard.sh"

        # commit
        ci = commit
        ca = commit --amend
        cu = reset --soft HEAD^

        # push
        ps = push
        fp = push --force-with-lease

        # pull
        pl = pull

        # branch
        bm = branch -m
        bM = branch -M

        bd = "!~/.scripts/git/git-branch-delete.sh -d"
        bx = "!~/.scripts/git/git-branch-delete.sh -D"

        # diff
        dh = diff HEAD^
        dv = "!nvim -c \"DiffviewOpen\""

        # rebase
        rc = rebase --continue
        rs = rebase --skip
        ra = rebase --abort
        ri = "!~/.scripts/git/git-rebase-interactive.sh"

        # restore
        rt = "!~/.scripts/git/git-restore-staged.sh"

        # merge
        ma = merge --abort
        mc = merge --continue

        # stash
        ss = stash
        sa = "!~/.scripts/git/git-stash.sh apply"
        sd = "!~/.scripts/git/git-stash.sh drop"
        sp = "!~/.scripts/git/git-stash.sh pop"
        sl = "!git stash list | gum choose --limit 1 >/dev/null"

    [include]
        path = ~/.gitconfig-local
  '';
}
