{ pkgs, ... }:
{
  extraPlugins = [
    pkgs.vimPlugins.asyncrun-vim
  ];
}
