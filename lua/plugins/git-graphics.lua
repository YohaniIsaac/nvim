-- ============================================
-- GIT INTEGRATION PLUGINS
-- ============================================
return {
    -- ============================================
    -- VIM-FUGITIVE - GIT COMMANDS IN NEOVIM
    -- ============================================
    {
        "tpope/vim-fugitive",
        cmd = { "Git", "Gdiffsplit", "Gvdiffsplit", "Gedit", "Gread", "Gwrite", "Gstatus" }, -- Only load the plugin when you run a related command
        config = function()
        end,
    },

    -- ============================================
    -- LAZYGIT.NVIM - GRAPHICAL GIT INTERFACE
    -- ============================================
    {
        "kdheepak/lazygit.nvim",
        cmd = { "LazyGit" }, -- Only load the plugin when you run the LazyGit command
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
        end,
    },
}
