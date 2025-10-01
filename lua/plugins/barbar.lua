-- ============================================
-- BARBAR - TAB BAR FOR BUFFERS
-- ============================================
return {
    {
        "romgrk/barbar.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("barbar").setup({
                -- ============================================
                -- ICONS CONFIGURATION
                -- ============================================
                icons = {
                    filetype = { enabled = true },
                    separator = { left = "▎" },
                    inactive = {
                        separator = { left = "▎" },
                    },
                    buffer_index = true,
                },

                -- ============================================
                -- BEHAVIOR
                -- ============================================
                auto_hide = true,
                maximum_padding = 2,
                maximum_length = 30,
            })
        end,
    },
}
