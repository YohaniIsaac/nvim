-- Translation plugin for Neovim
-- Supports Google Translate, DeepL, and translate-shell


return {
    {
        "uga-rosa/translate.nvim",
        cmd = "Translate", -- Lazy loading, only when you use the command
        keys = {
            -- Keyboard shortcuts for quick translation
            { "<leader>te", mode = { "n", "v" }, desc = "Traducir a Español" },
            { "<leader>ti", mode = { "n", "v" }, desc = "Traducir a Inglés" },
            { "<leader>tc", mode = { "n", "v" }, desc = "Traducir comentario" },
            { "<leader>tw", mode = "n", desc = "Traducir palabra bajo cursor" },
        },
        config = function()
            require("translate").setup({
                -- Default configuration
                default = {
                    command = "google",             -- Translation engine (google, deepl_free, deepl_pro, translate_shell)
                    output = "floating",            -- Output method (floating, split, insert, replace, register)
                    parse_before = "trim,natural",  -- Text preprocessing
                    parse_after = "window",         -- Post-processing of the result
                },

                -- Setting presets
                preset = {
                    output = {
                        -- Floating Window Settings
                        floating = {
                            relative = "cursor",
                            style = "minimal",
                            width = nil,        -- Automatically adjusts
                            height = nil,       -- Automatically adjusts
                            row = 1,
                            col = 1,
                            border = "rounded", -- Rounded edge
                            filetype = "translate",
                            zindex = 50,
                        },
                        -- Split Window Setup
                        split = {
                            position = "bottom", -- "top" or "bottom"
                            min_size = 5,
                            max_size = 0.3,      -- 30% of the window height
                            name = "translate://output",
                            filetype = "translate",
                            append = true,       -- Keep previous translations
                        },
                        -- Insertion configuration
                        insert = {
                            base = "bottom",        -- "top" or "bottom"
                            off = 1,                -- Offset lines
                        },
                        -- Registry settings
                        register = {
                            name = "+",         -- Use the system clipboard
                        },
                    },
                    parse_after = {
                        -- Fit text to window width
                        window = {
                            width = 0.8,        -- 80% of window width
                        },
                    },
                },

                -- Mute success/error messages
                silent = false,
            })

            -- ============================================
            -- KEYMAPS AND CUSTOM COMMANDS
            -- ============================================

            local function translate(mode, target, output)
                return function()
                    local cmd = string.format("Translate %s -output=%s", target, output or "floating")
                    if mode == "n" then
                        vim.cmd(cmd)
                    else
                        vim.cmd("'<,'>" .. cmd)
                    end
                end
            end

            local opts = { noremap = true, silent = true }

            -- ============================================
            -- TRANSLATION INTO SPANISH
            -- ============================================

            -- Normal mode: translates current line
            vim.keymap.set("n", "<leader>te", translate("n", "ES"),
                vim.tbl_extend("force", opts, { desc = "Traducir línea a Español (flotante)" }))

            -- Visual mode: translate selection
            vim.keymap.set("v", "<leader>te", translate("v", "ES"),
                vim.tbl_extend("force", opts, { desc = "Traducir selección a Español (flotante)" }))

            -- Translate and insert below
            vim.keymap.set("n", "<leader>tei", translate("n", "ES", "insert"),
                vim.tbl_extend("force", opts, { desc = "Traducir e insertar a Español" }))
            vim.keymap.set("v", "<leader>tei", translate("v", "ES", "insert"),
                vim.tbl_extend("force", opts, { desc = "Traducir e insertar a Español" }))

            -- Translate and replace
            vim.keymap.set("n", "<leader>ter", translate("n", "ES", "replace"),
                vim.tbl_extend("force", opts, { desc = "Traducir y reemplazar a Español" }))
            vim.keymap.set("v", "<leader>ter", translate("v", "ES", "replace"),
                vim.tbl_extend("force", opts, { desc = "Traducir y reemplazar a Español" }))

            -- ============================================
            -- ENGLISH TRANSLATION
            -- ============================================

            vim.keymap.set("n", "<leader>ti", translate("n", "EN"),
                vim.tbl_extend("force", opts, { desc = "Traducir línea a Inglés (flotante)" }))
            vim.keymap.set("v", "<leader>ti", translate("v", "EN"),
                vim.tbl_extend("force", opts, { desc = "Traducir selección a Inglés (flotante)" }))

            vim.keymap.set("n", "<leader>tii", translate("n", "EN", "insert"),
                vim.tbl_extend("force", opts, { desc = "Traducir e insertar a Inglés" }))
            vim.keymap.set("v", "<leader>tii", translate("v", "EN", "insert"),
                vim.tbl_extend("force", opts, { desc = "Traducir e insertar a Inglés" }))

            vim.keymap.set("n", "<leader>tir", translate("n", "EN", "replace"),
                vim.tbl_extend("force", opts, { desc = "Traducir y reemplazar a Inglés" }))
            vim.keymap.set("v", "<leader>tir", translate("v", "EN", "replace"),
                vim.tbl_extend("force", opts, { desc = "Traducir y reemplazar a Inglés" }))

            -- ============================================
            -- COMMENT TRANSLATION
            -- ============================================

            -- Translate the entire comment where the cursor is
            vim.keymap.set("n", "<leader>tc", function()
                vim.cmd("Translate ES -comment")
            end, vim.tbl_extend("force", opts, { desc = "Traducir comentario a Español" }))

            vim.keymap.set("n", "<leader>tci", function()
                vim.cmd("Translate EN -comment")
            end, vim.tbl_extend("force", opts, { desc = "Traducir comentario a Inglés" }))

            -- ============================================
            -- TRANSLATION OF WORD UNDER CURSOR
            -- ============================================

            vim.keymap.set("n", "<leader>tw", function()
                -- Select the word under the cursor and translate
                vim.cmd("normal! viw")
                vim.cmd("'<,'>Translate ES")
            end, vim.tbl_extend("force", opts, { desc = "Traducir palabra a Español" }))

            vim.keymap.set("n", "<leader>twi", function()
                vim.cmd("normal! viw")
                vim.cmd("'<,'>Translate EN")
            end, vim.tbl_extend("force", opts, { desc = "Traducir palabra a Inglés" }))

            -- ============================================
            -- SPLIT WINDOW FOR TRANSLATIONS
            -- ============================================

            vim.keymap.set("n", "<leader>ts", translate("n", "ES", "split"),
                vim.tbl_extend("force", opts, { desc = "Traducir en ventana dividida" }))
            vim.keymap.set("v", "<leader>ts", translate("v", "ES", "split"),
                vim.tbl_extend("force", opts, { desc = "Traducir en ventana dividida" }))

            -- ============================================
            -- CUSTOM USER COMMANDS
            -- ============================================

            -- Command to display help
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

USO VISUAL:
  - Selecciona texto con 'v', 'V' o Ctrl-v
  - Usa cualquiera de los atajos anteriores
  - La traducción se aplica a la selección

COMANDO MANUAL:
  :Translate {idioma} [-options]
  Ejemplo: :Translate ES
  Ejemplo: :Translate EN -output=split
  Ejemplo: :Translate ES -comment

IDIOMAS COMUNES:
  ES - Español    EN - Inglés    FR - Francés
  DE - Alemán     IT - Italiano  PT - Portugués
  ZH - Chino      JA - Japonés   KO - Coreano

NOTA: Por defecto usa Google Translate (no requiere API key)
]]
                vim.notify(help_text, vim.log.levels.INFO, {
                    title = "Translate.nvim",
                    timeout = 10000,
                })
                print(help_text)
            end, { desc = "Mostrar ayuda de Translate.nvim" })

            -- Command to change the translation engine
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
                desc = "Cambiar motor de traducción"
            })

            -- Successful upload notification
            vim.notify("Translate.nvim cargado - Usa <leader>te/ti o :TranslateHelp", vim.log.levels.INFO, {
                title = "Translate",
                timeout = 3000,
            })
        end,
    },
}
