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
                    "html"}         -- HTML
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

            -- ============================================
            -- ENABLE LSP SERVERS
            -- ============================================
            vim.lsp.enable({'lua_ls', 'clangd', 'cmake', 'cssls', 'html'})

            -- ============================================
            -- LSP KEYBINDINGS
            -- ============================================
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, {})
        end
    }
}
