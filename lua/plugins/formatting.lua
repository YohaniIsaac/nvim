-- ============================================
-- CONFORM.NVIM - CODE FORMATTING
-- ============================================
return {
    -- Agregar conform.nvim para manejar el formateo
    {
        "stevearc/conform.nvim",
        opts = {
            -- ============================================
            -- FORMATTERS BY FILETYPE
            -- ============================================
            formatters_by_ft = {
                c = { "clang_format" },
                cpp = { "clang_format" },
                h = { "clang_format" },
            },

            -- ============================================
            -- CLANG-FORMAT CONFIGURATION
            -- ============================================
            formatters = {
                clang_format = {
                    -- Use the project's .clang-format file
                    prepend_args = { "--style=file" },
                },
            },
        },

        -- ============================================
        -- INITIALIZATION
        -- ============================================
        init = function()
            -- Register the :Format command for use from the command line
            vim.api.nvim_create_user_command("Format", function(args)
                local range = nil
                if args.count ~= -1 then
                    local end_line = vim.fn.line(".")
                    range = {
                        start = { args.line1, 0 },
                        ["end"] = { end_line, 0 },
                    }
                end
                require("conform").format({ async = true, lsp_fallback = true, range = range })
            end, { range = true })
        end,
    },

    -- ============================================
    -- DISABLE NONE-LS FORMATTING (if present)
    -- ============================================
    {
        "nvimtools/none-ls.nvim",
        optional = true,
        opts = function(_, opts)
            if type(opts.sources) == "table" then
                local nls = require("null-ls")
                opts.sources = vim.tbl_filter(function(source)
                    return source.name ~= "clang_format"
                end, opts.sources)
            end
        end,
    },
}
