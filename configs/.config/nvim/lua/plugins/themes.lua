return {
        { 
                'Elephant9748/rigel254-colorscheme', 
                config = function()
                        -- must term gui on
                        vim.cmd("colorscheme rigel254-colorscheme-dark") 

                        -- vim.cmd [[
                        --         highlight Normal guibg=none
                        --         highlight NonText guibg=none
                        --         highlight Normal ctermbg=none
                        --         highlight NonText ctermbg=none
                        --         highlight NormalFloat ctermbg=none
                        --         highlight NeoTreeNormalNC ctermbg=none
                        --         highlight NeoTreeNormal ctermbg=none
                        -- ]]
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
