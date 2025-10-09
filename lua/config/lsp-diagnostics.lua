-- ============================================
-- LSP DIAGNOSTICS CONFIGURATION
-- ============================================

-- Configurar apariencia de diagnósticos
vim.diagnostic.config({
    virtual_text = {
        prefix = '●',
        spacing = 4,
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '',
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

-- Colores personalizados
vim.api.nvim_set_hl(0, "DiagnosticError", { fg = "#db4b4b" })
vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = "#e0af68" })
vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = "#0db9d7" })
vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = "#1abc9c" })

return {}
