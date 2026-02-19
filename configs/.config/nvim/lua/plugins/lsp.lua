return {
        'neovim/nvim-lspconfig',
       config = function()
               -- vim.lsp.set_log_level("debug")
               require("servers")
       end,
         
}
