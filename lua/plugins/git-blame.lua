-- ============================================
-- GIT-BLAME - SHOW GIT BLAME INLINE
-- ============================================
return {
    {
        'f-person/git-blame.nvim',
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            -- ============================================
            -- GIT BLAME CONFIGURATION
            -- ============================================
            require('gitblame').setup({
                enabled = true,
                message_template = '<author> • <date> • <summary>',
                date_format = '%r', -- Relative date format (e.g., "2 hours ago")
                message_when_not_committed = 'No commiteado aún',
            })

            -- Ensure it activates on startup
            vim.cmd('GitBlameEnable')

            -- ============================================
            -- CUSTOM COLOR FOR GIT BLAME TEXT
            -- ============================================
            -- Using dark green color for blame text
            vim.cmd([[
                highlight Comment guifg=#0c4000 guibg=NONE ctermfg=214 ctermbg=NONE
            ]])
        end,
    }
}
