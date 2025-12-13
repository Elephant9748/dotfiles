return {
        { 
                'Elephant9748/rigel254-colorscheme', 
                config = function()
                        -- must term gui on
                        vim.cmd("colorscheme rigel254-colorscheme-green") 
                end,
        },
        'tinted-theming/base16-vim',
        'stevedylandev/darkmatter-nvim',
        'nanotech/jellybeans.vim',
        -- 'ryross/ryderbeans',
        'gruvbox-community/gruvbox',
        'vim-scripts/candyman.vim',
        'rafi/awesome-vim-colorschemes',
        {
                "catppuccin/nvim", name = "catppuccin", priority = 1000 
        },
}
