return function(lspconfig, capabilities, on_attach)
        -- pyright
        vim.lsp.config('pyright',{
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                        python = {
                                analysis = {
                                        autoSearchPaths = true,
                                        diagnosticMode = "openFilesOnly",
                                        useLibraryCodeForTypes = true
                                }
                        }
                }
        })

        vim.lsp.enable('pyright')
end
