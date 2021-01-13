{ config, pkgs, lib, ... }:

let
  inherit (pkgs.stdenv.targetPlatform) isDarwin isLinux;
in
{
  environment.pathsToLink = [ "/share/zsh" ];
  programs.zsh = {
    enable = true;
    # enableCompletion = true;

    # Prevent NixOS from clobbering prompts
    # See: https://github.com/NixOS/nixpkgs/pull/38535
    promptInit = lib.mkDefault "";
  };

  my.home = { config, lib, pkgs, ... }: {

    programs.zsh = {
      autocd = true;
      defaultKeymap = "emacs";
      dotDir = ".config/zsh";
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      envExtra = ''
          if [ -d "$HOME/.local/bin" ]; then
             export PATH="$PATH:$HOME/.local/bin"
          fi
          if [ -d "$HOME/.emacs.d/doom/bin" ]; then
             export PATH="$PATH:$HOME/.emacs.d/doom/bin"
          fi
          MINICOM='-con'
          export MINICOM
        '';
      history = {
        ignoreDups = true;
        expireDuplicatesFirst = true;
      };
      initExtra = ''
          bindkey "^P" up-line-or-search
          bindkey "^N" down-line-or-search
        '';
      oh-my-zsh = {
        enable = true;
        plugins = [
          # "common-aliases"
          "dirhistory"
          "extract"
          "git"
          "gitignore"
          "pass"
          "ripgrep"
          "rsync"
          "safe-paste"
          "sudo"
          "systemadmin"
          "systemd"
        ];
        # theme = "agnoster";
      };
      plugins = [
        {
          name = "zsh-nix-shell";
          file = "nix-shell.plugin.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "chisui";
            repo = "zsh-nix-shell";
            rev = "5dc081265cdd0d03631e9dc20b5e656530ae3af2";
            sha256 = "10y3jylx271j01i10vpqqz2ph4njbcyy34fnkn8ps39i9lfb7vhb";
          };
        }
        {
          name = "zsh-syntax-highlighting";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-syntax-highlighting";
            rev = "62c5575848f1f0a96161243d18497c247c9f52df";
            sha256 = "0s1cjm8psjwmrg8qdhdg48qyvp8nqk7bdgvqivgc5v9m27m7h5cg";
          };
        }
        {
          name = "you-should-use";
          src = pkgs.fetchFromGitHub {
            owner = "MichaelAquilina";
            repo = "zsh-you-should-use";
            rev = "b4aec740f23d195116d1fddec91d67b5e9c2c5c7";
            sha256 = "0bq15d6jk750cdbbjfdmdijp644d1pn2z80pk1r1cld6qqjnsaaq";
          };
        }
        {
          name = "solarized-man";
          src = pkgs.fetchFromGitHub {
            owner = "zlsun";
            repo = "solarized-man";
            rev = "e69d2cedc3a51031e660f2c3459b08ab62ef9afa";
            sha256 = "1ljnqxfzhi26jfzm0nm2s9w43y545sj1gmlk6pyd9a8zc0hafdx8";
          };
        }
      ];
      shellAliases = {
        rm="rm -i";
        cp="cp -i";
        mv="mv -i";

        calc = "emacs -nw -Q -f full-calc";
        cat = "${pkgs.bat}/bin/bat";
        df = "df -h";
        # du = "${pkgs.du-dust}/bin/dust";
        du = "${pkgs.ncdu}/bin/ncdu --color dark";
        h = "${pkgs.tldr}/bin/tldr";

        # general use
        ls ="${pkgs.exa}/bin/exa";                                                         # ls
        l  ="${pkgs.exa}/bin/exa -lbF --git";                                              # list, size, type, git
        ll ="${pkgs.exa}/bin/exa -lbGF --git";                                             # long list
        llm="${pkgs.exa}/bin/exa -lbGd --git --sort=modified";                             # long list, modified date sort
        la ="${pkgs.exa}/bin/exa -lbhHigUmuSa --time-style=long-iso --git --color-scale";  # all list
        lx ="${pkgs.exa}/bin/exa -lbhHigUmuSa@ --time-style=long-iso --git --color-scale"; # all + extended list

        # specialty views
        lS="${pkgs.exa}/bin/exa -1";                                                      # one column, just names
        lt="${pkgs.exa}/bin/exa --tree --level=2";                                        # tree

        ns = "nix-shell --run zsh -p";
        ssh = "TERM=xterm-256color ssh";
        sw = "ssh sw";
        wipe = "${pkgs.srm}/bin/srm -vfr";
        update = "pushd /Users/ahmet/Projects/dotfiles >/dev/null 2>&1 &&
                  nix flake update --recreate-lock-file;
                  popd >/dev/null 2>&1";
        # upgrade = "sudo nixos-rebuild switch --upgrade";
        rebuild = lib.mkMerge [
          (lib.mkIf isDarwin "pushd /Users/ahmet/Projects/dotfiles >/dev/null 2>&1 &&
                              darwin-rebuild switch --flake '/Users/ahmet/Projects/dotfiles#Ahmets-MacBook-Pro' -v;
                              popd >/dev/null 2>&1")
          (lib.mkIf (!isDarwin) "sudo nixos-rebuild switch --upgrade")
        ];
      };
    };
  };
}
