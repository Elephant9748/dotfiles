return function(capabilities, on_attach)
        -- Rust rust_analyzer
        vim.lsp.config('rust_analyzer', {
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                        ['rust-analyzer'] = {
                                diagnostics = {
                                        enable = false;
                                }
                        }
                }

        })
        vim.lsp.enable('rust_analyzer')
end
