-- TELESCOPE

require('telescope').setup{
        defaults = {
                layout_strategy = 'vertical',
                layout_config = {
                        vertical = { 
                                width = 0.55,
                                prompt_position = "bottom"
                        },
                        bottom_pane = { 
                                height = 0.40,
                                width = 0.40,
                                prompt_position = "bottom"
                        }
                },
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

