-- ============================================
-- WINDOW-PICKER - VISUAL WINDOW SELECTION
-- ============================================
return {
    {
        "s1n7ax/nvim-window-picker",
        config = function()
            require("window-picker").setup({
                -- ============================================
                -- BEHAVIOR
                -- ============================================
                autoselect_one = true,
                include_current = true,

                -- ============================================
                -- COLORS
                -- ============================================
                fg_color = "#FFA07A",               -- Letter color
                current_win_hl_color = "#247997",   -- Color for the current window
                other_win_hl_color = "#7B2497",     -- Color for the other windows
            })
        end
    }
}
