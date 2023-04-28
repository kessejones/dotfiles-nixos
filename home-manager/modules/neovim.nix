{
  pkgs,
  lib,
  ...
}: {
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;

    extraPackages = with pkgs; [
      nodePackages.typescript-language-server
      nodePackages.vscode-langservers-extracted
      nodePackages.yaml-language-server
      nodePackages.prettier

      php.packages.phpcs
      php.packages.php-cs-fixer

      haskell-language-server
      lua-language-server
      rust-analyzer
      tree-sitter
      clang-tools
      alejandra
      rustfmt
      gopls
      nil
      stylua
      elixir_ls

      nodeCustomPackages.prettierd
    ];
  };

  home.activation.installKVim = let
    path = "$HOME/.config/nvim";
  in
    lib.hm.dag.entryAfter ["writeBoundary"] ''
      if [ ! -d "${path}" ]; then
        ${pkgs.git}/bin/git clone https://github.com/kessejones/kvim.git ${path}
      fi
    '';
}
