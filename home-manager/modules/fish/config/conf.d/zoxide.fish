if type -q zoxide
    zoxide init fish | source

    export _ZO_EXCLUDE_DIRS="/nix:/etc:/usr:/boot:/bin:/home:/media:/var"
end
