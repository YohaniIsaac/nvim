-- ============================================
-- LSP CONFIGURATION - MASON + LSP
-- ============================================
return {
    -- ============================================
    -- MASON - LSP PACKAGE MANAGER
    -- ============================================
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },

    -- ============================================
    -- MASON-LSPCONFIG - BRIDGE BETWEEN MASON AND LSPCONFIG
    -- ============================================
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",       -- lua
                    "clangd",       -- C/C++
                    "cmake",        -- CMake
                    "cssls",        -- CSS
                    "html",         -- HTML
                    "texlab"        -- LaTeX
                }
            })
        end
    },

    -- ============================================
    -- NVIM-LSPCONFIG - LSP CONFIGURATION
    -- ============================================
    {
        "neovim/nvim-lspconfig",
        config = function()
            -- ============================================
            -- LSP SERVER CONFIGURATIONS
            -- ============================================

            -- Lua Language Server
            vim.lsp.config('lua_ls', {
                cmd = { 'lua-language-server' },
                root_markers = {
                    '.luarc.json', '.luarc.jsonc', '.luacheckrc', '.stylua.toml', 'stylua.toml',
                    'selene.toml', 'selene.yml', '.git' },
            })

            -- Clangd (C/C++)
            vim.lsp.config('clangd', {
                cmd = { 'clangd' },
                root_markers = {
                    '.clangd', '.clang-tidy', '.clang-format', 'compile_commands.json',
                    'compile_flags.txt', 'configure.ac', '.git' },
            })

            -- CMake Language Server
            vim.lsp.config('cmake', {
                cmd = { 'cmake-language-server' },
                root_markers = { 'CMakeLists.txt', '.git' },
            })

            -- TEXLAB (LaTeX)
            vim.lsp.config('texlab', {
                cmd = { 'texlab' },
                root_markers = { '.latexmkrc', '.git', 'main.tex' },
                settings = {
                    texlab = {
                        -- Build Configuration
                        build = {
                            executable = "latexmk",
                            args = {
                                "-pdf",
                                "-interaction=nonstopmode",
                                "-synctex=1",
                                "-shell-escape",
                                "-auxdir=build",
                                "-outdir=build",
                                "%f"
                            },
                            onSave = false,  -- Don't compile on save (VimTeX does this)
                            forwardSearchAfter = false,
                        },

                        -- ChkTeX configuration (linting)
                        chktex = {
                            onOpenAndSave = true,  -- Run on open and save
                            onEdit = true,         -- Run while editing for real-time feedback
                        },

                        -- Diagnostic delay (ms) - ajusta según prefieras
                        diagnosticsDelay = 500,  -- Mayor delay para evitar lag al escribir

                        -- Line width for formatting
                        formatterLineLength = 80,

                        -- Autocompletado
                        completion = {
                            matcher = "fuzzy",
                        },

                        -- Forward search (integración con visor PDF)
                        forwardSearch = {
                            executable = nil,  -- Desactivado (usarás VimTeX)
                            args = {},
                        },
                    }
                }
            })
            -- ============================================
            -- ENABLE LSP SERVERS
            -- ============================================
            vim.lsp.enable({'lua_ls', 'clangd', 'cmake', 'cssls', 'html', 'texlab'})

            -- ============================================
            -- LSP KEYBINDINGS
            -- ============================================
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, {})
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {desc = "Go to implementation"})
            vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {desc = "Rename symbol"})
            vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {desc = "Code actions"})

            -- Diagnósticos
            vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, {desc = "Go to previous diagnostic"})
            vim.keymap.set('n', ']d', vim.diagnostic.goto_next, {desc = "Go to next diagnostic"})
            vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, {desc = "Show diagnostic"})
        end
    }
}
