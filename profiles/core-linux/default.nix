{ config, pkgs, lib, ... }:

{
  imports = [
    ./boot.nix
    ./services.nix
  ];

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  networking.useDHCP = false;

  networking.networkmanager.enable = true;

  networking.firewall.enable = true;
  networking.firewall.allowPing = true;

  networking.nameservers = [ "1.1.1.1" "8.8.8.8" "9.9.9.9" ];

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    extraModules = [ pkgs.pulseaudio-modules-bt ];
    package = pkgs.pulseaudioFull;
    support32Bit = true;
  };

  # Add a folder in $XDG_RUNTIME_DIR to be used as my own temporary directory
  my.home = {
    systemd.user.tmpfiles.rules = [
      #Type Path   Mode User Group Age Argument
      "D    %t/tmp 0550 -    -     -   -"
    ];
  };
}
