-- ============================================
-- MARKS.NVIM - VISUAL MARKS INDICATORS
-- ============================================
return {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    config = function()
        require("marks").setup({
        -- ============================================
        -- VISUAL SETTINGS
        -- ============================================
        -- Default mark mappings (m{a-z}, m{A-Z})
        default_mappings = true,

        -- Show marks in sign column (left bar)
        signs = true,

        -- Refresh marks on buffer changes
        refresh_interval = 250,

        -- Force write marks on buffers
        force_write_shada = true,

        -- ============================================
        -- MARK TYPES
        -- ============================================
        -- Show lowercase marks (a-z) - local to buffer
        builtin_marks = {},

        -- Cyclic marks (cycle through with next/prev)
        cyclic = true,

        -- ============================================
        -- SIGN COLUMN SETTINGS
        -- ============================================
        -- Priority of marks in sign column
        sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },

        -- Characters to exclude from marks
        excluded_filetypes = {
            "neo-tree",
            "TelescopePrompt",
            "alpha",
            "dashboard",
            "lazy",
            "mason",
            "help",
        },

        -- ============================================
        -- BOOKMARK GROUPS (Optional feature)
        -- ============================================
        -- You can create bookmark groups with custom colors
        bookmark_0 = {
            sign = "⚑",
            virt_text = "bookmark",
            annotate = false,
        },

        -- ============================================
        -- MARK NAVIGATION MAPPINGS
        -- ============================================
        mappings = {
            -- Set mark at cursor (default: m{a-z}, m{A-Z})
            set = "m",

            -- Delete mark under cursor
            delete = "dm",

            -- Delete all marks in buffer
            delete_buf = "dm-",

            -- Jump to next mark
            next = "m]",

            -- Jump to previous mark
            prev = "m[",

            -- Preview mark (shows mark in floating window)
            preview = "m:",

            -- Toggle mark at current line (uses next available mark a-z)
            toggle = "m;",

            -- Delete all marks in current line
            delete_line = "dm=",

            -- Set bookmark (bookmark_0)
            set_bookmark0 = "m0",
            delete_bookmark0 = "dm0",
            next_bookmark0 = "m0]",
            prev_bookmark0 = "m0[",
        }
        })

        -- Ensure line numbers are visible
        vim.opt.number = true
        vim.opt.signcolumn = "yes"

        -- ============================================
        -- CUSTOM COLORS FOR MARKS
        -- ============================================
        -- Set marks to bold yellow
        vim.api.nvim_set_hl(0, "MarkSignHL", { fg = "#FFD700", bold = true })  -- Gold/Yellow
        vim.api.nvim_set_hl(0, "MarkSignNumHL", { fg = "#FFD700", bold = true })

        -- Uppercase marks (global) in bright yellow
        vim.api.nvim_set_hl(0, "MarkVirtTextHL", { fg = "#FFFF00", bold = true })

        -- ============================================
        -- ADDITIONAL KEYMAPS
        -- ============================================
        -- Delete all marks in buffer with <leader>dma
        vim.keymap.set('n', '<leader>dma', ':delmarks!<CR>',
            { noremap = true, silent = true, desc = "Delete all marks in buffer" })

        -- Delete all marks globally (a-z and A-Z) with <leader>dmA
        vim.keymap.set('n', '<leader>dmA', ':delmarks a-zA-Z<CR>',
            { noremap = true, silent = true, desc = "Delete all marks (global)" })
    end,
}
