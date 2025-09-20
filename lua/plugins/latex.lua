-- lua/plugins/latex.lua
-- Configuración completa para editar documentos LaTeX con VimTeX

return {
    {
        "lervag/vimtex",
        lazy = false,
        ft = { "tex", "bib" },
        config = function()
            -- ============================================
            -- CONFIGURACIÓN GENERAL DE VIMTEX
            -- ============================================

            vim.g.vimtex_enabled = 1

            -- Compilador LaTeX (latexmk)
            vim.g.vimtex_compiler_method = 'latexmk'

            -- Opciones de compilación - CARPETA BUILD
            vim.g.vimtex_compiler_latexmk = {
                build_dir = 'build',
                callback = 1,
                continuous = 1,
                executable = 'latexmk',
                options = {
                    '-pdf',
                    '-shell-escape',
                    '-verbose',
                    '-file-line-error',
                    '-synctex=1',
                    '-interaction=nonstopmode',
                    '-auxdir=build',
                    '-outdir=build',
                }
            }

            -- ============================================
            -- VISUALIZADOR DE PDF - CONFIGURACIÓN PRINCIPAL
            -- ============================================

            vim.g.vimtex_view_method = 'general'
            vim.g.vimtex_view_general_viewer = 'mupdf'
            vim.g.vimtex_view_general_options = '-r 150'  -- Resolución 150 DPI

            -- ============================================
            -- AUTOCOMPLETADO Y SINTAXIS
            -- ============================================

            vim.g.vimtex_fold_enabled = 1
            vim.g.vimtex_fold_manual = 0

            vim.g.vimtex_syntax_enabled = 1
            vim.g.vimtex_syntax_conceal_disable = 0

            -- ============================================
            -- QUICKFIX Y ERRORES
            -- ============================================

            vim.g.vimtex_quickfix_mode = 2
            vim.g.vimtex_quickfix_open_on_warning = 0

            -- ============================================
            -- INDENTACIÓN Y FORMATO
            -- ============================================

            vim.g.vimtex_indent_enabled = 1
            vim.g.vimtex_indent_bib_enabled = 1

            -- ============================================
            -- TOC (Table of Contents)
            -- ============================================

            vim.g.vimtex_toc_config = {
                name = 'TOC',
                layers = { 'content', 'todo', 'include' },
                split_width = 35,
                todo_sorted = 0,
                show_help = 1,
                show_numbers = 1,
            }

            -- ============================================
            -- KEYMAPS PARA LATEX
            -- ============================================

            local function setup_latex_keymaps()
                local opts = { buffer = true, noremap = true, silent = true }

                -- Compilación
                vim.keymap.set('n', '<leader>ll', '<cmd>VimtexCompile<CR>',
                    vim.tbl_extend('force', opts, { desc = 'Compilar LaTeX' }))

                vim.keymap.set('n', '<leader>lc', '<cmd>VimtexClean<CR>',
                    vim.tbl_extend('force', opts, { desc = 'Limpiar archivos auxiliares' }))

                -- Ver PDF con mupdf (comando de VimTeX que usa la config general)
                vim.keymap.set('n', '<leader>lv', '<cmd>VimtexView<CR>',
                    vim.tbl_extend('force', opts, { desc = 'Ver PDF con mupdf' }))

                -- Navegación
                vim.keymap.set('n', '<leader>lt', '<cmd>VimtexTocOpen<CR>',
                    vim.tbl_extend('force', opts, { desc = 'Abrir tabla de contenidos' }))

                -- Información
                vim.keymap.set('n', '<leader>li', '<cmd>VimtexInfo<CR>',
                    vim.tbl_extend('force', opts, { desc = 'Información de VimTeX' }))

                vim.keymap.set('n', '<leader>ls', '<cmd>VimtexStatus<CR>',
                    vim.tbl_extend('force', opts, { desc = 'Estado de compilación' }))

                vim.keymap.set('n', '<leader>le', '<cmd>VimtexErrors<CR>',
                    vim.tbl_extend('force', opts, { desc = 'Ver errores' }))

                vim.keymap.set('n', '<leader>lk', '<cmd>VimtexStop<CR>',
                    vim.tbl_extend('force', opts, { desc = 'Detener compilación' }))

                vim.keymap.set('n', '<leader>lw', '<cmd>VimtexCountWords<CR>',
                    vim.tbl_extend('force', opts, { desc = 'Contar palabras' }))
            end

            -- Autocomando para archivos .tex
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "tex",
                callback = function()
                    setup_latex_keymaps()

                    -- Configuraciones específicas
                    vim.opt_local.conceallevel = 2
                    vim.opt_local.textwidth = 80
                    vim.opt_local.colorcolumn = "80"

                    vim.notify("📝 VimTeX cargado - Usa <leader>l para comandos LaTeX",
                        vim.log.levels.INFO, {
                        title = "LaTeX",
                        timeout = 2000,
                    })
                end,
            })

            -- ============================================
            -- AUTOCOMPLETADO CON CMP
            -- ============================================

            local cmp_status, cmp = pcall(require, 'cmp')
            if cmp_status then
                cmp.setup.filetype('tex', {
                    sources = cmp.config.sources({
                        { name = 'nvim_lsp' },
                        { name = 'luasnip' },
                        { name = 'buffer' },
                        { name = 'path' },
                    })
                })
            end

            -- ============================================
            -- SNIPPETS PARA LATEX
            -- ============================================

            local luasnip_status, luasnip = pcall(require, 'luasnip')
            if luasnip_status then
                local s = luasnip.snippet
                local t = luasnip.text_node
                local i = luasnip.insert_node

                luasnip.add_snippets("tex", {
                    -- Ecuaciones
                    s("eq", {
                        t("\\begin{equation}"),
                        t({"", "\t"}),
                        i(1),
                        t({"", "\\end{equation}"}),
                    }),

                    -- Figuras
                    s("fig", {
                        t("\\begin{figure}[h]"),
                        t({"", "\t\\centering"}),
                        t({"", "\t\\includegraphics[width=0.8\\textwidth]{"}),
                        i(1, "ruta/imagen"),
                        t("}"),
                        t({"", "\t\\caption{"}),
                        i(2, "Descripción"),
                        t("}"),
                        t({"", "\t\\label{fig:"}),
                        i(3, "etiqueta"),
                        t("}"),
                        t({"", "\\end{figure}"}),
                    }),

                    -- Secciones
                    s("sec", {
                        t("\\section{"),
                        i(1, "Título"),
                        t("}"),
                        t({"", "\\label{sec:"}),
                        i(2, "etiqueta"),
                        t("}"),
                    }),
                })
            end
        end,
    },

    -- Snippets adicionales para LaTeX
    {
        "iurimateus/luasnip-latex-snippets.nvim",
        dependencies = { "L3MON4D3/LuaSnip" },
        ft = "tex",
        config = function()
            require('luasnip-latex-snippets').setup()
        end,
    },
}
