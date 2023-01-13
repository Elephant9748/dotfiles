-- This file can be loaded by calling `lua require('plugins')` from your init.vim
--
-- -- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
     --   Packer can manage itself
     use 'wbthomason/packer.nvim'
     --
     -- colorscheme
     use 'ackyshake/Spacegray.vim'
     use 'dikiaap/minimalist'
     use { 'nanotech/jellybeans.vim' }
     use { "ryross/ryderbeans" }
     use { "ellisonleao/gruvbox.nvim" }
     use { 'gruvbox-community/gruvbox' }
     use {
             'nvim-lualine/lualine.nvim',
             requires = { 'kyazdani42/nvim-web-devicons', opt = true }
     }
     use { "tinted-theming/base16-vim" }
     use { "vim-scripts/candyman.vim" }
     use { "navarasu/onedark.nvim" }
     use { "rose-pine/neovim" }
     use { "rafi/awesome-vim-colorschemes"}
     use { "tjdevries/gruvbuddy.nvim" }
     use { "tjdevries/colorbuddy.vim" }
     use { "ErichDonGubler/vim-sublime-monokai" }
     use { "aktersnurra/no-clown-fiesta.nvim" }
     use { "srcery-colors/srcery-vim" } 
     use { "ozkanonur/nimda.vim" } 
     -- use { "wincent/base16-nvim" }
     -- use { "bradcush/base16-nvim" }
     --

     use {
             'nvim-telescope/telescope.nvim', tag = '0.1.0',
             -- or                            , branch = '0.1.x',
             requires = { {'nvim-lua/plenary.nvim'} }
     }
     use {
             'nvim-telescope/telescope-fzf-native.nvim', 
             run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' 
     }
     -- use {'neoclide/coc.nvim', branch = 'master', run = 'yarn install --frozen-lockfile'}
     use 'neovim/nvim-lspconfig'  -- Configurations for Nvim LSP
     -- use {
     --            'fannheyward/telescope-coc.nvim'
     --     }


     -- nvim-cmp-lua 
     -- Installation
     use { 'L3MON4D3/LuaSnip' }
     use {
             'hrsh7th/nvim-cmp',
             config = function ()
                     require'cmp'.setup {
                             snippet = {
                                     expand = function(args)
                                             require'luasnip'.lsp_expand(args.body)
                                     end
                             },

                             sources = {
                                     { name = 'luasnip' },
                                     -- more sources
                             },
                     }
             end
     }
     use { 'saadparwaiz1/cmp_luasnip' }
     use { 'hrsh7th/cmp-nvim-lsp' }
     use { 'hrsh7th/cmp-buffer' } 
     use { 'hrsh7th/cmp-path' }

     --treesitter
     --
     use { "nvim-treesitter/nvim-treesitter", run =  ":TSUpdate" }
     use { 'nvim-treesitter/playground' }

 end)
