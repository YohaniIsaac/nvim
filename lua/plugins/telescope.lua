-- ============================================
-- TELESCOPE - FUZZY FINDER
-- ============================================
return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            -- ============================================
            -- TELESCOPE SETUP
            -- ============================================
            require("telescope").setup({
                -- ============================================
                -- DEFAULT SETTINGS
                -- ============================================
                defaults = {
                    file_ignore_patterns = {
                        "build/.*",     -- Ignore everything under build directory
                        "%.git/.*",     -- Ignore .git directories
                        "%.venv/.*",    -- Ignore .venv directories
                        "%.cache/.*",   -- Ignore .cache directories
                        "%.hex$"        -- Ignore .hex files
                    }
                },
                -- ============================================
                -- PICKERS CONFIGURATION
                -- ============================================
                pickers = {
                    -- Find files picker
                    find_files = {
                        hidden = true,
                        no_ignore = true,
                        follow = true,      -- Follow symbolic links
                        depth = 8,          -- Increase search depth to reach nested deps folders
                        file_ignore_patterns = {
                            "build/.*",     -- Ignore everything under build directory
                            "%.git/.*",     -- Ignore .git directories
                            "%.venv/.*",    -- Ignore .venv directories
                            "%.cache/.*",   -- Ignore .cache directories
                            "%.hex$"        -- Ignore .hex files
                        }
                    },

                    -- Grep string picker
                    grep_string = {
                        additional_args = function()
                            return {
                                "--hidden",
                                "--no-ignore",
                                "--follow",             -- Follow symbolic links
                                "--max-depth=8",        -- Search deeper in directory structure
                                "--glob=!build/**",     -- Exclude build directory for ripgrep
                                "--glob=!.git/**",      -- Exclude .git directories for ripgrep
                                "--glob=!.venv/**",     -- Exclude .venv directories for ripgrep
                                "--glob=!.cache/**",    -- Exclude .cache directories for ripgrep
                                "--glob=!*.hex"         -- Exclude .hex files for ripgrep
                            }
                        end,
                        no_ignore = true
                    },

                    -- Live grep picker
                    live_grep = {
                        additional_args = function()
                            return {
                                "--hidden",
                                "--no-ignore",
                                "--follow",             -- Follow symbolic links
                                "--max-depth=8",        -- Search deeper in directory structure
                                "--glob=!build/**",     -- Exclude build directory for ripgrep
                                "--glob=!.git/**",      -- Exclude .git directories for ripgrep
                                "--glob=!.venv/**",     -- Exclude .venv directories for ripgrep
                                "--glob=!.cache/**",    -- Exclude .cache directories for ripgrep
                                "--glob=!*.hex"         -- Exclude .hex files for ripgrep
                            }
                        end,
                        no_ignore = true
                    },
                },
                -- ============================================
                -- EXTENSIONS
                -- ============================================
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown {
                        }
                    }
                }
            })
        end
    },

    -- ============================================
    -- TELESCOPE UI SELECT EXTENSION
    -- ============================================
    {
        'nvim-telescope/telescope-ui-select.nvim',
        config = function()
            require("telescope").load_extension("ui-select")
        end
    },
}
