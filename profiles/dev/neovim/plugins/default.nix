{ ... }: {
  imports = [
    # ./coc
    # ./lua-lsp # build failure
    ./bash
    ./css
    # ./fzf
    ./go-lsp
    ./html
    ./json
    ./latex
    ./lspsaga-nvim
    ./lualine-nvim
    ./nvim-autopairs
    ./nvim-compe
    ./nvim-lspconfig
    ./pyright-lsp
    ./rnix-lsp
    # ./skim
    ./svelte-lsp
    ./telescope
    # ./theme
    ./treesitter
    ./typescript-lsp
    ./vimscript-lsp
    ./vim-startify
    ./vsnip
    ./vue-lsp
    ./yaml-lsp
  ];
}