self: super: {
  vimPlugins = super.vimPlugins // {
    image-nvim = super.vimPlugins.image-nvim.overrideAttrs (oldAttrs: {
      src = super.fetchFromGitHub {
        owner = "3rd";
        repo = "image.nvim";
        rev = "4c6cb5ad93ee93d8d7b7c84e1eb291cee99f0a0e";
        sha256 = "sha256-mh3J3lW2Co2uA7YJzSGum0ZmpJBP0ZzBWUvJLAI9bHw=";
      };
    });
  };
}
