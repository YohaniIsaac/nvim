-- ============================================
-- TREESITTER - ADVANCED SYNTAX HIGHLIGHTING
-- ============================================
return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local configs = require("nvim-treesitter.configs")
            configs.setup({
                -- ============================================
                -- LANGUAGE PARSERS
                -- ============================================
                ensure_installed = {"python", "lua", "c", "javascript", "cmake", "yaml"},

                -- ============================================
                -- MODULES
                -- ============================================
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = { "python" }
                },
                indent = { enable = true },
                fold = {
                    enable = true,
                    disable = {},
                }
            })
        end
    },
    -- ============================================
    -- TREESITTER CONTEXT - SHOW CURRENT CONTEXT
    -- ============================================
    {
        'nvim-treesitter/nvim-treesitter-context'
    }
}
