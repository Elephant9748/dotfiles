return {
     'nvim-lualine/lualine.nvim',
     config = function()
	     local custom_lualine = require"lualine.themes.gruvbox_dark"
	     require("lualine").setup {
		     options = { theme = custom_lualine },
	     }

     end,
     dependencies = { 'kyazdani42/nvim-web-devicons', opt = true }
}
