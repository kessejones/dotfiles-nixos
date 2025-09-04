{
  pkgs,
  lib,
  unstable-pkgs,
  ...
}: {
  xdg.configFile."nvim/init.lua".enable = false;
  programs.neovim = {
    enable = true;
    package = unstable-pkgs.neovim-unwrapped;

    extraPackages = with pkgs; [
      nodePackages.typescript-language-server
      nodePackages.yaml-language-server

      # php.packages.php-codesniffer
      # php.packages.php-cs-fixer

      lua-language-server
      tree-sitter
      clang-tools
      alejandra
      gopls
      nil
      nixd
      stylua
      elixir_ls
      elixir
      mariadb-client
      sqlite
      python3
      superhtml

      nodeCustomPackages.prettierd
    ] ++ [unstable-pkgs.zls];
  };

  home.activation.install-kvim = let
    kvim-repo = "https://github.com/kessejones/kvim.git";
    path = "$HOME/.config/nvim";
  in
    lib.mkAfter ''
      if [ ! -d "${path}" ]; then
        ${pkgs.git}/bin/git clone ${kvim-repo} ${path}
      fi
    '';
}
