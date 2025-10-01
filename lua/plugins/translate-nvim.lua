-- ============================================
-- TRANSLATE.NVIM - TRANSLATION PLUGIN
-- ============================================
-- Supports Google Translate, DeepL, and translate-shell

return {
    {
        "uga-rosa/translate.nvim",
        cmd = "Translate", -- Lazy load
        config = function()
            -- ============================================
            -- TRANSLATE SETUP
            -- ============================================
            require("translate").setup({
                -- ============================================
                -- DEFAULT CONFIGURATION
                -- ============================================
                default = {
                    command = "google",             -- Translation engine
                    output = "floating",            -- Output method
                    parse_before = "trim,natural",  -- Text preprocessing
                    parse_after = "window",         -- Post-processing
                },

                -- ============================================
                -- PRESET CONFIGURATION
                -- ============================================
                preset = {
                    output = {
                        -- Floating window settings
                        floating = {
                            relative = "cursor",
                            style = "minimal",
                            width = nil,        -- Auto-adjust
                            height = nil,       -- Auto-adjust
                            row = 1,
                            col = 1,
                            border = "rounded",
                            filetype = "translate",
                            zindex = 50,
                        },

                        -- Split window settings
                        split = {
                            position = "bottom",
                            min_size = 5,
                            max_size = 0.3,
                            name = "translate://output",
                            filetype = "translate",
                            append = true,
                        },

                        -- Insert configuration
                        insert = {
                            base = "bottom",
                            off = 1,
                        },

                        -- Register settings
                        register = {
                            name = "+",
                        },
                    },

                    parse_after = {
                        -- Fit text to window width
                        window = {
                            width = 0.8,
                        },
                    },
                },

                -- Mute messages
                silent = false,
            })

            -- All keymaps moved to remaps.lua

            -- ============================================
            -- USER COMMANDS
            -- ============================================

            -- Help command
            vim.api.nvim_create_user_command("TranslateHelp", function()
                local help_text = [[
╔══════════════════════════════════════════════════════════════╗
║            AYUDA - TRANSLATE.NVIM                            ║
╚══════════════════════════════════════════════════════════════╝

TRADUCCIÓN BÁSICA:
  <leader>te     - Traducir a Español (ventana flotante)
  <leader>ti     - Traducir a Inglés (ventana flotante)
  <leader>tw     - Traducir palabra bajo cursor a Español
  <leader>twi    - Traducir palabra bajo cursor a Inglés

TRADUCCIÓN CON INSERCIÓN:
  <leader>tei    - Traducir e insertar debajo (Español)
  <leader>tii    - Traducir e insertar debajo (Inglés)

TRADUCCIÓN CON REEMPLAZO:
  <leader>ter    - Traducir y reemplazar texto (Español)
  <leader>tir    - Traducir y reemplazar texto (Inglés)

COMENTARIOS:
  <leader>tc     - Traducir comentario completo a Español
  <leader>tci    - Traducir comentario completo a Inglés

VENTANA DIVIDIDA:
  <leader>ts     - Abrir traducción en ventana dividida

COMANDO MANUAL:
  :Translate {idioma} [-options]
  Ejemplo: :Translate ES
  Ejemplo: :Translate EN -output=split

IDIOMAS COMUNES:
  ES - Español    EN - Inglés    FR - Francés
  DE - Alemán     IT - Italiano  PT - Portugués
]]
                vim.notify(help_text, vim.log.levels.INFO, {
                    title = "Translate.nvim",
                    timeout = 10000,
                })
                print(help_text)
            end, { desc = "Show Translate.nvim help" })

            -- Change translation engine command
            vim.api.nvim_create_user_command("TranslateEngine", function(opts)
                local engine = opts.args
                local valid_engines = { "google", "deepl_free", "deepl_pro", "translate_shell" }

                if vim.tbl_contains(valid_engines, engine) then
                    require("translate").setup({
                        default = { command = engine }
                    })
                    vim.notify("Motor de traducción cambiado a: " .. engine, vim.log.levels.INFO)
                else
                    vim.notify("Motor inválido. Usa: " .. table.concat(valid_engines, ", "), vim.log.levels.ERROR)
                end
            end, {
                nargs = 1,
                complete = function()
                    return { "google", "deepl_free", "deepl_pro", "translate_shell" }
                end,
                desc = "Change translation engine"
            })

            -- Startup notification
            vim.notify("Translate.nvim loaded - Use <leader>te/ti or :TranslateHelp", vim.log.levels.INFO, {
                title = "Translate",
                timeout = 3000,
            })
        end,
    },
}
