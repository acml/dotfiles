{ config, pkgs, lib, ... }:

{
  # services.avahi.enable = true;
  # services.avahi.nssmdns = true;
  # services.acpid.enable = true;
  # services.blueman.enable = true;
  # services.colord.enable = true;
  # services.flatpak.enable = true;

  # Allow updating the firmware of various components
  services.fwupd.enable = true;

  # Enable GVFS, implementing "trash" and so on.
  # services.gvfs.enable = true;

  # Enable locate
  # services.locate.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # security.polkit.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;
  # services.printing.browsing = true;

  # networking.wireguard.enable = true;

  # Logitech
  # hardware.logitech.wireless.enable = true;
  # hardware.logitech.wireless.enableGraphical = true;

  # Forward journald logs to VTT 1
  # services.journald.extraConfig = ''
  #   FordwardToConsole=yes
  #   TTYPath=/dev/tty1
  # '';

  # Steelseries headset
  # services.udev.extraRules = lib.optionalString config.hardware.pulseaudio.enable ''
  #   ATTRS{idVendor}=="1038", ATTRS{idProduct}=="12ad", ENV{PULSE_PROFILE_SET}="steelseries-arctis-7-usb-audio.conf"
  #   ATTRS{idVendor}=="1038", ATTRS{idProduct}=="12AD", ENV{PULSE_PROFILE_SET}="steelseries-arctis-7-usb-audio.conf"
  # '';

  # Yubikey
  # services.udev.packages = with pkgs; [ yubikey-personalization libu2f-host ];
  # services.pcscd.enable = true;

  # Enable insults on wrong `sudo` password input
  # security.sudo.extraConfig = lib.mkAfter ''
  #   Defaults !insults
  #   Defaults:%wheel insults
  # '';
}
