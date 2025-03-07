
return {
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local telescope = require("telescope")
            telescope.setup {
                defaults = {
                    hidden = true, -- Permite ver archivos ocultos
                    file_ignore_patterns = { "^.git/", "^node_modules/" }, -- Asegura que deps NO esté en la lista
                },
                pickers = {
                    find_files = {
                        hidden = true,
                        follow = true,
                        no_ignore = true, -- Ignora .gitignore y otras reglas
                    },
                    live_grep = {
                        hidden = true,
                        no_ignore = true, -- Asegura que busque en todos los archivos
                        additional_args = function(opts)
                            return { "--hidden", "--no-ignore", "--glob", "!**/.git/*" }
                        end,
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

            -- Búsqueda de texto en archivos con live_grep
            vim.keymap.set('n', '<C-g>', function()
                builtin.live_grep({
                    hidden = true,
                    no_ignore = true,
                    additional_args = function(opts)
                        return { "--hidden", "--no-ignore", "--glob", "!**/.git/*" }
                    end,
                })
            end, {})
        end
    },
    {
        "nvim-telescope/telescope-ui-select.nvim"
    }
}
