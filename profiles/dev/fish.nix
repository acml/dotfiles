{ config, ... }:

{
  my.home = { config, ... }: {
    programs.fish = {
      enable = false;
      shellAbbrs = {
        "..."  = "../../";
        "...." = "../../../";
        "....." = "../../../../";
      };
      shellAliases = config.programs.zsh.shellAliases;
    };
  };
}
