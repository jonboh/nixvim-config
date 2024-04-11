{pkgs, ...}: {
  extraPlugins = [(pkgs.callPackage ../plugins/hurl.nix {})];
  extraConfigLua = ''
    require('hurl').setup({})
  '';
  extraPackages = [pkgs.nodePackages.prettier pkgs.jq];
}
