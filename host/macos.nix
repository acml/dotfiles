{ config, pkgs, lib, ... }:

# Uses nix-darwin modules
let
  profiles = import ../profiles;
in
{
  imports = with profiles; [ dev programs ];

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  nix = {
    useSandbox = true;
    sandboxPaths = [ "/System/Library/Frameworks" "/System/Library/PrivateFrameworks" "/usr/lib" "/private/tmp" "/private/var/tmp" "/usr/bin/env" ];
    trustedUsers = [ "@admin" ];
  };

  # This is a multi-user Nix install
  services.nix-daemon.enable = lib.mkForce true;

  programs.fish.enable = false;
  programs.zsh.enable = true;
  services.emacs.enable = true;

  # fonts
  fonts = {
    enableFontDir = true;
    fonts = with pkgs; [
      emacs-all-the-icons-fonts
      (nerdfonts.override { fonts = [ "Iosevka" ]; } )
    ];
  };

  # Fix xdg.{dataHome,cacheHome} being empty in home-manager
  users.users.${config.my.username} = {
    home = "/Users/${config.my.username}";
    isHidden = false;
    shell = pkgs.zsh;
  };

  system.defaults.finder = {
    AppleShowAllExtensions = true;
    _FXShowPosixPathInTitle = true;
    FXEnableExtensionChangeWarning = false;
  };

  system.defaults.dock = {
    expose-group-by-app = true;
    minimize-to-application = true;
    mru-spaces = false;
    orientation = "left";
    show-recents = true;
    tilesize = 32;
  };

  system.defaults.loginwindow = {
    # SHOWFULLNAME = false;
    GuestEnabled = false;
    LoginwindowText = "Property of Ahmet Cemal Ozgezer";
    # DisableConsoleAccess = true;
  };

  system.defaults.NSGlobalDomain = {
    _HIHideMenuBar = false;
    AppleKeyboardUIMode = 3;
    AppleShowAllExtensions = with config.system.defaults.finder;
      if isNull AppleShowAllExtensions then false else AppleShowAllExtensions;
    AppleShowScrollBars = "Always";
    NSAutomaticCapitalizationEnabled = false;
    NSAutomaticDashSubstitutionEnabled = false;
    NSAutomaticPeriodSubstitutionEnabled = false;
    NSAutomaticQuoteSubstitutionEnabled = false;
    NSAutomaticSpellingCorrectionEnabled = false;
    InitialKeyRepeat = 25;
    KeyRepeat = 2;
    "com.apple.keyboard.fnState" = true;
    "com.apple.mouse.tapBehavior" = 1;
  };

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = true;
  };

  system.activationScripts.preUserActivation.text = ''
    mkdir -p ~/Pictures/Screenshots
  '';
  system.defaults.screencapture.location = "${config.users.users.${config.my.username}.home}/Pictures/Screenshots";

  system.defaults.trackpad = {
    Clicking = true;
    TrackpadRightClick = true;
  };
}
