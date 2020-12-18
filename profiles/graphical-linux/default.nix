{ config, lib, pkgs, ... }:

{
  imports = [ ./user.nix ./xserver.nix ];

  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  # services.xserver.displayManager.lightdm = {
  #   enable = true;
  #   greeters.enso = {
  #     enable = true;
  #     blur = true;
  #   };
  # };

  services.fractalart.enable = true;
  # To use the gnome-keyring and have it act as the ssh-agent
  # services.gnome3.gnome-keyring.enable = true;
  # programs.seahorse.enable = true;
  # environment.systemPackages = with pkgs; [ polkit polkit_gnome ];

  # xdg = {
  #   icons.enable = true;
  #   portal.enable = true;
  #   portal.gtkUsePortal = true;
  # };

  # nixpkgs.config.chromium = {
  #   enableWideVine = true;
  #   enableVaapi = true;
  #   enablePepperFlash = false;
  # };

  fonts = {
    fontDir.enable = true;
    enableDefaultFonts = true;

    fonts = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      ubuntu_font_family
      anonymousPro
      source-code-pro
      google-fonts
      liberation_ttf
      nerdfonts
      hasklig
      powerline-fonts
      ttf_bitstream_vera
    ];

    fontconfig = {
      enable = true;
      hinting.enable = true;
      cache32Bit = true;
      defaultFonts = {
        serif = [ "Ubuntu" ];
        sansSerif = [ "Ubuntu" ];
        monospace = [ "Ubuntu" ];
      };
    };
  };
}
