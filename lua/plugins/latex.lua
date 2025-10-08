-- lua/plugins/latex.lua
-- Configuración de VimTeX con Okular

return {
    {
        "lervag/vimtex",
        lazy = false,
        ft = { "tex", "bib" },
        config = function()
            -- ============================================
            -- CONFIGURACIÓN GENERAL
            -- ============================================
            vim.g.vimtex_enabled = 1
            vim.g.vimtex_compiler_method = 'latexmk'

            -- ============================================
            -- COMPILADOR - CARPETA BUILD
            -- ============================================
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
            -- VISOR PDF - OKULAR
            -- ============================================
            vim.g.vimtex_view_method = 'general'
            vim.g.vimtex_view_general_viewer = 'okular'
            vim.g.vimtex_view_general_options = '--unique file:@pdf\\#src:@line@tex'

            -- Sincronización inversa (de Okular a Neovim)
            vim.g.vimtex_compiler_progname = 'nvr'

            -- ============================================
            -- SINTAXIS Y PLEGADO
            -- ============================================
            vim.g.vimtex_fold_enabled = 1
            vim.g.vimtex_fold_manual = 0
            vim.g.vimtex_syntax_enabled = 1
            vim.g.vimtex_syntax_conceal_disable = 0

            -- ============================================
            -- QUICKFIX (ERRORES)
            -- ============================================
            vim.g.vimtex_quickfix_mode = 2
            vim.g.vimtex_quickfix_open_on_warning = 0

            -- ============================================
            -- INDENTACIÓN
            -- ============================================
            vim.g.vimtex_indent_enabled = 1
            vim.g.vimtex_indent_bib_enabled = 1

            -- ============================================
            -- TABLA DE CONTENIDOS
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
            -- FUNCIONES AUXILIARES
            -- ============================================

            -- Abrir PDF en Okular (busca en build/ desde la raíz del proyecto)
            local function open_pdf_okular()
                -- Usar las variables de VimTeX para obtener la raíz del proyecto
                local vimtex_data = vim.b.vimtex

                if not vimtex_data then
                    vim.notify('⚠️  VimTeX no está inicializado\nAbre un archivo .tex válido',
                        vim.log.levels.WARN)
                    return
                end

                -- Obtener la raíz del proyecto y el nombre del archivo principal
                local project_root = vimtex_data.root or vim.fn.expand('%:p:h')
                local main_name = vimtex_data.name or vim.fn.expand('%:t:r')

                -- Construir rutas posibles del PDF (desde la raíz del proyecto)
                local pdf_paths = {
                    project_root .. '/build/' .. main_name .. '.pdf',  -- Raíz/build/main.pdf
                    project_root .. '/' .. main_name .. '.pdf',        -- Raíz/main.pdf
                }

                -- Buscar el PDF en las ubicaciones posibles
                local pdf_path = nil
                for _, path in ipairs(pdf_paths) do
                    if vim.fn.filereadable(path) == 1 then
                        pdf_path = path
                        break
                    end
                end

                -- Si no se encontró, mostrar mensaje de error con rutas buscadas
                if not pdf_path then
                    local search_info = string.format(
                        '⚠️  PDF no encontrado\n\n' ..
                        '📂 Raíz del proyecto: %s\n' ..
                        '📄 Archivo principal: %s.tex\n\n' ..
                        'Buscado en:\n• %s\n• %s\n\n' ..
                        '💡 Compila primero con <leader>ll',
                        project_root,
                        main_name,
                        pdf_paths[1],
                        pdf_paths[2]
                    )
                    vim.notify(search_info, vim.log.levels.WARN)
                    return
                end

                -- Verificar que Okular esté instalado
                if vim.fn.executable('okular') == 0 then
                    vim.notify('⚠️  Okular no está instalado\nInstala con: sudo pacman -S okular',
                        vim.log.levels.ERROR)
                    return
                end

                -- Obtener archivo .tex actual y línea para sincronización
                local tex_file = vim.fn.expand('%:p')
                local current_line = vim.fn.line('.')

                -- Abrir Okular con sincronización
                local cmd = string.format(
                    'okular --unique "file:%s#src:%d %s" > /dev/null 2>&1 &',
                    pdf_path,
                    current_line,
                    tex_file
                )

                vim.fn.system(cmd)
                vim.notify(string.format('📄 PDF abierto: %s\n📂 Desde: %s',
                    vim.fn.fnamemodify(pdf_path, ':t'),
                    project_root),
                    vim.log.levels.INFO)
            end

            -- Crear carpeta build si no existe (en la raíz del proyecto)
            local function ensure_build_dir()
                local vimtex_data = vim.b.vimtex
                local project_root = vimtex_data and vimtex_data.root or vim.fn.expand('%:p:h')
                local build_dir = project_root .. '/build'

                if vim.fn.isdirectory(build_dir) == 0 then
                    vim.fn.mkdir(build_dir, 'p')
                    vim.notify(string.format('📁 Carpeta build/ creada en:\n%s', project_root),
                        vim.log.levels.INFO)
                end
            end

            -- Limpiar carpeta build (en la raíz del proyecto)
            local function clean_build_dir()
                local vimtex_data = vim.b.vimtex
                local project_root = vimtex_data and vimtex_data.root or vim.fn.expand('%:p:h')
                local build_dir = project_root .. '/build'

                if vim.fn.isdirectory(build_dir) == 0 then
                    vim.notify(string.format('📁 Carpeta build/ no existe en:\n%s', project_root),
                        vim.log.levels.INFO)
                    return
                end

                local choice = vim.fn.input('¿Eliminar carpeta build/? (y/n): ')
                if choice:lower() == 'y' then
                    vim.fn.delete(build_dir, 'rf')
                    vim.notify('🗑️  Carpeta build/ eliminada', vim.log.levels.INFO)
                end
            end

            -- Recompilar desde cero
            local function rebuild_clean()
                local vimtex_data = vim.b.vimtex
                local project_root = vimtex_data and vimtex_data.root or vim.fn.expand('%:p:h')
                local build_dir = project_root .. '/build'

                vim.cmd('VimtexStop')

                if vim.fn.isdirectory(build_dir) == 1 then
                    vim.fn.delete(build_dir, 'rf')
                    vim.notify('🔄 Limpiando y recompilando...', vim.log.levels.INFO)
                end

                vim.defer_fn(function()
                    ensure_build_dir()
                    vim.cmd('VimtexCompile')
                end, 500)
            end

            -- Copiar PDF a raíz (del proyecto, no del archivo actual)
            local function copy_pdf_to_root()
                local vimtex_data = vim.b.vimtex

                if not vimtex_data then
                    vim.notify('⚠️  VimTeX no está inicializado', vim.log.levels.WARN)
                    return
                end

                local project_root = vimtex_data.root or vim.fn.expand('%:p:h')
                local main_name = vimtex_data.name or vim.fn.expand('%:t:r')

                local pdf_src = project_root .. '/build/' .. main_name .. '.pdf'
                local pdf_dst = project_root .. '/' .. main_name .. '.pdf'

                if vim.fn.filereadable(pdf_src) == 0 then
                    vim.notify(string.format('⚠️  PDF no encontrado\nBuscado en: %s', pdf_src),
                        vim.log.levels.WARN)
                    return
                end

                vim.fn.system('cp ' .. pdf_src .. ' ' .. pdf_dst)
                vim.notify(string.format('📄 PDF copiado\nDesde: build/\nHacia: %s', project_root),
                    vim.log.levels.INFO)
            end

            -- ============================================
            -- COMANDOS PERSONALIZADOS
            -- ============================================

            vim.api.nvim_create_user_command("BuildClean", clean_build_dir,
                { desc = "Eliminar carpeta build/" })

            vim.api.nvim_create_user_command("BuildRebuild", rebuild_clean,
                { desc = "Limpiar build/ y recompilar" })

            vim.api.nvim_create_user_command("PDFCopy", copy_pdf_to_root,
                { desc = "Copiar PDF a raíz" })

            vim.api.nvim_create_user_command("LaTeXHelp", function()
                local help_text = [[
╔══════════════════════════════════════════════════════════╗
║            COMANDOS DE LATEX CON VIMTEX                  ║
╚══════════════════════════════════════════════════════════╝

COMPILACIÓN Y VISUALIZACIÓN:
  <leader>ll    - Iniciar compilación continua
  <leader>lc    - Limpiar archivos auxiliares
  <leader>lv    - Abrir PDF en Okular (busca en build/)
  <leader>lk    - Detener compilación
  :VimtexView   - Comando alternativo para ver PDF

NAVEGACIÓN:
  <leader>lt    - Tabla de contenidos
  <leader>li    - Información de VimTeX
  <leader>ls    - Estado de compilación
  <leader>le    - Ver errores
  <leader>lw    - Contar palabras

GESTIÓN DE BUILD/:
  <leader>lb    - Recompilar desde cero
  <leader>ld    - Eliminar build/
  <leader>lx    - Copiar PDF a raíz
  :BuildClean   - Eliminar build/
  :BuildRebuild - Recompilar
  :PDFCopy      - Copiar PDF

UTILIDADES:
  :LaTeXHelp     - Mostrar esta ayuda
  :LaTeXDebug    - Ver info del proyecto (rutas, PDFs, etc)
  :LaTeXTemplate - Insertar template básico

SNIPPETS:
  eq   - Ecuación
  fig  - Figura
  sec  - Sección

SINCRONIZACIÓN:
  - <leader>lv sincroniza tu posición actual con Okular
  - Shift+Click en Okular → salta a línea en Neovim (requiere nvr)

NOTA: El PDF se busca en build/ o en la raíz del proyecto
]]
                vim.notify(help_text, vim.log.levels.INFO, {
                    title = "LaTeX - Ayuda",
                    timeout = false,
                })
                print(help_text)
            end, { desc = "Ayuda de LaTeX" })

            vim.api.nvim_create_user_command("LaTeXTemplate", function()
                local template = [[
\documentclass[12pt,a4paper]{article}
\usepackage[utf8]{inputenc}
\usepackage[spanish]{babel}
\usepackage{amsmath}
\usepackage{graphicx}
\usepackage[colorlinks=true, linkcolor=blue]{hyperref}

\title{Título del Documento}
\author{Tu Nombre}
\date{\today}

\begin{document}

\maketitle

\section{Introducción}

Tu contenido aquí.

\section{Desarrollo}

Más contenido.

\section{Conclusión}

Conclusiones.

\end{document}
]]
                local lines = vim.split(template, '\n')
                vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
                vim.notify("📄 Template LaTeX insertado", vim.log.levels.INFO)
            end, { desc = "Insertar template LaTeX" })

            -- Comando de debug para ver información del proyecto
            vim.api.nvim_create_user_command("LaTeXDebug", function()
                local vimtex_data = vim.b.vimtex

                if not vimtex_data then
                    vim.notify('⚠️  VimTeX no está inicializado', vim.log.levels.WARN)
                    return
                end

                local tex_file = vim.fn.expand('%:p')
                local tex_name = vim.fn.expand('%:t')
                local current_dir = vim.fn.expand('%:p:h')

                -- Usar variables de VimTeX
                local project_root = vimtex_data.root or current_dir
                local main_name = vimtex_data.name or vim.fn.expand('%:t:r')
                local build_dir = project_root .. '/build'
                local pdf_build = build_dir .. '/' .. main_name .. '.pdf'
                local pdf_root = project_root .. '/' .. main_name .. '.pdf'

                local debug_info = string.format([[
╔═══════════════════════════════════════════════════════════╗
║                  LATEX DEBUG INFO                         ║
╚═══════════════════════════════════════════════════════════╝

📄 Archivo actual:     %s
📝 Nombre del archivo: %s
📁 Directorio actual:  %s

🏠 RAÍZ DEL PROYECTO (detectada por VimTeX):
   %s

📄 Archivo principal:  %s.tex
   Ubicación: %s/%s.tex
   Existe: %s

📂 Build directory:    %s
   Existe: %s

🔍 PDF en build/:      %s
   Existe: %s

🔍 PDF en raíz:        %s
   Existe: %s

🔧 Okular instalado:   %s
🔧 latexmk instalado:  %s

💡 TIP: VimTeX busca el PDF en la raíz del proyecto,
        no en la carpeta del archivo actual.
]],
                    tex_file,
                    tex_name,
                    current_dir,
                    project_root,
                    main_name,
                    project_root,
                    main_name,
                    vim.fn.filereadable(project_root .. '/' .. main_name .. '.tex') == 1 and "✓ Sí" or "✗ No",
                    build_dir,
                    vim.fn.isdirectory(build_dir) == 1 and "✓ Sí" or "✗ No",
                    pdf_build,
                    vim.fn.filereadable(pdf_build) == 1 and "✓ Sí" or "✗ No",
                    pdf_root,
                    vim.fn.filereadable(pdf_root) == 1 and "✓ Sí" or "✗ No",
                    vim.fn.executable('okular') == 1 and "✓ Sí" or "✗ No",
                    vim.fn.executable('latexmk') == 1 and "✓ Sí" or "✗ No"
                )

                print(debug_info)
                vim.notify(debug_info, vim.log.levels.INFO, {
                    title = "LaTeX Debug",
                    timeout = false,
                })
            end, { desc = "Debug info LaTeX" })

            -- ============================================
            -- AUTOCOMANDO PARA ARCHIVOS .tex
            -- ============================================
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "tex",
                callback = function()
                    -- Configuraciones específicas del buffer
                    vim.opt_local.conceallevel = 2
                    vim.opt_local.textwidth = 80
                    vim.opt_local.colorcolumn = "80"

                    vim.notify("📝 VimTeX cargado - Okular como visor",
                        vim.log.levels.INFO, {
                        title = "LaTeX",
                        timeout = 2000,
                    })
                end,
            })

            -- ============================================
            -- INTEGRACIÓN CON NVIM-CMP
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
            -- SNIPPETS BÁSICOS
            -- ============================================
            local luasnip_status, luasnip = pcall(require, 'luasnip')
            if luasnip_status then
                local s = luasnip.snippet
                local t = luasnip.text_node
                local i = luasnip.insert_node

                luasnip.add_snippets("tex", {
                    s("eq", {
                        t("\\begin{equation}"),
                        t({"", "\t"}),
                        i(1),
                        t({"", "\\end{equation}"}),
                    }),

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

            -- ============================================
            -- EXPORTAR FUNCIONES PARA REMAPS
            -- ============================================
            -- Hacer las funciones accesibles globalmente
            _G.latex_open_pdf_okular = open_pdf_okular
            _G.latex_rebuild_clean = rebuild_clean
            _G.latex_clean_build_dir = clean_build_dir
            _G.latex_copy_pdf_to_root = copy_pdf_to_root
        end,
    },

    -- ============================================
    -- SNIPPETS ADICIONALES
    -- ============================================
    {
        "iurimateus/luasnip-latex-snippets.nvim",
        dependencies = { "L3MON4D3/LuaSnip" },
        ft = "tex",
        config = function()
            require('luasnip-latex-snippets').setup()
        end,
    },
}
