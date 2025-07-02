return {
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require("telescope").setup({
                defaults = {
                    file_ignore_patterns = {
                        "build/.*",     -- Ignore everything under build directory
                        "%.git/.*",     -- Ignore .git directories
                        "%.venv/.*",    -- Ignore .venv directories
                        "%.cache/.*",   -- Ignore .cache directories
                        "%.hex$"        -- Ignore .hex files
                    }
                },
                pickers = {
                    find_files = {
                        hidden = true,
                        no_ignore = true,
                        follow = true,  -- Follow symbolic links
                        depth = 8,      -- Increase search depth to reach nested deps folders
                        file_ignore_patterns = {
                            "build/.*",     -- Ignore everything under build directory
                            "%.git/.*",     -- Ignore .git directories
                            "%.venv/.*",    -- Ignore .venv directories
                            "%.cache/.*",   -- Ignore .cache directories
                            "%.hex$"        -- Ignore .hex files
                        }
                    },
                    grep_string = {
                        additional_args = function()
                            return {
                                "--hidden",
                                "--no-ignore",
                                "--follow",   -- Follow symbolic links
                                "--max-depth=8",  -- Search deeper in directory structure
                                "--glob=!build/**",  -- Exclude build directory for ripgrep
                                "--glob=!.git/**",   -- Exclude .git directories for ripgrep
                                "--glob=!.venv/**",  -- Exclude .venv directories for ripgrep
                                "--glob=!.cache/**", -- Exclude .cache directories for ripgrep
                                "--glob=!*.hex"      -- Exclude .hex files for ripgrep
                            }
                        end,
                        no_ignore = true
                    },
                    live_grep = {
                        additional_args = function()
                            return {
                                "--hidden",
                                "--no-ignore",
                                "--follow",   -- Follow symbolic links
                                "--max-depth=8",  -- Search deeper in directory structure
                                "--glob=!build/**",  -- Exclude build directory for ripgrep
                                "--glob=!.git/**",   -- Exclude .git directories for ripgrep
                                "--glob=!.venv/**",  -- Exclude .venv directories for ripgrep
                                "--glob=!.cache/**", -- Exclude .cache directories for ripgrep
                                "--glob=!*.hex"      -- Exclude .hex files for ripgrep
                            }
                        end,
                        no_ignore = true
                    },
                },
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown {
                        }
                    }
                }
            })

            -- Mapeo para buscar una función en todo el directorio actual
            vim.keymap.set("n", "<leader>ff", function()
                require("telescope.builtin").live_grep({
                    search_dirs = { vim.fn.getcwd() },  -- Busca en el directorio actual
                    hidden = true,
                    no_ignore = true,
                    additional_args = {
                        "--hidden",
                        "--no-ignore",
                        "--follow",
                        "--max-depth=8",
                        "--glob=!build/**",
                        "--glob=!.git/**",
                        "--glob=!.venv/**",
                        "--glob=!.cache/**",
                        "--glob=!*.hex"
                    }
                })
            end, { noremap = true, silent = true, desc = "Buscar función en directorio actual" })

            -- Mapeo para buscar la palabra bajo el cursor en todo el directorio actual
            vim.keymap.set("n", "<leader>gw", function()
                require("telescope.builtin").grep_string({
                    word_match = "-w",  -- Busca la palabra exacta (whole word)
                    search_dirs = { vim.fn.getcwd() },  -- Busca en el directorio actual
                    hidden = true,
                    no_ignore = true,
                    additional_args = {
                        "--hidden",
                        "--no-ignore",
                        "--follow",
                        "--max-depth=8",
                        "--glob=!build/**",
                        "--glob=!.git/**",
                        "--glob=!.venv/**",
                        "--glob=!.cache/**",
                        "--glob=!*.hex"
                    }
                })
            end, { noremap = true, silent = true, desc = "Buscar palabra bajo el cursor en directorio actual" })

            vim.keymap.set("n", "<leader>fe", function()
                -- Pedir al usuario el término a buscar
                local search_term = vim.fn.input("Buscar término: ")
                if search_term == "" then return end

                -- Pedir los términos a excluir (separados por coma)
                local exclude_terms = vim.fn.input("Excluir términos (separados por coma): ")
                local exclude_args = {}

                -- Procesar términos excluidos
                if exclude_terms ~= "" then
                    for term in string.gmatch(exclude_terms, "([^,]+)") do
                        term = string.gsub(term, "^%s*(.-)%s*$", "%1") -- trim
                        table.insert(exclude_args, "--glob=!" .. term)
                    end
                end

            -- Configurar argumentos adicionales para ripgrep
            local additional_args = {
                "--hidden",
                "--no-ignore",
                "--follow",
                "--max-depth=8",
                "--glob=!build/**",
                "--glob=!.git/**",
                "--glob=!.venv/**",
                "--glob=!.cache/**",
                "--glob=!*.hex"
            }

            -- Añadir los términos excluidos a los argumentos
            for _, arg in ipairs(exclude_args) do
                table.insert(additional_args, arg)
            end

            -- Ejecutar la búsqueda
            require("telescope.builtin").find_files({
                search_dirs = { vim.fn.getcwd() },
                hidden = true,
                no_ignore = true,
                additional_args = additional_args,
                search_file = search_term
            })
        end, { noremap = true, silent = true, desc = "Búsqueda avanzada de archivos con exclusiones" })
        end
    },
    {
        'nvim-telescope/telescope-ui-select.nvim',
        config = function()
            require("telescope").load_extension("ui-select")
        end
    },
}
