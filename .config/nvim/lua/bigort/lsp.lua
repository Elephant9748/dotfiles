
-- LSP 

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

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
                vim.keymap.set("n","<leader>r", vim.lsp.buf.rename, {buffer=0})
        end,

}

-- END LSP


