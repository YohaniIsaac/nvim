-- ============================================
-- SNACKS.NVIM - QOL PLUGINS COLLECTION
-- ============================================
return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        -- ============================================
        -- IMAGE VIEWER
        -- ============================================
        -- Muestra imágenes directamente en nvim (Kitty nativo)
        -- Formatos directos: png, jpg, gif, webp, bmp, tiff, avif
        -- Formatos con ImageMagick: pdf, mp4, mkv, heic, etc.
        -- Para instalar: sudo pacman -S imagemagick
        image = {
            enabled = true,
            doc = {
                enabled = true,   -- muestra imágenes embebidas en markdown
                inline = true,    -- renderiza inline en el buffer
                float = true,     -- fallback a ventana flotante
                max_width = 80,
                max_height = 40,
            },
        },

        -- ============================================
        -- PICKER - REEMPLAZA TELESCOPE
        -- ============================================
        picker = {
            enabled = true,
            ui_select = true,   -- reemplaza vim.ui.select (antes: telescope-ui-select)
            sources = {
                files = {
                    hidden = true,
                    ignored = true,
                    follow = true,
                    exclude = { ".git", ".venv", "build", ".cache" },
                },
                grep = {
                    hidden = true,
                    ignored = true,
                    follow = true,
                    exclude = { ".git", ".venv", "build", ".cache", "*.hex" },
                },
            },
        },

        -- ============================================
        -- VISUAL MARKS WITH INDICATORS
        -- ============================================
        -- Disabled to preserve default line numbers and sign column
        -- Use <leader>m to browse marks with the picker
        statuscolumn = {
            enabled = false,
        },

        -- ============================================
        -- BIGFILE HANDLING
        -- ============================================
        -- Disables heavy features for large files
        bigfile = {
            enabled = true,
            size = 1024 * 1024, -- 1MB
        },

        -- ============================================
        -- NOTIFICATION SYSTEM
        -- ============================================
        -- Pretty notifications (replaces vim.notify)
        notifier = {
            enabled = true,
            timeout = 3000, -- 3 seconds
        },

        -- ============================================
        -- SMOOTH SCROLLING
        -- ============================================
        scroll = {
            enabled = true,
        },

        -- ============================================
        -- INDENT GUIDES
        -- ============================================
        indent = {
            enabled = true,
            indent = {
                char = "│",
            },
            scope = {
                enabled = true,
                char = "│",
            },
        },

        -- ============================================
        -- LSP WORD REFERENCES
        -- ============================================
        -- Auto-show LSP references under cursor
        words = {
            enabled = true,
            debounce = 200,
        },

        -- ============================================
        -- QUICKFILE
        -- ============================================
        -- Fast file loading before plugins
        quickfile = {
            enabled = true,
        },

        -- ============================================
        -- ZEN MODE
        -- ============================================
        -- Distraction-free coding
        zen = {
            enabled = true,
            toggles = {
                dim = true,
                git_signs = false,
                mini_diff_signs = false,
                diagnostics = false,
                inlay_hints = false,
            },
            zoom = {
                width = 0.85,
                height = 0.9,
            },
        },

        -- ============================================
        -- TERMINAL
        -- ============================================
        -- Floating/split terminal management
        terminal = {
            enabled = true,
            win = {
                position = "float",
                height = 0.8,
                width = 0.9,
            },
        },

        -- ============================================
        -- GIT INTEGRATION
        -- ============================================
        lazygit = {
            enabled = true,
            configure = true, -- Auto-configure colorscheme
        },

        gitbrowse = {
            enabled = true,
        },

        -- ============================================
        -- SCRATCH BUFFERS
        -- ============================================
        -- Quick scratch files for notes/testing
        scratch = {
            enabled = true,
            ft = "markdown",
        },

        -- ============================================
        -- BUFFER DELETE
        -- ============================================
        -- Delete buffers without disrupting layout
        bufdelete = {
            enabled = true,
        },

        -- ============================================
        -- INPUT ENHANCEMENT
        -- ============================================
        -- Better vim.ui.input
        input = {
            enabled = true,
        },


        -- ============================================
        -- RENAME FILES WITH LSP
        -- ============================================
        -- LSP-aware file renaming
        rename = {
            enabled = true,
        },

        -- ============================================
        -- DASHBOARD
        -- ============================================
        -- You already have alpha.lua, so keeping this disabled
        dashboard = {
            enabled = false,
        },
    },

    -- ============================================
    -- KEYMAPS
    -- ============================================
    -- Note: Additional keymaps are configured in lua/config/remaps.lua
    keys = {
        -- ============================================
        -- PICKER - BÚSQUEDA DE ARCHIVOS Y TEXTO
        -- ============================================
        { "<leader>pf", function() require("snacks").picker.files() end,      desc = "Find files" },
        { "<C-p>",      function() require("snacks").picker.git_files() end,  desc = "Find git-tracked files" },
        { "<leader>ps", function() require("snacks").picker.grep() end,       desc = "Live grep" },
        { "<leader>ff", function() require("snacks").picker.grep({ cwd = vim.fn.getcwd() }) end, desc = "Live grep in cwd" },
        { "<leader>fg", function() require("snacks").picker.grep() end,       desc = "Live grep (hidden)" },
        { "<leader>gg", function() require("snacks").picker.grep_word() end,  desc = "Grep word under cursor" },
        { "<leader>gw", function() require("snacks").picker.grep_word() end,  desc = "Grep word under cursor (full)" },

        -- Búsqueda avanzada con exclusiones personalizadas
        { "<leader>fe", function()
            local term = vim.fn.input("Buscar término: ")
            if term == "" then return end
            local excl = vim.fn.input("Excluir (separados por coma): ")
            local exclude = { ".git", ".venv", "build", ".cache", "*.hex" }
            if excl ~= "" then
                for e in excl:gmatch("([^,]+)") do
                    table.insert(exclude, vim.trim(e))
                end
            end
            require("snacks").picker.grep({ search = term, exclude = exclude })
        end, desc = "Grep with custom exclusions" },

        -- Marks navigation (uses picker)
        { "<leader>m", function() require("snacks").picker.marks() end, desc = "Browse marks" },

        -- Notifications
        { "<leader>nh", function() require("snacks").notifier.show_history() end, desc = "Notification history" },
        { "<leader>nd", function() require("snacks").notifier.hide() end, desc = "Dismiss notifications" },

        -- Scratch buffer - Buffer temporal para notas/pruebas que se guarda automáticamente
        -- <leader>. abre/cierra el scratch buffer por defecto
        -- <leader>S te permite seleccionar entre múltiples scratch buffers
        { "<leader>.", function() require("snacks").scratch() end, desc = "Toggle scratch buffer" },
        { "<leader>S", function() require("snacks").scratch.select() end, desc = "Select scratch buffer" },

        -- Buffer delete mejorado - Cierra el buffer sin romper el layout de ventanas
        -- A diferencia de :bdelete, mantiene las ventanas en su lugar
        { "<leader>bd", function() require("snacks").bufdelete() end, desc = "Delete buffer" },
    },
}
