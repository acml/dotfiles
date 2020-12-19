{ config, lib, pkgs, ... }:

{
  my.home = { ... }: {
    programs.starship = {
      enable = true;
      settings = {
        # aws.disabled = true;
        # battery.disabled = true;
        # cmd_duration.disabled = true;
        # conda.disabled = true;
        # dotnet.disabled = true;
        # env_var.disabled = true;
        # git_branch.disabled = true;
        # git_commit.disabled = true;
        # git_state.disabled = true;
        git_status.disabled = true;
        # golang.disabled = true;
        # hg_branch.disabled = true;
        java.disabled = true;
        # kubernetes.disabled = true;
        # memory_usage.disabled = true;
        # nodejs.disabled = true;
        # package.disabled = true;
        # php.disabled = true;
        # python.disabled = true;
        # ruby.disabled = true;
        # rust.disabled = true;
        # terraform.disabled = true;
        # time.disabled = true;
      };
    };

    programs.zsh.initExtra = ''
      if [[ $TERM != "dumb" && (-z $INSIDE_EMACS || $INSIDE_EMACS == "vterm") ]]; then
        eval "$(${pkgs.starship}/bin/starship init zsh)"
      fi
      '';

  };
}
