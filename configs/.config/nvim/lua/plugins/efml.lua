return {
        {
                'creativenull/efmls-configs-nvim',
                version = 'v1.11.0', -- version is optional, but recommended
                dependencies = { 'neovim/nvim-lspconfig' }, -- not required if using nvim >= 0.11
                config = function()
                        local eslint = require('efmls-configs.linters.eslint') -- need bin eslint
                        local prettier = require('efmls-configs.formatters.prettier') -- need bin prettier
                        local stylelint = require('efmls-configs.linters.stylelint') -- need bin stylelint

                        local languages = {
                                typescript = { eslint, prettier },
                                javascript = { eslint, prettier },
                                html = { prettier },
                                css = { stylelint, prettier },
                                svelte = { eslint, prettier },
                                markdown = { prettier },
                        }

                        local efmls_config = {
                                filetypes = vim.tbl_keys(languages),
                                settings = {
                                        rootMarkers = { '.git/' },
                                        languages = languages,
                                },
                                init_options = {
                                        documentFormatting = true,
                                        documentRangeFormatting = true,
                                },
                        }

                        vim.lsp.config('efm', vim.tbl_extend('force', efmls_config, {
                                cmd = { 'efm-langserver' }, -- need bin efm-langserver
                                capabilities = capabilities,
                                on_attach = on_attach,
                        }))
                        vim.lsp.enable('efm')

                        -- register format on save
                        local lsp_fmt_group = vim.api.nvim_create_augroup('LspFormattingGroup', {})
                        vim.api.nvim_create_autocmd('BufWritePost', {
                                group = lsp_fmt_group,
                                callback = function(ev)
                                        local efm = vim.lsp.get_clients({ name = 'efm', bufnr = ev.buf })

                                        if vim.tbl_isempty(efm) then
                                                return
                                        end

                                        vim.lsp.buf.format({ name = 'efm' })
                                end,
                        })
                end,
        }
}
