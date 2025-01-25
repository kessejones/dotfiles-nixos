{pkgs, ...}: {
  programs.home-manager.enable = true;
  programs.zoxide.enable = true;
  programs.direnv.enable = true;

  # Testing terminal file managers
  xdg.configFile."vifm/colors/nord.vifm".text = ''
    highlight clear

    highlight Border      cterm=none	ctermfg=default ctermbg=default
    highlight TopLine     cterm=none	ctermfg=110	ctermbg=236
    highlight TopLineSel	cterm=bold	ctermfg=110 ctermbg=237

    highlight Win         cterm=none	ctermfg=7	ctermbg=default
    highlight OtherWin    cterm=none	ctermfg=7	ctermbg=default
    highlight CurrLine    cterm=bold,inverse	ctermfg=default	ctermbg=default
    highlight OtherLine   cterm=bold	ctermfg=default	ctermbg=235
    highlight Selected    cterm=none	ctermfg=7	ctermbg=237

    highlight JobLine     cterm=bold	ctermfg=116	ctermbg=238
    highlight StatusLine	cterm=bold	ctermfg=110	ctermbg=237
    highlight ErrorMsg    cterm=bold	ctermfg=167	ctermbg=default
    highlight WildMenu    cterm=bold,inverse	ctermfg=110	ctermbg=236
    highlight CmdLine     cterm=none	ctermfg=7	ctermbg=default

    highlight Executable	cterm=bold	ctermfg=003	ctermbg=default
    highlight Directory   cterm=bold	ctermfg=110	ctermbg=default
    highlight Link        cterm=none	ctermfg=005	ctermbg=default
    highlight BrokenLink	cterm=bold	ctermfg=007 ctermbg=167
    highlight Device      cterm=none,standout	ctermfg=110	ctermbg=default
    highlight Fifo        cterm=none	ctermfg=172	ctermbg=default
    highlight Socket      cterm=bold	ctermfg=223	ctermbg=default
  '';

  programs.vifm = {
    enable = true;
    extraConfig = ''
      set vicmd=nvim

      colorscheme nord

      nnoremap <space>w :w<cr>

      nnoremap <space>w :w<cr>
      nnoremap <space>q :q<cr>
    '';
  };

  home.packages = with pkgs; [
    # CLI tools
    # fzf
    # eza
    ripgrep
    gum
    glow
    fd
    zip
    unzip
    unrar
    xclip
    lazydocker
    jq
    k9s
    nvtopPackages.nvidia
    lazygit
    carapace
    warpd
    atuin

    # dev
    php
    # php.packages.composer
    gcc
    gnumake
    nodejs
    yarn
    rustup
    zig

    # Desktop apps
    (nemo-with-extensions.override {extensions = [nemo-fileroller];})
    pix
    gnome-calculator
    gnome-calendar
    file-roller
    arandr
    gimp
    freetube
    television

    # Browsers
    librewolf
    floorp
    brave

    # Torrents clients
    deluge-gtk

    # System manager/configuration
    pulseaudio
    pavucontrol
    mpc_cli

    # Games
    (prismlauncher.override {jdks = [zulu8 zulu17 zulu21];})
    lutris

    sidequest
  ];
}
