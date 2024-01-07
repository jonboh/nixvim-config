{ pkgs, ... }:
{
  extraPlugins = [
    pkgs.vimExtraPlugins.nabla-nvim
  ];
}
