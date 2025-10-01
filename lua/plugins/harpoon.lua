-- ============================================
-- HARPOON - QUICK FILE NAVIGATION
-- ============================================
return {
    {
        "theprimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local harpoon = require("harpoon")

            -- ============================================
            -- HARPOON SETUP
            -- ============================================
            harpoon:setup({
                menu = {
                    width = vim.api.nvim_win_get_width(0) - 20,  -- Adjust the width
                    height = 10,  -- Adjust the height
                },
            })

            -- ============================================
            -- CUSTOM COLORS
            -- ============================================
            -- Window background and foreground
            vim.api.nvim_set_hl(0, "HarpoonWindow", { fg = "#A3BE8C", bg = "#2E3440" }) -- Window color
            vim.api.nvim_set_hl(0, "HarpoonBorder", { fg = "#88C0D0", bg = "#2E3440" }) -- Border color
            vim.api.nvim_set_hl(0, "HarpoonTitle", { fg = "#EBCB8B", bold = true })     -- Title color
        end,
    },
}
