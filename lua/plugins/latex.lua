return {
    {
        "lervag/vimtex",
        lazy = false,
        ft = { "tex", "bib" },
        config = function()
            -- ============================================
            -- GENERAL SETTINGS
            -- ============================================
            vim.g.vimtex_enabled = 1
            vim.g.vimtex_compiler_silent = 1
            vim.g.vimtex_compiler_method = 'latexmk'

            -- ============================================
            -- COMPILER - BUILD FOLDER
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

            -- Reverse sync (from Okular to Neovim)
            vim.g.vimtex_compiler_progname = 'nvr'

            -- ============================================
            -- SYNTAX AND FOLDING
            -- ============================================
            vim.g.vimtex_fold_enabled = 1
            vim.g.vimtex_fold_manual = 0
            vim.g.vimtex_syntax_enabled = 1
            vim.g.vimtex_syntax_conceal_disable = 0

            -- ============================================
            -- QUICKFIX (ERRORS)
            -- ============================================
            vim.g.vimtex_quickfix_mode = 0
            vim.g.vimtex_quickfix_open_on_warning = 0
            vim.g.vimtex_quickfix_method = 'latexlog'

            -- ============================================
            -- INDENTATION
            -- ============================================
            vim.g.vimtex_indent_enabled = 1
            vim.g.vimtex_indent_bib_enabled = 1

            -- ============================================
            -- TABLE OF CONTENTS
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
            -- AUXILIARY FUNCTIONS
            -- ============================================
            -- Open PDF in Okular (search in build/ from the project root)
            local function open_pdf_okular()
                -- Using VimTeX variables to get the project root
                local vimtex_data = vim.b.vimtex

                if not vimtex_data then
                    vim.notify('VimTeX no está inicializado\nAbre un archivo .tex válido',
                        vim.log.levels.WARN)
                    return
                end

                -- Get the project root and main file name
                local project_root = vimtex_data.root or vim.fn.expand('%:p:h')
                local main_name = vimtex_data.name or vim.fn.expand('%:t:r')

                -- Build possible PDF paths (from the project root)
                local pdf_paths = {
                    project_root .. '/build/' .. main_name .. '.pdf',  -- Root/build/main.pdf
                    project_root .. '/' .. main_name .. '.pdf',        -- Root/main.pdf
                }

                -- Find the PDF in the possible locations
                local pdf_path = nil
                for _, path in ipairs(pdf_paths) do
                    if vim.fn.filereadable(path) == 1 then
                        pdf_path = path
                        break
                    end
                end

                -- If not found, display error message with searched paths
                if not pdf_path then
                    local search_info = string.format(
                        'PDF no encontrado\n\n' ..
                        'Raíz del proyecto: %s\n' ..
                        'Archivo principal: %s.tex\n\n' ..
                        'Buscado en:\n• %s\n• %s\n\n' ..
                        'Compila primero con <leader>ll',
                        project_root,
                        main_name,
                        pdf_paths[1],
                        pdf_paths[2]
                    )
                    vim.notify(search_info, vim.log.levels.WARN)
                    return
                end

                -- Verify that Okular is installed
                if vim.fn.executable('okular') == 0 then
                    vim.notify('Okular no está instalado\nInstala con: sudo pacman -S okular',
                        vim.log.levels.ERROR)
                    return
                end

                -- Get current .tex file and line for synchronization
                local tex_file = vim.fn.expand('%:p')
                local current_line = vim.fn.line('.')

                -- Open Okular with synchronization
                local cmd = string.format(
                    'okular --unique "file:%s#src:%d %s" > /dev/null 2>&1 &',
                    pdf_path,
                    current_line,
                    tex_file
                )

                vim.fn.system(cmd)
                vim.notify(string.format('PDF abierto: %s\n Desde: %s',
                    vim.fn.fnamemodify(pdf_path, ':t'),
                    project_root),
                    vim.log.levels.INFO)
            end

            -- Create build folder if it doesn't exist (in the project root)
            local function ensure_build_dir()
                local vimtex_data = vim.b.vimtex
                local project_root = vimtex_data and vimtex_data.root or vim.fn.expand('%:p:h')
                local build_dir = project_root .. '/build'

                if vim.fn.isdirectory(build_dir) == 0 then
                    vim.fn.mkdir(build_dir, 'p')
                    vim.notify(string.format('Carpeta build/ creada en:\n%s', project_root),
                        vim.log.levels.INFO)
                end
            end

            -- Clean build folder (in the root of the project)
            local function clean_build_dir()
                local vimtex_data = vim.b.vimtex
                local project_root = vimtex_data and vimtex_data.root or vim.fn.expand('%:p:h')
                local build_dir = project_root .. '/build'

                if vim.fn.isdirectory(build_dir) == 0 then
                    vim.notify(string.format('Carpeta build/ no existe en:\n%s', project_root),
                        vim.log.levels.INFO)
                    return
                end

                local choice = vim.fn.input('¿Eliminar carpeta build/? (y/n): ')
                if choice:lower() == 'y' then
                    vim.fn.delete(build_dir, 'rf')
                    vim.notify('Carpeta build/ eliminada', vim.log.levels.INFO)
                end
            end

            -- Recompile from scratch
            local function rebuild_clean()
                local vimtex_data = vim.b.vimtex
                local project_root = vimtex_data and vimtex_data.root or vim.fn.expand('%:p:h')
                local build_dir = project_root .. '/build'

                vim.cmd('VimtexStop')

                if vim.fn.isdirectory(build_dir) == 1 then
                    vim.fn.delete(build_dir, 'rf')
                    vim.notify('Limpiando y recompilando...', vim.log.levels.INFO)
                end

                vim.defer_fn(function()
                    ensure_build_dir()
                    vim.cmd('VimtexCompile')
                end, 500)
            end

            -- Copy PDF to root (of the project, not the current file)
            local function copy_pdf_to_root()
                local vimtex_data = vim.b.vimtex

                if not vimtex_data then
                    vim.notify('VimTeX no está inicializado', vim.log.levels.WARN)
                    return
                end

                local project_root = vimtex_data.root or vim.fn.expand('%:p:h')
                local main_name = vimtex_data.name or vim.fn.expand('%:t:r')

                local pdf_src = project_root .. '/build/' .. main_name .. '.pdf'
                local pdf_dst = project_root .. '/' .. main_name .. '.pdf'

                if vim.fn.filereadable(pdf_src) == 0 then
                    vim.notify(string.format('PDF no encontrado\nBuscado en: %s', pdf_src),
                        vim.log.levels.WARN)
                    return
                end

                vim.fn.system('cp ' .. pdf_src .. ' ' .. pdf_dst)
                vim.notify(string.format('PDF copiado\nDesde: build/\nHacia: %s', project_root),
                    vim.log.levels.INFO)
            end

            -- ============================================
            -- CUSTOM COMMANDS
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
  <leader>le    - Mostrar diagnóstico flotante (línea actual)
  <leader>ee    - Ver TODOS los errores (texlab + ChkTeX completo)
  <leader>lw    - Contar palabras
  <leader>lp    - Ir a error anterior
  <leader>ln    - Ir a siguiente error

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
  :LaTeXChkTeX   - Ejecutar solo ChkTeX manualmente
  :LaTeXErrors   - Ver análisis completo (texlab + ChkTeX)

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
                vim.notify("Template LaTeX insertado", vim.log.levels.INFO)
            end, { desc = "Insertar template LaTeX" })

            -- Debug command to view project information
            -- Command to test ChkTeX manually
            vim.api.nvim_create_user_command("LaTeXChkTeX", function()
                local current_file = vim.fn.expand('%:p')

                if vim.fn.filereadable(current_file) == 0 then
                    vim.notify('Archivo no válido', vim.log.levels.WARN)
                    return
                end

                if vim.fn.executable('chktex') == 0 then
                    vim.notify('ChkTeX no está instalado\nInstala con: sudo pacman -S texlive-binextra',
                        vim.log.levels.ERROR)
                    return
                end

                -- Ejecutar ChkTeX y mostrar output
                vim.notify('Ejecutando ChkTeX...', vim.log.levels.INFO)
                local output = vim.fn.system('chktex -v0 -q ' .. vim.fn.shellescape(current_file))

                if vim.v.shell_error == 0 and output == '' then
                    vim.notify('ChkTeX: No se encontraron problemas', vim.log.levels.INFO)
                else
                    -- Mostrar output en un buffer flotante
                    local lines = vim.split(output, '\n')
                    local buf = vim.api.nvim_create_buf(false, true)
                    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

                    local width = 80
                    local height = math.min(#lines + 2, 20)
                    local win = vim.api.nvim_open_win(buf, true, {
                        relative = 'editor',
                        width = width,
                        height = height,
                        col = (vim.o.columns - width) / 2,
                        row = (vim.o.lines - height) / 2,
                        border = 'rounded',
                        style = 'minimal',
                        title = ' ChkTeX Results ',
                        title_pos = 'center',
                    })

                    vim.api.nvim_buf_set_option(buf, 'modifiable', false)
                    vim.api.nvim_buf_set_option(buf, 'filetype', 'chktex')
                    vim.api.nvim_win_set_option(win, 'wrap', true)

                    -- Close with q or <Esc>
                    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = buf, silent = true })
                    vim.keymap.set('n', '<Esc>', '<cmd>close<cr>', { buffer = buf, silent = true })
                end
            end, { desc = "Ejecutar ChkTeX manualmente" })

            -- Combined errors view: ChkTeX + texlab diagnostics
            local function show_all_errors()
                local current_file = vim.fn.expand('%:p')
                local current_bufnr = vim.api.nvim_get_current_buf()

                if vim.fn.filereadable(current_file) == 0 then
                    vim.notify('Archivo no válido', vim.log.levels.WARN)
                    return
                end

                -- Get texlab diagnostics
                local diagnostics = vim.diagnostic.get(current_bufnr)

                -- Build content
                local lines = {}

                -- Header
                table.insert(lines, '╔══════════════════════════════════════════════════════════════════╗')
                table.insert(lines, '║           ANÁLISIS COMPLETO DE ERRORES - LaTeX                  ║')
                table.insert(lines, '╚══════════════════════════════════════════════════════════════════╝')
                table.insert(lines, '')

                -- Section 1: texlab diagnostics
                table.insert(lines, '┌─  DIAGNÓSTICOS DE TEXLAB (LSP) ─────────────────────────────┐')
                table.insert(lines, '')

                if #diagnostics > 0 then
                    for i, diag in ipairs(diagnostics) do
                        local severity = ''
                        if diag.severity == vim.diagnostic.severity.ERROR then
                            severity = ' ERROR'
                        elseif diag.severity == vim.diagnostic.severity.WARN then
                            severity = ' WARN'
                        elseif diag.severity == vim.diagnostic.severity.INFO then
                            severity = ' INFO'
                        else
                            severity = ' HINT'
                        end

                        local line_num = diag.lnum + 1
                        table.insert(lines, string.format('%d. %s [Línea %d]', i, severity, line_num))
                        table.insert(lines, string.format('   %s', diag.message))
                        table.insert(lines, '')
                    end
                else
                    table.insert(lines, '    No se encontraron diagnósticos de texlab')
                    table.insert(lines, '')
                end

                table.insert(lines, '└────────────────────────────────────────────────────────────────┘')
                table.insert(lines, '')

                -- Section 2: ChkTeX output
                table.insert(lines, '┌─  ANÁLISIS DE ChkTeX (Linting) ─────────────────────────────┐')
                table.insert(lines, '')

                if vim.fn.executable('chktex') == 1 then
                    local chktex_output = vim.fn.system('chktex -v1 -q ' .. vim.fn.shellescape(current_file))

                    if vim.v.shell_error == 0 and chktex_output == '' then
                        table.insert(lines, '    ChkTeX: No se encontraron problemas')
                        table.insert(lines, '')
                    else
                        local chktex_lines = vim.split(chktex_output, '\n')
                        for _, line in ipairs(chktex_lines) do
                            if line ~= '' then
                                table.insert(lines, '   ' .. line)
                            end
                        end
                    end
                else
                    table.insert(lines, '     ChkTeX no está instalado')
                    table.insert(lines, '')
                end

                table.insert(lines, '└────────────────────────────────────────────────────────────────┘')
                table.insert(lines, '')
                table.insert(lines, 'Presiona q o <Esc> para cerrar')

                -- Create floating window
                local buf = vim.api.nvim_create_buf(false, true)
                vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

                local width = math.min(100, vim.o.columns - 4)
                local height = math.min(#lines + 2, vim.o.lines - 4)
                local win = vim.api.nvim_open_win(buf, true, {
                    relative = 'editor',
                    width = width,
                    height = height,
                    col = (vim.o.columns - width) / 2,
                    row = (vim.o.lines - height) / 2,
                    border = 'rounded',
                    style = 'minimal',
                    title = ' Errores LaTeX ',
                    title_pos = 'center',
                })

                vim.api.nvim_buf_set_option(buf, 'modifiable', false)
                vim.api.nvim_buf_set_option(buf, 'filetype', 'latex-errors')
                vim.api.nvim_win_set_option(win, 'wrap', true)

                -- Close with q or <Esc>
                vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = buf, silent = true })
                vim.keymap.set('n', '<Esc>', '<cmd>close<cr>', { buffer = buf, silent = true })
            end

            -- Export function globally
            _G.latex_show_all_errors = show_all_errors

            -- Create command
            vim.api.nvim_create_user_command("LaTeXErrors", show_all_errors,
                { desc = "Mostrar todos los errores (texlab + ChkTeX)" })

            vim.api.nvim_create_user_command("LaTeXDebug", function()
                local vimtex_data = vim.b.vimtex

                if not vimtex_data then
                    vim.notify('  VimTeX no está inicializado', vim.log.levels.WARN)
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
                local log_file = build_dir .. '/' .. main_name .. '.log'

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

📋 Log file:           %s
   Existe: %s

🔧 Okular instalado:   %s
🔧 latexmk instalado:  %s
🔧 texlab instalado:   %s
🔧 chktex instalado:   %s

📝 ChkTeX config:      %s
   Existe: %s

💡 TIP: VimTeX busca el PDF y log en la raíz del proyecto,
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
                    log_file,
                    vim.fn.filereadable(log_file) == 1 and "✓ Sí" or "✗ No",
                    vim.fn.executable('okular') == 1 and "✓ Sí" or "✗ No",
                    vim.fn.executable('latexmk') == 1 and "✓ Sí" or "✗ No",
                    vim.fn.executable('texlab') == 1 and "✓ Sí" or "✗ No",
                    vim.fn.executable('chktex') == 1 and "✓ Sí" or "✗ No",
                    vim.fn.expand('~/.chktexrc'),
                    vim.fn.filereadable(vim.fn.expand('~/.chktexrc')) == 1 and "✓ Sí" or "✗ No"
                )

                print(debug_info)
                vim.notify(debug_info, vim.log.levels.INFO, {
                    title = "LaTeX Debug",
                    timeout = false,
                })
            end, { desc = "Debug info LaTeX" })

            -- ============================================
            -- AUTOCOMMAND FOR .TEX FILES
            -- ============================================
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "tex",
                callback = function()
                    -- Specific buffer settings
                    vim.opt_local.conceallevel = 0
                    vim.opt_local.textwidth = 0
                    vim.opt_local.formatoptions:remove('t') -- Disable autotext
                    -- ============================================
                    -- WORD WRAP - VISUAL LINE ADJUSTMENT
                    -- ============================================
                    vim.opt_local.wrap = true           -- Activate visual line adjustment
                    vim.opt_local.linebreak = true      -- Break into complete words
                    vim.opt_local.breakindent = true    -- Maintain indentation on wrapped lines
                    vim.opt_local.showbreak = "↪ "      -- Visual wrapped line indicator

                    vim.notify(" VimTeX + texlab cargados - Usa <leader>l para comandos LaTeX",
                        vim.log.levels.INFO, {
                        title = "LaTeX",
                        timeout = 2000,
                    })
                end,
            })
            -- ============================================
            -- AUTO-SAVED BEFORE COMPILING
            -- ============================================
            vim.api.nvim_create_autocmd("User", {
                pattern = "VimtexEventCompileStarted",
                callback = function()
                    vim.cmd('silent! wall')  -- Save all modified buffers
                    vim.notify("Archivos guardados antes de compilar", vim.log.levels.INFO, {
                        timeout = 1000,
                    })
                end,
            })
            -- ============================================
            -- INTEGRATION WITH NVIM-CMP
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
            -- BASIC SNIPPETS
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
            -- EXPORT FUNCTIONS FOR REMAPS
            -- ============================================
            -- Make functions globally accessible
            _G.latex_open_pdf_okular = open_pdf_okular
            _G.latex_rebuild_clean = rebuild_clean
            _G.latex_clean_build_dir = clean_build_dir
            _G.latex_copy_pdf_to_root = copy_pdf_to_root
        end,
    },

    -- ============================================
    -- ADDITIONAL SNIPPETS
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
