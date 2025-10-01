-- ============================================
-- LUALINE - STATUS LINE
-- ============================================
return {
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('lualine').setup({
                -- ============================================
                -- THEME
                -- ============================================
                options = {
                    theme = 'dracula',
                    component_separators = { left = '', right = ''},
                    section_separators = { left = '', right = ''},
                },

                -- ============================================
                -- SECTIONS
                -- ============================================
                sections = {
                    -- Center section: Full file path
                    lualine_c = {
                        {
                            'filename',
                            path = 2  -- 0 = just filename, 1 = relative path, 2 = absolute path
                        }
                    },

                    -- Right section: Filetype and time
                    lualine_x = {
                        'filetype', -- Show code language/filetype
                        {
                            function()
                                return os.date("%H:%M")
                            end,
                            icon = '🕒' -- Clock icon
                        },
                    },
                }
            })
        end
    }
}
