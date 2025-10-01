-- ============================================
-- CATPPUCCIN - THEME
-- ============================================
return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            -- ============================================
            -- THEME SETUP
            -- ============================================
            require("catppuccin").setup({
                flavor = "mocha",               -- This is the darkest variant
                transparent_background = true,  -- Enable transparency
                term_colors = true,

                -- ============================================
                -- DIM INACTIVE WINDOWS
                -- ============================================
                dim_inactive = {
                    enabled = true,
                    percentage = 0.25,          -- Reduces glare from inactive windows
                },

                -- ============================================
                -- PLUGIN INTEGRATIONS
                -- ============================================
                integrations = {
                    cmp = true,
                    gitsigns = true,
                    nvimtree = true,
                    telescope = true,
                    treesitter = true,
                    alpha = true, -- Soporte para alpha-nvim (tu dashboard)
                    native_lsp = {
                        enabled = true,
                        virtual_text = {
                            errors = { "italic" },
                            hints = { "italic" },
                            warnings = { "italic" },
                            information = { "italic" },
                        },
                    },
                },
            })
            -- ============================================
            -- APPLY COLORSCHEME
            -- ============================================
            vim.cmd.colorscheme("catppuccin")

            -- ============================================
            -- TRANSPARENCY OVERRIDES
            -- ============================================
            vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })

            -- ============================================
            -- PYTHON DOCSTRING COLORS
            -- ============================================
            local docstring_color = "#6c7086" -- Light gray color for docstrings

            local docstring_highlights = {
                "@string.documentation.python",
                "@string.documentation",
                "@comment.documentation.python",
                "pythonDocstring",
                "@string.special.python",
            }

            for _, group in ipairs(docstring_highlights) do
                vim.api.nvim_set_hl(0, group, {
                    fg = docstring_color,
                    italic = true,
                    bg = "NONE"
                })
            end
        end,
    },
}
