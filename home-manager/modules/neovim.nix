{
  pkgs,
  lib,
  unstable-pkgs,
  ...
}: {
  programs.neovim = {
    enable = true;
    package = unstable-pkgs.neovim-unwrapped;

    extraPackages = with pkgs; [
      nodePackages.typescript-language-server
      # nodePackages.vscode-langservers-extracted
      nodePackages.yaml-language-server
      nodePackages.prettier
      ocamlPackages.ocaml-lsp
      ocamlPackages.ocamlformat

      php.packages.php-codesniffer
      php.packages.php-cs-fixer

      haskell-language-server
      lua-language-server
      java-language-server
      tree-sitter
      clang-tools
      alejandra
      gopls
      nil
      nixd
      stylua
      elixir_ls
      elixir
      mysql
      sqlite
      ruby-lsp
      python3

      nodeCustomPackages.prettierd
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
