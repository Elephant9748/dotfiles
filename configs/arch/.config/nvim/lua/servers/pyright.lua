return function(lspconfig, capabilities, on_attach)
        -- pyright
        lspconfig.pyright.setup{
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
        }
end
