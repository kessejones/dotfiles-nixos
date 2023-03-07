self: super: {
  catppuccin = with self; {
    zathura = fetchGit {
      url = "https://github.com/catppuccin/zathura.git";
    };
    btop = fetchGit {
      url = "https://github.com/catppuccin/btop.git";
    };
    discocss = fetchGit {
      url = "https://github.com/catppuccin/discord.git";
      ref = "refs/heads/gh-pages";
    };
    bat = pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "bat";
      rev = "ba4d16880d63e656acced2b7d4e034e4a93f74b1";
      sha256 = "sha256-6WVKQErGdaqb++oaXnY3i6/GuH2FhTgK0v4TN4Y0Wbw=";
    };
  };

  kesse = {
    dotfiles = fetchGit {
      url = "https://github.com/kessejones/dotfiles.git";
    };

    kvim = fetchGit {
      url = "https://github.com/kessejones/kvim.git";
    };
  };
}
