vim.o.background = "dark"
-- vim.cmd[[colorscheme gruvbox]]

vim.o.termguicolors = true
-- vim.cmd[[set termguicolors]]
vim.cmd[[colorscheme base16-rose-pine]]
vim.cmd[[set cursorline]]

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

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

print("after --> hello from after from bigort")


