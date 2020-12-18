# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

let
  profiles = import ../profiles;
in
{
  imports = [ profiles.default-linux ];

  # Use the systemd-boot EFI boot loader.
  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      # efiSysMountPoint = "/boot/efi";
    };
    systemd-boot.enable = false;
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      # gfxmodeEfi = "1024x768";
      extraPerEntryConfig = ''
        insmod setpci
        setpci -s "03:00.0" 04.b=7
        setpci -s "00:10.0" 3e.b=8
      '';
    };
  };

  boot.initrd.availableKernelModules = [ "ohci_pci" "ehci_pci" "ahci" "firewire_ohci" "usb_storage" "usbhid" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "msr" "coretemp" "applesmc" "kvm-intel" "wl" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [ broadcom_sta ];
  # boot.postBootCommands = ''
  #   # ${pkgs.pciutils}/bin/setpci -s "00:10.0" 3e.b=8
  #   # ${pkgs.pciutils}/bin/setpci -s "00:0c.0" 3e.b=8
  #   # ${pkgs.pciutils}/bin/setpci -s "00:15.0" 3e.b=8
  #   ${pkgs.pciutils}/bin/setpci -s "00:16.0" 3e.b=8
  #   ${pkgs.pciutils}/bin/setpci -s "03:00.0" 04.b=7
  # '';

  hardware.bluetooth.enable = true;
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    # extraPackages = with pkgs; [ libva ];
  };
  hardware.enableAllFirmware = true;

  # powerManagement.enable = true;
  # powerManagement.cpuFreqGovernor = "powersave";

  networking.hostName = "mbp"; # Define your hostname.
  networking.wireless.enable = false;  # Enables wireless support via wpa_supplicant.
  # networking.wireless = {
  #   enable = true;
  #   # networks."SUPERONLINE_WiFi_0822".psk = builtins.readFile /etc/nixos/secrets/superonline;
  #   # networks."SUPERONLINE_WiFi_5G_0822".psk = builtins.readFile /etc/nixos/secrets/superonline;
  #   networks."SUPERONLINE_WiFi_0822".psk = "4Bf7a8eCe4854";
  #   networks."SUPERONLINE_WiFi_5G_0822".psk = "4Bf7a8eCe4854";
  # };
  # networking.networkmanager.unmanaged = [ "wlp4s0" ];

  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.interfaces.enp0s10.useDHCP = true;
  # networking.interfaces.wlp4s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = lib.mkDefault false;
  
  # Set your time zone.
  time.timeZone = "Europe/Istanbul";
  location.provider = "geoclue2";
  
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = { LC_MESSAGES = "en_US.UTF-8"; LC_TIME = "tr_TR.UTF-8"; };
  console = {
    #font = "${pkgs.terminus_font}/share/consolefonts/ter-u16n.psf.gz";
    font = "Lat2-Terminus16";
    keyMap = "colemak/colemak";
  };

  # Configure keymap in X11
  services.xserver.layout = "us";
  services.xserver.xkbVariant = "colemak";
  # Capslock as Control
  services.xserver.xkbOptions = "ctrl:nocaps";
  # services.xserver.xkbOptions = "eurosign:e";
  services.xserver.deviceSection = ''
    Option "Backlight"      "gmux_backlight"
    Option "RegistryDwords" "EnableBrightnessControl=1"
  '';
  services.xserver.videoDrivers = [ "nvidiaLegacy340" ];

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # services.logind.lidSwitch = "ignore";
  services.tlp.enable = true;
 
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/4dc5897a-88bd-422d-b2e5-c9882ec5ac39";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/3270-87DD";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/6b75d076-3eef-4259-b0e7-ff5fa69b4c8f"; }
    ];

  # environment.systemPackages = [ pkgs.brightnessctl ];

}
