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
        'jakiurcore/fleury.nvim',
        'srcery-colors/srcery-vim',
        'tinted-theming/base16-vim',
        'nanotech/jellybeans.vim',
        -- 'ryross/ryderbeans',
        'gruvbox-community/gruvbox',
}
