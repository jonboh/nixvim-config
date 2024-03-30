self: super: {
  vimPlugins =
    super.vimPlugins
    // {
      image-nvim = super.vimPlugins.image-nvim.overrideAttrs (oldAttrs: {
        src = super.fetchFromGitHub {
          owner = "jonboh";
          repo = "image.nvim";
          rev = "88566b588af071262e73d2af95ff2f5d260066aa";
          sha256 = "sha256-ZfNUZs3AAPrAWrc5vUtoE2cEo/Ijh67njSyq+604GDg=";
        };
        # src = fetchTree {
        #   path = /home/jonboh/devel/image.nvim;
        #   narHash = "sha256-oKLFLUTuTkQ4dJ7GemdytkJ+RQcT0C0XBzcvX//PxE8=";
        #   type = "path";
        # };
      });
    };
}
