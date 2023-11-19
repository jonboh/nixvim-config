### Nixvim Flake
Hey, this my nixvim flake. With it you can reproduce my editor anywhere that runs nix :D

If you don't know about Nix and NixOS [check it out](https://nixos.org/)!

[Nixvim](https://github.com/nix-community/nixvim) is a way to declare your
neovim configuration with Nix. Once you use nixvim you
won't ever again fear running an update on your NeoVim plugins.

### Wanna check this out?
If you are not running on NixOS, install Nix with your package-manager,
then activate flake support by adding this line to `/etc/nix/nix.conf`:
```
experimental-features = nix-command flakes
```
then simply run:
```
nix run github:jonboh/nixvim
```
there you have my editor.

If you see some errors at startup and you already use neovim, temporarily rename your
config folder so that my nixvim does not load your config files on top of the my nixvim config.
Once you are done testing you can rename back your config or rewrite in nixvim ;)
