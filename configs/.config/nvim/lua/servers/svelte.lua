return function(lspconfig, lspconfig_util, capabilities, on_attach)
        -- svelte
        vim.lsp.config('svelte',{
                capabilities = capabilities,
                default_config = {
                        cmd = {"svelteserver","--stdio"},
                        filetypes = { "svelte" },
                        root_markers = { 'package.json', '.git'},
                },
                on_attach = on_attach,
        })

        vim.lsp.enable('svelte')
end
