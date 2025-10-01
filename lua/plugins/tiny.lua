-- ============================================
-- TINY-GLIMMER - CURSOR HIGHLIGHT ANIMATIONS
-- ============================================
return {
    {
        "rachartier/tiny-glimmer.nvim",
        config = function()
            require("tiny-glimmer").setup({
                -- Available animations: "rainbow", "fade", "bounce", "pulse",
                -- "custom", "left_to_right", "reverse_fade"
                default_animation = "rainbow",

                -- Adjust if using transparent background
                transparency_color = "#ff5733",
            })
        end,
    },
}
