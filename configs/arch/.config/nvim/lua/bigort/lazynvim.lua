-- Important buile manual in $HOME/.local/share/nvim/lazy/<repo name>
--

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
     {
             'numToStr/Comment.nvim',
             config = function()
                     require('Comment').setup()
             end,
     },
     {
             'junegunn/fzf.vim',
             dependencies = {
                     { 'junegunn/fzf', build = './install --all' },
             },
             config = function()
                     vim.g.fzf_layout = {  down= '~15%' }
             end,
     },
     -- svelte
     { 'othree/html5.vim' },
     { 'pangloss/vim-javascript'},
     { 'evanleck/vim-svelte' },
     -- colorscheme
     'dikiaap/minimalist',
     {
             'nanotech/jellybeans.vim',
             -- config = function()
             --         vim.cmd([[
             --         colorscheme jellybeans 
             --
             --         " transparent background
             --         " highlight Normal guibg=none
             --         " highlight NonText guibg=none
             --         " highlight Normal ctermbg=none
             --         " highlight NonText ctermbg=none
             --         ]])
             -- end,
     },
     {
             "catppuccin/nvim", name = "catppuccin", priority = 1000 
     },
     {
             'Elephant9748/rigel254-colorscheme',
             config = function()
                     vim.cmd([[
                                colorscheme rigel254-colorscheme-green
                     ]])
             end,
     },
     -- 'ryross/ryderbeans',
     'gruvbox-community/gruvbox',
     {
             'nvim-lualine/lualine.nvim',
             dependencies = { 'kyazdani42/nvim-web-devicons', opt = true }
     },
     'tinted-theming/base16-vim',
     'vim-scripts/candyman.vim',
     'rafi/awesome-vim-colorschemes',
     {
             'nvim-telescope/telescope.nvim', tag = '0.1.5',
             -- or                            , branch = '0.1.x',
             dependencies = { {'nvim-lua/plenary.nvim'} }
     },
     {
             'nvim-telescope/telescope-fzf-native.nvim', 
             build = 'make' 
     },
     {
             'neovim/nvim-lspconfig',  -- Configurations for Nvim LSP 
             config = function()
                     vim.cmd([[
                             lua vim.lsp.set_log_level("debug")
                     ]])
             end,
     },
     -- Installation
     'L3MON4D3/LuaSnip',
     {
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
     },
     'saadparwaiz1/cmp_luasnip',
     'hrsh7th/cmp-nvim-lsp',
     'hrsh7th/cmp-buffer',
     'hrsh7th/cmp-path',

     --treesitter
     --
     { 'nvim-treesitter/nvim-treesitter', build =  ':TSUpdate' },
     'nvim-treesitter/playground'

 })
