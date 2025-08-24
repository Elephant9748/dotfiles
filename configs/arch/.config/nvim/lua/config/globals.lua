vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- the thing that give you vertical line
-- vim.opt.colorcolumn = "120"
vim.api.nvim_set_option_value("colorcolumn","140", {})

vim.opt.smartindent = true

vim.opt.wrap = false

vim.g.mapleader = " "

-- svelte 
vim.g.svelte_indent_script = 0
vim.g.svelte_indent_style = 0


local modes = {
                ["n"] = "NORMAL",
                ["no"] = "NORMAL",
                ["v"] = "VISUAL",
                ["V"] = "VISUAL LINE",
                ["s"] = "SELECT",
                ["S"] = "SELECT LINE",
                [""] = "SELECT BLOCK",
                ["i"] = "INSERT",
                ["ic"] = "INSERT",
                ["R"] = "REPLACE",
                ["Rv"] = "VISUAL REPLACE",
                ["c"] = "COMMAND",
                ["cv"] = "VIM EX",
                ["ce"] = "EX",
                ["r"] = "PROMPT",
                ["rm"] = "MOAR",
                ["r?"] = "CONFIRM",
                ["!"] = "SHELL",
                ["t"] = "TERMINAL",
        }

local function mode()
        local current_mode = api.nvim_get_mode().mode
        return string.format(" %s", modes[current_mode]):upper()
end


-- OLD AFTER
vim.o.background = "dark"
-- vim.g.gruvbox_contrast_dark = "hard"

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
-- vim.cmd([[so $HOME/.config/nvim/lua/bigort/cmp.lua]])

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


