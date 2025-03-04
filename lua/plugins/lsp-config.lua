return {
   {
       "williamboman/mason.nvim",
       config = function()
           -- Sobrescribir vim.notify para evitar mensajes innecesarios
           local original_notify = vim.notify
           vim.notify = function(msg, level, opts)
               if not string.find(msg, "Client clangd quit") then
                   original_notify(msg, level, opts or {})
               end
           end

           require("mason").setup()
       end
   },
   {
       "williamboman/mason-lspconfig.nvim",
       config = function()
           require("mason-lspconfig").setup({
               ensure_installed = {
                   "lua_ls",
                   "clangd",
                   "ts_ls",
                   "pyright",
                   "html",
                   "cssls",
                   "jsonls",
               },
               automatic_installation = true,
           })
       end
   },
   {
       "neovim/nvim-lspconfig",
       config = function()
           local lspconfig = require('lspconfig')

           -- Configuración específica para clangd
           lspconfig.clangd.setup({
               cmd = {
                   "clangd",
                   "--background-index",
                   "--query-driver=/usr/bin/arm-none-eabi-gcc",
                   "--all-scopes-completion",
                   "--completion-style=detailed",
                   "-j=4",
                   "--header-insertion=never",
                   "--pch-storage=memory",
                   "--compile-flags-ignore=-fno-reorder-functions",
                   "--enable-config",
                   "--log=error",
                   "--compile-commands-dir=build", -- Ruta al compile_commands.json
               },
               filetypes = {"c", "cpp", "objc", "objcpp"},
               root_dir = lspconfig.util.root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
               init_options = {
                   usePlaceholders = true,
                   completeUnimported = true,
                   clangdFileStatus = true,
                   fallbackFlags = {
                       "-xc",
                       "--target=arm-none-eabi",
                       "-DZEPHYR=1",
                       "-DCONFIG_ARM=1",
                       "-I${workspaceFolder}/include",
                       "-I${workspaceFolder}/deps/zephyr/include",
                       "-I${workspaceFolder}/deps/zephyr/include/zephyr",
                       "-I.",
                       "-I./include",
                       "-I./src",
                       "-std=gnu11",
                       "-nostdinc",
                       "--target=arm-none-eabi",
                       "-DCONFIG_ARCH_HAS_CUSTOM_BUSY_WAIT=1",
                       "-DCONFIG_HAS_DTS=1",
                   }
               },
               on_init = function(client, _)
                   client.server_capabilities.signatureHelpProvider = false
               end,
               flags = {
                   debounce_text_changes = 150,
               },
           })

           -- Configuraciones para otros LSPs
           lspconfig.ts_ls.setup({})
           lspconfig.pyright.setup({})
           lspconfig.lua_ls.setup({
               settings = {
                   Lua = {
                       runtime = {
                           version = 'LuaJIT',
                       },
                       diagnostics = {
                           globals = {'vim'},
                       },
                       workspace = {
                           library = vim.api.nvim_get_runtime_file("", true),
                           checkThirdParty = false,
                       },
                       telemetry = {
                           enable = false,
                       },
                   },
               },
           })
           lspconfig.html.setup({})
           lspconfig.cssls.setup({})
           lspconfig.jsonls.setup({})

           -- Keymaps
           vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = "LSP Declaration" })
           vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "LSP Definition" })
           vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "LSP Hover" })
           vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = "LSP Implementation" })
           vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { desc = "LSP Signature Help" })
           vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, { desc = "Add Workspace Folder" })
           vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, { desc = "Remove Workspace Folder" })
           vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, { desc = "LSP Type Definition" })
           vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, { desc = "LSP Rename" })
           vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, { desc = "LSP Code Action" })
           vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = "LSP References" })
       end
   }
}
