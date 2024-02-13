self: super:
{
  vimPlugins = super.vimPlugins // {
    image-nvim = super.vimPlugins.image-nvim.overrideAttrs (oldAttrs: {
      src = super.fetchFromGitHub {
        owner = "jonboh";
        repo = "image.nvim";
        rev = "5c9d5d86cde747496abf452553a415196c38743f";
        sha256 = "sha256-IBW6f+7T+UoeAIOwifLVRfhZE6bTmVktKy42vVEbrls=";
      };
    });
  };
}
