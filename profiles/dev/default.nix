{ config, pkgs, lib, ... }:

let
  inherit (builtins) map attrNames readDir;
  inherit (lib) filterAttrs hasSuffix;

  configs = let
    files = readDir ./.;
    filtered = filterAttrs (n: v: n != "default.nix" && (v == "directory" || (v == "regular" && hasSuffix ".nix" n)));
  in map (p: ./. + "/${p}") (attrNames (filtered files));
in
{
  imports = configs;

  home-manager.users.${config.my.username} = { config, pkgs, ... }: {
    home.sessionVariables = {
      EDITOR = "${config.programs.neovim.package}/bin/nvim";
      LESS = "--RAW-CONTROL-CHARS --quit-if-one-screen";
      CARGO_HOME = "${config.xdg.cacheHome}/cargo";
      DOCKER_CONFIG = "${config.xdg.configHome}/docker";
      M2_HOME = "${config.xdg.cacheHome}/maven";
    };

    home.packages = with pkgs; [
      # cli to extract data out of json input
      jq

      # Programming
      clang
      python3
      gnumake
      powershell
      tig

      wget curl aria
      lsof
      nmap telnet tcpdump dnsutils mtr
      gitFull rsync
      exa fd fzf ripgrep hexyl tree bc bat
      procs sd dust tokei bandwhich pipr manix
      htop ctop
      docker-compose
    ] ++ lib.optionals pkgs.stdenv.isLinux [
      bottom
      jetbrains.idea-community
      insomnia
    ];

    # Preview directory content and find directory to `cd` to
    programs.broot = {
      enable = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
    };

    # ctrl-t, ctrl-r, kill <tab><tab>
    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
      defaultCommand = ''${pkgs.fd}/bin/fd --follow --type f --exclude="'.git'" .'';
      defaultOptions = [ "--exact" "--cycle" "--layout=reverse" ];
      # enableFishIntegration = true;
    };

    programs.mcfly = {
      enable = false;
      enableFishIntegration = true;
    };

    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
    };

    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
    };
  };
}

