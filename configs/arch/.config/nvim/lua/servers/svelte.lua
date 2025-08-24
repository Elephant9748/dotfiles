return function(lspconfig, lspconfig_util, capabilities, on_attach)
        -- svelte
        lspconfig.svelte.setup{
                capabilities = capabilities,
                default_config = {
                        cmd = {"svelteserver","--stdio"},
                        filetypes = { "svelte" },
                        root_dir = lspconfig_util.root_pattern('package.json', '.git'),
                },
                on_attach = on_attach,
        }
end
