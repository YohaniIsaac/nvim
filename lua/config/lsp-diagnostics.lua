-- ============================================
-- LSP DIAGNOSTICS CONFIGURATION
-- ============================================

-- Configure diagnostic appearance
vim.diagnostic.config({
    virtual_text = {
        prefix = '●',
        spacing = 4,
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.HINT] = '',
            [vim.diagnostic.severity.INFO] = '',
        },
    },
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
})

-- Custom colors for icons and underlines
vim.api.nvim_set_hl(0, "DiagnosticError", { fg = "#db4b4b" })
vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = "#e0af68" })
vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = "#0db9d7" })
vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = "#1abc9c" })

-- Colors for virtual text (text that appears in the code)
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = "#750000" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { fg = "#473300" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { fg = "#000075" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { fg = "#003847" })

return {}
