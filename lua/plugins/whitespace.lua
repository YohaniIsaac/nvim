-- ============================================
-- VIM-BETTER-WHITESPACE - WHITESPACE MANAGEMENT
-- ============================================
return {
    {
        "ntpeters/vim-better-whitespace",
        config = function()
            -- Enable whitespace highlighting
            vim.g.better_whitespace_enabled = 1

            -- Strip whitespace on save
            vim.g.strip_whitespace_on_save = 1

            -- Strip blank lines at end of file
            vim.g.strip_whitelines_at_eof = 1
        end
    }
}
