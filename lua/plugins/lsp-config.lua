return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {"lua_ls", "clangd", "cmake", "cssls", "html"}
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            -- Nuevo formato usando vim.lsp.config
            vim.lsp.config('lua_ls', {
                cmd = { 'lua-language-server' },
                root_markers = { '.luarc.json', '.luarc.jsonc', '.luacheckrc', '.stylua.toml', 'stylua.toml', 'selene.toml', 'selene.yml', '.git' },
            })

            vim.lsp.config('clangd', {
                cmd = { 'clangd' },
                root_markers = { '.clangd', '.clang-tidy', '.clang-format', 'compile_commands.json', 'compile_flags.txt', 'configure.ac', '.git' },
            })

            vim.lsp.config('cmake', {
                cmd = { 'cmake-language-server' },
                root_markers = { 'CMakeLists.txt', '.git' },
            })

            -- Activar los LSP servers
            vim.lsp.enable({'lua_ls', 'clangd', 'cmake', 'cssls', 'html'})

            -- Keybindings
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, {})
        end
    }
}
