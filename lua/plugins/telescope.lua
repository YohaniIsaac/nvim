return {
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local telescope = require("telescope")
            telescope.setup {
                defaults = {
                    hidden = true,
                    file_ignore_patterns = { "^.git/" },
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
                    }
                }
            }

            local builtin = require("telescope.builtin")

            -- Búsqueda de archivos
            vim.keymap.set('n', '<C-s>', function()
                builtin.find_files({
                    hidden = true,
                    no_ignore = true,
                })
            end, {})

            -- Búsqueda de texto/funciones
            vim.keymap.set('n', '<C-g>', function()
                builtin.live_grep({
                    hidden = true,
                    no_ignore = true,
                })
            end, {})
        end
    },
    {
        "nvim-telescope/telescope-ui-select.nvim"
    }
}
