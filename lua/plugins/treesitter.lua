return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local configs = require("nvim-treesitter.configs")
            configs.setup({
                ensure_installed = {"python", "lua", "c", "javascript", "cmake", "yaml"},
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = { "python" }
                },
                indent = { enable = true },
                fold = {
                    enable = true,
                    disable = {},
                }
            })
        end
    },
    {
        'nvim-treesitter/nvim-treesitter-context'
    }
}
