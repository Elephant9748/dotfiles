-- TELESCOPE

require('telescope').setup{
        defaults = {
                prompt_prefix = "$ ",
                mappings = {
                        i = {
                                ["<C-h>"] = "which_key"
                        }
                }
        },
        pickers = {

        },
        extensions = {
                fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case",
                },
                coc = {
                        theme = 'ivy',
                        prefer_locations = true,
                }

        }
}

require('telescope').load_extension('fzf')
-- require('telescope').load_extension('coc')

