-- ============================================
-- COC.NVIM - CONQUER OF COMPLETION (Alternative LSP)
-- ============================================
return {
    {
        'neoclide/coc.nvim',
        branch = 'release',
        enabled = false,  -- Deshabilitado para usar nvim-lspconfig
        config = function()
            -- ============================================
            -- GLOBAL EXTENSIONS
            -- ============================================
            vim.g.coc_global_extensions = {
                'coc-clangd',
                'coc-snippets',
                'coc-pairs',
            }

            -- ============================================
            -- COC CONFIGURATION
            -- ============================================
            vim.g.coc_user_config = {
                ["clangd.arguments"] = {
                    "--compile-commands-dir=build",
                    "--background-index",
                }
            }

            -- ============================================
            -- EDITOR SETTINGS
            -- ============================================
            vim.opt.updatetime = 300
            vim.opt.signcolumn = 'yes'

            -- ============================================
            -- KEYBINDINGS
            -- ============================================
            local keyset = vim.keymap.set
            local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}

            -- Tab completion
            keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : "<TAB>"', opts)
            keyset("i", "<S-TAB>", 'coc#pum#visible() ? coc#pum#prev(1) : "<S-TAB>"', opts)

            -- Enter to confirm
            keyset("i", "<cr>", 'coc#pum#visible() ? coc#pum#confirm() : "<CR>"', opts)

            -- Basic navigation
            keyset("n", "gd", "<Plug>(coc-definition)", {silent = true})
            keyset("n", "K", ":call CocActionAsync('doHover')<CR>", {silent = true, noremap = true})
        end
    }
}
