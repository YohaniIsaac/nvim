-- ============================================
-- COMMENT.NVIM - TOGGLE COMMENTS
-- ============================================
return {
    {
        "numToStr/Comment.nvim",
        event = "VeryLazy",
        config = function()
            local ft = require('Comment.ft')

            -- ============================================
            -- COMMENT SETTINGS BY FILE TYPE
            -- ============================================
            -- Correct format according to documentation:
            -- ft.set('filetype', {'line_comment', 'block_comment'})
            -- First parameter: line comment (for gc)
            -- Second parameter: block comment (for gb)

            -- Configure C and C++ to use /* */ in both cases
            ft.set('c', {'/*%s*/', '/*%s*/'})
            ft.set('cpp', {'/*%s*/', '/*%s*/'})

            require("Comment").setup({
                -- ============================================
                -- TOGGLE MODES
                -- ============================================
                toggler = {
                    line = "gc",   -- Toggle line comment
                    block = "gb",  -- Toggle block comment
                },
                opleader = {
                    line = "gc",   -- Toggle in visual mode (line)
                    block = "gb",  -- Toggle in visual mode (block)
                },

                -- ============================================
                -- MAPPINGS
                -- ============================================
                mappings = {
                    basic = true,  -- Enable basic mappings (gc, gb)
                    extra = true,  -- Enable extra mappings (gcA, gbc, etc.)
                },

                -- ============================================
                -- PADDING
                -- ============================================
                padding = true,  -- Agrega espacio entre comentario y código

                -- ============================================
                -- HOOKS
                -- ============================================
                pre_hook = nil,
            })
        end,
    },
}
