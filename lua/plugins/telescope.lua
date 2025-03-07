
return {
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-fzf-native.nvim' },
        build = 'make', -- Necesario para compilar fzf-native
        config = function()
            local telescope = require("telescope")
            telescope.setup {
                defaults = {
                    hidden = true,
                    file_ignore_patterns = { "^.git/" },
                    sorting_strategy = "descending", -- Ahora los archivos más significativos aparecen primero
                    layout_config = {
                        prompt_position = "bottom", -- Mueve el cursor a la parte inferior
                    }
                },
                pickers = {
                    find_files = {
                        hidden = true,
                        follow = true,
                        no_ignore = true,
                    },
                    live_grep = {
                        hidden = true,
                        no_ignore = true,
                        additional_args = function()
                            return { "--hidden", "--no-ignore", "--glob", "!**/.git/*" }
                        end,
                    }
                },
                extensions = {
                    fzf = {
                        fuzzy = true, -- Habilita búsqueda difusa
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case",
                    },
                },
            }

            telescope.load_extension("fzf")

            local builtin = require("telescope.builtin")

            -- Keymaps para abrir búsquedas con Telescope
            vim.keymap.set('n', '<C-s>', function()
                builtin.find_files({
                    hidden = true,
                    no_ignore = true,
                })
            end, {})

            vim.keymap.set('n', '<C-g>', function()
                builtin.live_grep({
                    hidden = true,
                    no_ignore = true,
                    additional_args = function()
                        return { "--hidden", "--no-ignore", "--glob", "!**/.git/*" }
                    end,
                })
            end, {})

            -- Hacer el fondo de Telescope transparente
            vim.cmd [[
                hi TelescopeNormal guibg=NONE ctermbg=NONE
                hi TelescopeBorder guibg=NONE ctermbg=NONE
                hi TelescopePromptNormal guibg=NONE ctermbg=NONE
                hi TelescopePromptBorder guibg=NONE ctermbg=NONE
                hi TelescopeResultsNormal guibg=NONE ctermbg=NONE
                hi TelescopeResultsBorder guibg=NONE ctermbg=NONE
                hi TelescopePreviewNormal guibg=NONE ctermbg=NONE
                hi TelescopePreviewBorder guibg=NONE ctermbg=NONE
            ]]
        end
    },
    {
        "nvim-telescope/telescope-ui-select.nvim"
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
    }
}
