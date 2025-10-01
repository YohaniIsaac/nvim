-- ============================================
-- SMEAR-CURSOR - SMOOTH CURSOR ANIMATION
-- ============================================
return {
    {
        "sphamba/smear-cursor.nvim",
        opts = {
            -- ============================================
            -- SMEAR BEHAVIOR
            -- ============================================
            -- Smear cursor when switching buffers or windows
            smear_between_buffers = true,

            -- Smear cursor when moving within line or to neighbor lines
            smear_between_neighbor_lines = true,

            -- Draw the smear in buffer space instead of screen space when scrolling
            scroll_buffer_space = true,

            -- ============================================
            -- APPEARANCE
            -- ============================================
            -- Set to true if your font supports legacy computing symbols
            -- Smears will blend better on all backgrounds
            legacy_computing_symbols_support = false,

            -- Smear cursor in insert mode
            smear_insert_mode = true,

            -- Cursor color (defaults to Cursor GUI color if not set)
            -- Set to "none" to match the text color at the target cursor position
            cursor_color = "#ffffff",
        },
    },
}
