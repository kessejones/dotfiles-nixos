{pkgs}:
with pkgs; let
  git = "${pkgs.git}/bin/git";
  gum = "${pkgs.gum}/bin/gum";
in {
  git-add = writeShellScript "git-add" ''
    args=$@
    if [ -z "$args" ]; then
        args=$(${git} status --short | cut -c 4- | ${gum} choose --no-limit)
        [ -z "$args" ] && exit 1
    fi
    ${git} add $args
  '';

  git-branch-delete = writeShellScript "git-branch-delete" ''
    mode="$1"
    shift
    args="$@"

    if [ -z "$args" ]; then
        args=$(${git} branch | awk '!/\*/ { print $1 } ' | ${gum} choose --no-limit)

        [ -z "$args" ] && exit 1
    fi

    ${git} branch $mode $args
  '';

  git-checkout = writeShellScript "git-checkout" ''
    args=$@
    if [ -z "$args" ]; then
        args=$(${git} branch | cut -c 3- | ${gum} choose --limit 1)
        [ -z "$args" ] && exit 1
    fi

    ${git} checkout $args
  '';

  git-stash = writeShellScript "git-stash" ''
    mode=$1 # apply, drop, list or pop

    if [ -n "$mode" ]; then
        stash=$(${git} stash list | ${gum} choose --limit 1 | cut -d':' -f1)
        if [ -n "$stash" ]; then
            ${git} stash $mode $stash
        fi
    fi
  '';

  git-show = writeShellScript "git-show" ''
    args=$@

    if [ -z "$args" ]; then
        args=$(${git} log --oneline | ${gum} choose --limit 1 | cut -d' ' -f1)
        [ -z "$args" ] && exit 1
    fi

    ${git} show $args
  '';

  git-restore-staged = writeShellScript "git-restore-staged" ''
    if [ -z "$@" ]; then
        git_files=$(${git} status --short -uno | grep -v '^ ' | awk '{print $2}')
        if [ ! -z "$git_files" ]; then
            files=$(${gum} choose --no-limit $git_files)
            if [ -n "$files" ]; then
                ${git} restore --staged $files
            fi
        fi
    else
        ${git} restore --staged $@
    fi
  '';

  git-rebase = writeShellScript "git-rebase" ''
    args=$@

    if [ -z "$args" ]; then
        args=$(${git} branch | awk '!/\*/ { print $1 } ' | ${gum} choose --limit 1)
        [ -z "$args" ] && exit 1
    fi

    ${git} rebase $args
  '';

  git-rebase-interactive = writeShellScript "git-rebase-interactive" ''
    args=$@

    if [ -z "$args" ]; then
        args=$(${git} log --oneline | ${gum} choose --limit 1 | cut -d' ' -f1)
        [ -z "$args" ] && exit 1
    fi

    ${git} rebase -i $args
  '';

  git-merge = writeShellScript "git-merge" ''
    args=$@

    if [ -z "$args" ]; then
        args=$(${git} branch | awk '!/\*/ { print $1 } ' | ${gum} choose --limit 1)
        [ -z "$args" ] && exit 1
    fi

    ${git} merge $args

  '';

  git-discard = writeShellScript "git-discard" ''
    args=$@

    if [ -z "$args" ]; then
        args=$(${git} status --short | cut -c 4- | ${gum} choose --no-limit)
        [ -z "$args" ] && exit 1
    fi

    ${git} checkout $args
  '';
}
