-- This file can be loaded by calling `lua require('plugins')` from your init.vim
--
-- -- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
     --   Packer can manage itself
     use 'wbthomason/packer.nvim'
     use 'ackyshake/Spacegray.vim'
     use 'dikiaap/minimalist'
     use {
               'nvim-lualine/lualine.nvim',
                 requires = { 'kyazdani42/nvim-web-devicons', opt = true }
         }

     use {
               'nvim-telescope/telescope.nvim', tag = '0.1.0',
               -- or                            , branch = '0.1.x',
                requires = { {'nvim-lua/plenary.nvim'} }
         }
     use {
                'nvim-telescope/telescope-fzf-native.nvim', 
                run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' 
         }
     use {
                'fannheyward/telescope-coc.nvim'
         }
end)
