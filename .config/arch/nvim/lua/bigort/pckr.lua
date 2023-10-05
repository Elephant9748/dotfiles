local function bootstrap_pckr()
  local pckr_path = vim.fn.stdpath("data") .. "/pckr/pckr.nvim"

  if not vim.loop.fs_stat(pckr_path) then
    vim.fn.system({
      'git',
      'clone',
      "--filter=blob:none",
      'https://github.com/lewis6991/pckr.nvim',
      pckr_path
    })
  end

  vim.opt.rtp:prepend(pckr_path)
end

bootstrap_pckr()

local cmd = require('pckr.loader.cmd')
local keys = require('pckr.loader.keys')

require('pckr').add{
  -- colorscheme
  -- use 'ackyshake/Spacegray.vim'
  'dikiaap/minimalist';
  { 'nanotech/jellybeans.vim' };
  { "ryross/ryderbeans" };
  { "ellisonleao/gruvbox.nvim" };
  { 'gruvbox-community/gruvbox' };
  {
          'nvim-lualine/lualine.nvim',
          requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  };
  { "tinted-theming/base16-vim" };
  { "vim-scripts/candyman.vim" };
  { "navarasu/onedark.nvim" };
  -- use { "rose-pine/neovim" }
  { "rafi/awesome-vim-colorschemes"};
  { "tjdevries/gruvbuddy.nvim" };
  { "tjdevries/colorbuddy.vim" };
  { "ErichDonGubler/vim-sublime-monokai" };
  { "aktersnurra/no-clown-fiesta.nvim" };
  { "srcery-colors/srcery-vim" }; 
  { "ozkanonur/nimda.vim" }; 
  -- use { "wincent/base16-nvim" }
  -- use { "bradcush/base16-nvim" }
  --

  {
          'nvim-telescope/telescope.nvim', tag = '0.1.0',
          -- or                            , branch = '0.1.x',
          requires = { {'nvim-lua/plenary.nvim'} }
  };
  {
          'nvim-telescope/telescope-fzf-native.nvim', 
          run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' 
  };
  -- use {'neoclide/coc.nvim', branch = 'master', run = 'yarn install --frozen-lockfile'}
  'neovim/nvim-lspconfig';  -- Configurations for Nvim LSP
  -- use {
  --            'fannheyward/telescope-coc.nvim'
  --     }
  { 'L3MON4D3/LuaSnip' };
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
  };
  { 'saadparwaiz1/cmp_luasnip' };
  { 'hrsh7th/cmp-nvim-lsp' };
  { 'hrsh7th/cmp-buffer' };
  { 'hrsh7th/cmp-path' };

  --treesitter
  --
  { 'nvim-treesitter/nvim-treesitter', run =  ':TSUpdate' };
  { 'nvim-treesitter/playground' };
}


