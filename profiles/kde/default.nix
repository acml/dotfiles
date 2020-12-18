{ pkgs, ... }:

let inherit (pkgs) hplip hplipWithPlugin plasma5 kdeApplications kdeFrameworks;
in {
  services.xserver.desktopManager.plasma5.enable = true;

  environment.systemPackages = (with pkgs; [
    ark         # Archives (e.g., tar.gz and zip)
    gwenview    # Photo/image editor
    kdeconnect
    kdiff3
    kgpg        # GPG manager for KDE
    kwalletcli  # Password manager for KDE
    okular      # Document readers
    pinentry-qt # This is needed for graphical dialogs used to enter GPG passphrases
    vlc
    yakuake     # Drop-down terminal
  ])
  ++ (with kdeApplications; [ filelight kate kdialog ])
  ++ (with plasma5; [ plasma-browser-integration ]);

  # Open ports for KDE Connect
  networking.firewall.allowedTCPPortRanges = [{from = 1714; to = 1764;}];
  networking.firewall.allowedUDPPortRanges = [{from = 1714; to = 1764;}];
}

