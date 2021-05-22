{ config, inputs, lib, pkgs, ... }:

let
in {
  nixpkgs.overlays = [ inputs.neovim-nightly.overlay ];
  my.home = {

      home.packages = with pkgs; [
          neovim-nightly
          rnix-lsp
          rust-analyzer
          gopls
          nodePackages.pyright
      ];
      xdg.configFile."nvim/init.lua".source = ./init.lua;
      xdg.configFile."nvim/parser/c.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-c}/parser";
      # xdg.configFile."nvim/parser/lua.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-lua}/parser";
      xdg.configFile."nvim/parser/rust.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-rust}/parser";
  };
}
