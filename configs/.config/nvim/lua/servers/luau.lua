return function(lspconfig, capabilities, on_attach)
        -- luau
        vim.lsp.config('luau_lsp', {
                capabilities = capabilities,
                on_attach = on_attach,
        })

        vim.lsp.enable('luau_lsp')
end
