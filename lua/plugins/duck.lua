-- ============================================
-- DUCK.NVIM - ANIMATED EMOJIS ON SCREEN
-- ============================================
return {
    {
        'tamton-aquib/duck.nvim',
        config = function()
            -- Just setup the plugin, keymaps are in remaps.lua
            require("duck")
        end
    }
}
