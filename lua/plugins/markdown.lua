return {
    {
        'f-person/git-blame.nvim',
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require('gitblame').setup {
                enabled = true,
                message_template = '<author> • <date> • <summary>',
                date_format = '%r',
                message_when_not_committed = 'No commiteado aún',
            }

            -- Asegurarse de que se active al inicio
            vim.cmd('GitBlameEnable')

            -- Personalizar el color del texto de git-blame usando el grupo 'Comment'
            vim.cmd([[
                highlight Comment guifg=#0c4000 guibg=NONE ctermfg=214 ctermbg=NONE
            ]])

        end,
    }
}
