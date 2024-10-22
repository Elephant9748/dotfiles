-- ├── after
-- │   └── plugin
-- │       └── bigort
-- │           └── init.lua
-- ├── init.lua
-- ├── init.vim.backup
-- ├── lazy-lock.json
-- ├── lua
-- │   └── bigort
-- │       ├── cmp.lua
-- │       ├── globals.lua
-- │       ├── init.lua
-- │       ├── keymap.lua
-- │       ├── lazynvim.lua
-- │       ├── lsp.lua
-- │       ├── lualine.lua
-- │       ├── packer.lua
-- │       ├── pckr.lua
-- │       ├── set.lua
-- │       ├── telescope.lua
-- │       └── treesitter.lua
-- └── plugin
-- 

vim.o.background = "dark"

vim.o.termguicolors = true
vim.o.cursorline = true

-- Set colorscheme move to lazy.nvim
-- ---------------------------------------
-- vim.cmd([[colorscheme jellybeans]])
-- vim.cmd[[colorscheme gruvbox]]
-- vim.cmd([[colorscheme ryderbeans]])
-- vim.cmd([[colorscheme base16-gruvbox-dark-hard]])
-- vim.cmd([[colorscheme gruvbox]])
-- vim.cmd([[colorscheme base16-catppuccin]])
-- vim.cmd([[colorscheme paramount]])
-- vim.cmd([[colorscheme sublimemonokai]])
-- vim.cmd([[colorscheme no-clown-fiesta]])

-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })


-- FOR SOME REASON CMP NOT SOURCE CORRECTLY
vim.cmd([[so $HOME/.config/nvim/lua/bigort/cmp.lua]])

-- print("after --> hello from after from bigort")


-- require('rose-pine').setup({
--         disable_background = true
-- })
-- 
-- function ColorMyPencils(color) 
--         color = color or "rose-pine"
--         vim.cmd.colorscheme(color)
-- 
--         vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
--         vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
-- 
-- end
-- 
-- ColorMyPencils()


