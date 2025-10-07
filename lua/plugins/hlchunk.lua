-- ============================================
-- HLCHUNK - INDENT CHUNK HIGHLIGHTING
-- ============================================
return {
    {
        "shellRaining/hlchunk.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("hlchunk").setup({
                -- ============================================
                -- CHUNK MODULE (DISABLED)
                -- ============================================
                chunk = {
                    enable = false,
                    -- enable = true,
                    -- style = "#806d9c",
                    -- use_treesitter = true,
                },

                -- ============================================
                -- INDENT MODULE (MAIN FEATURE)
                -- ============================================
                indent = {
                    enable = true,
                    use_treesitter = false,
                    chars = { "│" }, -- Character for the indentation line
                    style = {
                        "#A30000",
                        "#A35200",
                        "#A3A300",
                        "#00A300",
                        "#00A3A3",
                        "#0000A3",
                        "#5A00A3",
                    },
                },

                -- ============================================
                -- LINE_NUM MODULE (HIGHLIGHT LINE NUMBERS)
                -- ============================================
                line_num = {
                    enable = false,
                    -- If you want to highlight line numbers:
                    -- enable = true,
                    -- style = "#2E58FF",
                    -- use_treesitter = true,
                },

                -- ============================================
                -- BLANK MODULE (BLANK LINES)
                -- ============================================
                blank = {
                    enable = false,
                    -- If you want to highlight blank lines:
                    -- enable = true,
                    -- chars = { "" },
                    -- style = {
                    --     vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Whitespace")), "fg", "gui"),
                    -- },
                },
            })

            -- ============================================
            -- CUSTOM COLORS FOR INDENT LINES
            -- ============================================
            -- You can customize the color of the lines here
            vim.api.nvim_set_hl(0, "HlChunkIndent", { fg = "#C70000" })

            -- Alternative color to highlight the current chunk (optional)
            vim.api.nvim_set_hl(0, "HlChunkIndentActive", { fg = "#0017FF" })
        end,
    },
}
