
local opt = { noremap = true, silent = true }

local builtin = require('telescope.builtin')
-- vim.keymap.set('n', 'ff', builtin.find_files, {})
-- vim.keymap.set('n', 'fg', builtin.live_grep, {})
-- vim.keymap.set('n', 'fb', builtin.buffers, {})
-- vim.keymap.set('n', 'fh', builtin.help_tags, {})

-- Mappings

vim.keymap.set('n', 'tc', '<cmd>Telescope current_buffer_fuzzy_find sorting_strategy=ascending<cr>', {buffer=0})

-- CUSTOM lua mapping
-- local mappings = {}
-- 
-- mappings.curr_buff = function() 
--         local opt = require('telescope.themes').get_ivy({sorting_strategy="ascending",})
--         -- local opt = require('telescope.themes').get_dropdown({height=10})
--         require('telescope.builtin').current_buffer_fuzzy_find(opt)
-- end
-- return mappings

