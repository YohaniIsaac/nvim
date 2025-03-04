return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local configs = require("nvim-treesitter.configs")
            configs.setup({
                ensure_installed = {"python", "lua", "c", "javascript", "cmake", "yaml"},
                highlight = { enable = true },
                indent = { enable = true }
            })
        end
    },
    {
        'nvim-treesitter/nvim-treesitter-context'
    }
}
