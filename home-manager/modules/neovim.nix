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
      nodePackages.vscode-langservers-extracted
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
