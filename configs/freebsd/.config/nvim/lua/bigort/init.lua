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
-- all keymap & etc
require("bigort.set")

-- where am i
-- print("bigort --> hello from bigort")

-- require("bigort.pckr")
require("bigort.lazynvim")
-- require("lazy").setup("lazyplugs")

require("bigort.telescope")
require("bigort.keymap")
require("bigort.lsp")
require("bigort.cmp")
require("bigort.globals")
require("bigort.lualine")

-- require("bigort.treesitter")

require("catppuccin").setup {
    color_overrides = {
        all = {
            text = "#ffffff",
        },
        latte = {},
        frappe = {},
        macchiato = {},
        mocha = {
            base = "#151515",
            overlay0 = "#3C3836",
        },
    }
}
