# nixos-config
My nixos system and user config

## system config

I keep my system config under machines. Link machine dir to /etc/nixos

```
$ sudo mv /etc/nixos /etc/nixos.bak
$ sudo ln -s $(pwd)/nixos/$(hostname -s) /etc/nixos
```

## home manager

Home manager config can be found under home. Link it to ~/.config/nixpkgs

```
$ ln -s $(pwd)/nixpkgs ~/.config/nixpkgs
```

Check out [https://github.com/nix-community/home-manager] on how to install home manager.
