-- ============================================
-- FZF - FUZZY FINDER INTEGRATION
-- ============================================
return{
    {
        "junegunn/fzf",
        build = ":call fzf#install()",          -- Install fzf dependencies
        dependencies = { "junegunn/fzf.vim" },  -- If you also use fzf.vim
        config = function()
        end,
    },
}
