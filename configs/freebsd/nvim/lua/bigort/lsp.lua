
-- LSP 

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Lua
require'lspconfig'.luau_lsp.setup{
        capabilities = capabilities,
        on_attach = function()
                vim.keymap.set("n","K", vim.lsp.buf.hover, {buffer=0})
                vim.keymap.set("n","gd", vim.lsp.buf.definition, {buffer=0})
                vim.keymap.set("n","gT", vim.lsp.buf.type_definition, {buffer=0})
                vim.keymap.set("n","<leader>i", vim.lsp.buf.implementation, {buffer=0})
                vim.keymap.set("n","<leader>dj", vim.diagnostic.goto_next, {buffer=0})
                vim.keymap.set("n","<leader>dk", vim.diagnostic.goto_prev, {buffer=0})
                vim.keymap.set("n","<leader>ds", "<cmd>Telescope diagnostics<cr>", {buffer=0})
                vim.keymap.set("n","<leader>f", "<cmd>Telescope git_files<cr>", {buffer=0})
                vim.keymap.set("n","<leader>r", vim.lsp.buf.rename, {buffer=0})
                vim.keymap.set("n", "tc", "<cmd>Telescope current_buffer_fuzzy_find sorting_strategy=ascending<cr>", {buffer=0})
                -- vim.keymap.set("n", "<leader>1", "<cmd>move +1<cr>", {buffer=0})
                -- vim.keymap.set("n", "<leader>2", "<cmd>move -2<cr>", {buffer=0})
                vim.keymap.set("v", "K", ":m '>+1<CR>gv=gv", {buffer=0})
                vim.keymap.set("v", "J", ":m '<-2<CR>gv=gv", {buffer=0})
                vim.keymap.set("n", "<C-d>", "<C-d>zz")
                vim.keymap.set("n", "<C-u>", "<C-u>zz")
                -- asbjornHaland
                vim.keymap.set("n", "<leader>y", "\"+y")
                vim.keymap.set("v", "<leader>y", "\"+y")
                vim.keymap.set("n", "<leader>Y", "\"+Y")

                --
                vim.keymap.set("i", "<C-c>", "<Esc>")
                vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
                vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

                -- stop semantic_token current buffer
                vim.keymap.set("n","<leader>h", "<cmd>lua =vim.lsp.semantic_tokens.stop(vim.api.nvim_buf_get_number(0), 1)<cr>", {buffer=0})
                -- vim.keymap.set("n","<leader>q", "<cmd>lua =vim.api.nvim_buf_get_number(0)<cr>", {buffer=0})

                -- start semantic_token current buffer
                vim.keymap.set("n","<leader>H", "<cmd>lua =vim.lsp.semantic_tokens.start(vim.api.nvim_buf_get_number(0), 1)<cr>", {buffer=0})
        end,
}

-- Python pyright
require'lspconfig'.pyright.setup{
        capabilities = capabilities,
        on_attach = function()
                vim.keymap.set("n","K", vim.lsp.buf.hover, {buffer=0})
                vim.keymap.set("n","gd", vim.lsp.buf.definition, {buffer=0})
                vim.keymap.set("n","gT", vim.lsp.buf.type_definition, {buffer=0})
                vim.keymap.set("n","<leader>i", vim.lsp.buf.implementation, {buffer=0})
                vim.keymap.set("n","<leader>dj", vim.diagnostic.goto_next, {buffer=0})
                vim.keymap.set("n","<leader>dk", vim.diagnostic.goto_prev, {buffer=0})
                vim.keymap.set("n","<leader>ds", "<cmd>Telescope diagnostics<cr>", {buffer=0})
                vim.keymap.set("n","<leader>r", vim.lsp.buf.rename, {buffer=0})
                vim.keymap.set("n", "tc", "<cmd>Telescope current_buffer_fuzzy_find sorting_strategy=ascending<cr>", {buffer=0})
                vim.keymap.set("v", "K", ":m '>+1<CR>gv=gv", {buffer=0})
                vim.keymap.set("v", "J", ":m '<-2<CR>gv=gv", {buffer=0})
                vim.keymap.set("n", "<C-d>", "<C-d>zz")
                vim.keymap.set("n", "<C-u>", "<C-u>zz")
                -- asbjornHaland
                vim.keymap.set("n", "<leader>y", "\"+y")
                vim.keymap.set("v", "<leader>y", "\"+y")
                vim.keymap.set("n", "<leader>Y", "\"+Y")

                --
                vim.keymap.set("i", "<C-c>", "<Esc>")
                vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
        end,

}


-- Rust rust_analyzer
require'lspconfig'.rust_analyzer.setup{
        capabilities = capabilities,
        on_attach = function()
                vim.keymap.set("n","K", vim.lsp.buf.hover, {buffer=0})
                vim.keymap.set("n","gd", vim.lsp.buf.definition, {buffer=0})
                vim.keymap.set("n","gT", vim.lsp.buf.type_definition, {buffer=0})
                vim.keymap.set("n","<leader>i", vim.lsp.buf.implementation, {buffer=0})
                vim.keymap.set("n","<leader>dj", vim.diagnostic.goto_next, {buffer=0})
                vim.keymap.set("n","<leader>dk", vim.diagnostic.goto_prev, {buffer=0})
                vim.keymap.set("n","<leader>ds", "<cmd>Telescope diagnostics<cr>", {buffer=0})
                vim.keymap.set("n","<leader>f", "<cmd>Telescope git_files<cr>", {buffer=0})
                vim.keymap.set("n","<leader>r", vim.lsp.buf.rename, {buffer=0})
                vim.keymap.set("n", "tc", "<cmd>Telescope current_buffer_fuzzy_find sorting_strategy=ascending<cr>", {buffer=0})
                -- vim.keymap.set("n", "<leader>1", "<cmd>move +1<cr>", {buffer=0})
                -- vim.keymap.set("n", "<leader>2", "<cmd>move -2<cr>", {buffer=0})
                vim.keymap.set("v", "K", ":m '>+1<CR>gv=gv", {buffer=0})
                vim.keymap.set("v", "J", ":m '<-2<CR>gv=gv", {buffer=0})
                vim.keymap.set("n", "<C-d>", "<C-d>zz")
                vim.keymap.set("n", "<C-u>", "<C-u>zz")
                -- asbjornHaland
                vim.keymap.set("n", "<leader>y", "\"+y")
                vim.keymap.set("v", "<leader>y", "\"+y")
                vim.keymap.set("n", "<leader>Y", "\"+Y")

                --
                vim.keymap.set("i", "<C-c>", "<Esc>")
                vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
                vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

                -- stop semantic_token current buffer
                vim.keymap.set("n","<leader>h", "<cmd>lua =vim.lsp.semantic_tokens.stop(vim.api.nvim_buf_get_number(0), 1)<cr>", {buffer=0})
                -- vim.keymap.set("n","<leader>q", "<cmd>lua =vim.api.nvim_buf_get_number(0)<cr>", {buffer=0})

                -- start semantic_token current buffer
                vim.keymap.set("n","<leader>H", "<cmd>lua =vim.lsp.semantic_tokens.start(vim.api.nvim_buf_get_number(0), 1)<cr>", {buffer=0})
        end,

}

local util = require 'lspconfig.util'
require'lspconfig'.svelte.setup{
        capabilities = capabilities,
        default_config = {
                cmd = {"svelteserver","--stdio"},
                filetypes = { "svelte" },
                root_dir = util.root_pattern('package.json', '.git'),
        },
        on_attach = function()
                vim.keymap.set("n","K", vim.lsp.buf.hover, {buffer=0})
                vim.keymap.set("n","gd", vim.lsp.buf.definition, {buffer=0})
                vim.keymap.set("n","gT", vim.lsp.buf.type_definition, {buffer=0})
                vim.keymap.set("n","<leader>i", vim.lsp.buf.implementation, {buffer=0})
                vim.keymap.set("n","<leader>dj", vim.diagnostic.goto_next, {buffer=0})
                vim.keymap.set("n","<leader>dk", vim.diagnostic.goto_prev, {buffer=0})
                vim.keymap.set("n","<leader>ds", "<cmd>Telescope diagnostics<cr>", {buffer=0})
                vim.keymap.set("n","<leader>f", "<cmd>Telescope git_files<cr>", {buffer=0})
                vim.keymap.set("n","<leader>r", vim.lsp.buf.rename, {buffer=0})
                vim.keymap.set("n", "tc", "<cmd>Telescope current_buffer_fuzzy_find sorting_strategy=ascending<cr>", {buffer=0})
                -- vim.keymap.set("n", "<leader>1", "<cmd>move +1<cr>", {buffer=0})
                -- vim.keymap.set("n", "<leader>2", "<cmd>move -2<cr>", {buffer=0})
                vim.keymap.set("v", "K", ":m '>+1<CR>gv=gv", {buffer=0})
                vim.keymap.set("v", "J", ":m '<-2<CR>gv=gv", {buffer=0})
                vim.keymap.set("n", "<C-d>", "<C-d>zz")
                vim.keymap.set("n", "<C-u>", "<C-u>zz")
                -- asbjornHaland
                vim.keymap.set("n", "<leader>y", "\"+y")
                vim.keymap.set("v", "<leader>y", "\"+y")
                vim.keymap.set("n", "<leader>Y", "\"+Y")

                --
                vim.keymap.set("i", "<C-c>", "<Esc>")
                vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
                vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

                -- stop semantic_token current buffer
                vim.keymap.set("n","<leader>h", "<cmd>lua =vim.lsp.semantic_tokens.stop(vim.api.nvim_buf_get_number(0), 1)<cr>", {buffer=0})
                -- vim.keymap.set("n","<leader>q", "<cmd>lua =vim.api.nvim_buf_get_number(0)<cr>", {buffer=0})

                -- start semantic_token current buffer
                vim.keymap.set("n","<leader>H", "<cmd>lua =vim.lsp.semantic_tokens.start(vim.api.nvim_buf_get_number(0), 1)<cr>", {buffer=0})
        end,
}


-- END LSP


