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


