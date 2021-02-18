{ config, lib, pkgs, ... }:

{
  my.home = { ... }: {
    home.packages = with pkgs; [
      delve
      errcheck
      go
      go2nix
      gocode
      godef
      goimports
      golangci-lint
      golint
      gomodifytags
      gopls
      gore
      gosec
      gotags
      gotests
      gotools                     # guru
    ];
  };
}
