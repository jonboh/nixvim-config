{ pkgs, ... }: {
  extraPlugins = [ (pkgs.callPackage ../plugins/kitty-scrollback.nix { }) ];

  extraConfigLua = ''
    require("kitty-scrollback").setup()
  '';
}
