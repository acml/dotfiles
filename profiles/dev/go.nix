{ config, lib, pkgs, ... }:

{
  my.home = { ... }: {
    home.packages = with pkgs; [
      delve
      errcheck
      go
      go-tools
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
      gotools    # guru
      impl
      # revive   # not avaliable on nixos for now
      gopkgs     # Replacement of gopkgs with gopls is a work-in-progress.
      go-outline # It will be replaced with gopls.
    ];
  };
}
