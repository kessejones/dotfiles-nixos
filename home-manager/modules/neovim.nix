{
  pkgs,
  lib,
  ...
}: {
  xdg.configFile."nvim/init.lua".enable = lib.mkForce false;
  programs.neovim = {
    enable = true;
    package = pkgs.unstable.neovim-unwrapped;

    withNodeJs = false;
    withPython3 = false;
    withRuby = false;

    extraPackages = with pkgs;
      [
        typescript-language-server
        yaml-language-server

        # php.packages.php-codesniffer
        # php.packages.php-cs-fixer

        lua-language-server
        clang-tools
        alejandra
        gopls
        nil
        nixd
        stylua
        elixir-ls
        elixir
        mariadb.client
        sqlite
        python3
        superhtml
        #
        # nodeCustomPackages.prettierd
      ]
      ++ [
        pkgs.unstable.zls
        pkgs.unstable.tree-sitter
      ];
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
