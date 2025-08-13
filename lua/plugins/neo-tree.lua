return {
    {
        'nvim-neo-tree/neo-tree.nvim',
        branch = 'v3.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons',
            'MunifTanjim/nui.nvim',
        },
        config = function()
            -- Aplicar el esquema de colores ANTES de configurar NeoTree
            -- vim.cmd("colorscheme tokyonight-moon")
            -- Forzar transparencia con un pequeño retraso
            vim.defer_fn(function()
                vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "NONE" })
                vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "NONE" })
                vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { bg = "NONE", fg = "NONE" })
                vim.api.nvim_set_hl(0, "NeoTreeVertSplit", { bg = "NONE", fg = "#3d59a1" })
                vim.api.nvim_set_hl(0, "NeoTreeWinSeparator", { bg = "NONE", fg = "#3d59a1" })

                -- Colores especiales para archivos ocultos
                vim.api.nvim_set_hl(0, "NeoTreeDotfile", { fg = "#7c6f64", italic = true })
                vim.api.nvim_set_hl(0, "NeoTreeHiddenFolder", { fg = "#83a598", italic = true })
            end, 50)

            -- Configuración de NeoTree
            require("neo-tree").setup({
                close_if_last_window = true,
                enable_git_status = true,
                enable_diagnostics = true,
                filesystem = {
                    filtered_items = {
                        visible = true,        -- CAMBIADO: Ahora muestra elementos filtrados
                        hide_dotfiles = false, -- CAMBIADO: Ahora muestra dotfiles
                        hide_gitignored = false,
                        hide_hidden = false,   -- AÑADIDO: Muestra archivos ocultos del sistema
                        never_show = {         -- AÑADIDO: Lista de archivos que nunca mostrar
                            ".DS_Store",
                            "thumbs.db",
                        },
                        never_show_by_pattern = { -- AÑADIDO: Patrones que nunca mostrar
                            --".null-ls_*",
                        },
                    },
                    follow_current_file = { enabled = true },
                    use_libuv_file_watcher = true,
                    hijack_netrw_behavior = "open_default", -- AÑADIDO: Mejor integración
                },
                default_component_configs = {
                    icon = {
                        folder_closed = "",
                        folder_open = "",
                        folder_empty = "",
                        default = "",
                    },
                    modified = { symbol = "[+]" },
                    git_status = {
                        symbols = {
                            added     = "✚",
                            deleted   = "✖",
                            modified  = "",
                            renamed   = "",
                            untracked = "",
                            ignored   = "",
                            unstaged  = "✗",
                            staged    = "✓",
                            conflict  = "",
                        },
                    },
                    name = {
                        use_git_status_colors = true,
                        highlight = "NeoTreeFileName",
                    },
                },
                window = {
                    width = 35,
                    mappings = {
                        ["<CR>"] = "open_with_window_picker",
                        ["o"] = "open",
                        ["O"] = "open_with_window_picker",
                        ["H"] = "toggle_hidden", -- AÑADIDO: Alternar visibilidad de archivos ocultos
                        ["<F5>"] = "refresh",    -- AÑADIDO: Refrescar vista
                    },
                },
                -- Función para alternar archivos ocultos
                commands = {
                    toggle_hidden = function(state)
                        state.filtered_items.visible = not state.filtered_items.visible
                        require("neo-tree.sources.manager").refresh(state.name)
                    end,
                },
            })

            -- Mensaje informativo una sola vez
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "neo-tree",
                callback = function()
                    -- Usar un timer para mostrar el mensaje después de que Neo-tree se haya cargado completamente
                    vim.defer_fn(function()
                        if vim.fn.has('nvim-0.8') == 1 then
                            vim.notify("💡 Presiona 'H' en Neo-tree para alternar archivos ocultos", vim.log.levels.INFO, {
                                title = "Neo-tree",
                                timeout = 3000,
                            })
                        else
                            print("💡 Presiona 'H' en Neo-tree para alternar archivos ocultos")
                        end
                    end, 1000)
                end,
                once = true,
            })
        end
    }
}
