return {
        {
                'nvim-telescope/telescope.nvim', tag = '0.1.5',
                -- or                            , branch = '0.1.x',
                dependencies = { {'nvim-lua/plenary.nvim'} },
                config = function()
                        require('telescope').setup{
                                defaults = {
                                        layout_strategy = 'bottom_pane',
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
                        
                        -- planery nvim
                        P = function(v)
                                print(vim.inspect(v))
                                return v
                        end

                        RELOAD = function(...)
                                return require("plenary.reload").reload_module(...)
                        end

                        R = function(name)
                                RELOAD(name)
                                return require(name)
                        end

                end,
        },
        {
                'nvim-telescope/telescope-fzf-native.nvim', 
                build = 'make' 
        },

}
