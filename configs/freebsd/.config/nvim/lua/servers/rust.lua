return function(lspconfig, capabilities, on_attach)
        -- Rust rust_analyzer
        lspconfig.rust_analyzer.setup{
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                        ['rust-analyzer'] = {
                                diagnostics = {
                                        enable = false;
                                }
                        }
                }

        }
end
