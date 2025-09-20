-- lua/config/latex.lua
-- Funciones y comandos personalizados para LaTeX

-- ============================================
-- FUNCIONES PARA GESTIÓN DE CARPETA BUILD
-- ============================================

local function clean_build_dir()
    local build_dir = vim.fn.getcwd() .. '/build'

    if vim.fn.isdirectory(build_dir) == 0 then
        vim.notify('📁 Carpeta build/ no existe', vim.log.levels.INFO)
        return
    end

    local choice = vim.fn.input('¿Eliminar toda la carpeta build/? (y/n): ')
    if choice:lower() == 'y' then
        vim.fn.delete(build_dir, 'rf')
        vim.notify('🗑️  Carpeta build/ eliminada', vim.log.levels.INFO)
    end
end

local function ensure_build_dir()
    local build_dir = 'build'
    if vim.fn.isdirectory(build_dir) == 0 then
        vim.fn.mkdir(build_dir, 'p')
        vim.notify('📁 Carpeta build/ creada', vim.log.levels.INFO)
    end
end

local function rebuild_clean()
    vim.cmd('VimtexStop')

    local build_dir = vim.fn.getcwd() .. '/build'
    if vim.fn.isdirectory(build_dir) == 1 then
        vim.fn.delete(build_dir, 'rf')
        vim.notify('🔄 Limpiando build/ y recompilando...', vim.log.levels.INFO)
    end

    vim.defer_fn(function()
        ensure_build_dir()
        vim.cmd('VimtexCompile')
    end, 500)
end

local function copy_pdf_to_root()
    local pdf_name = vim.fn.expand('%:r') .. '.pdf'
    local pdf_src = 'build/' .. pdf_name
    local pdf_dst = pdf_name

    if vim.fn.filereadable(pdf_src) == 0 then
        vim.notify('⚠️  PDF no encontrado en build/', vim.log.levels.WARN)
        return
    end

    vim.fn.system('cp ' .. pdf_src .. ' ' .. pdf_dst)
    vim.notify('📄 PDF copiado a raíz del proyecto', vim.log.levels.INFO)
end

-- Comandos para gestión de build
vim.api.nvim_create_user_command("BuildClean", clean_build_dir,
    { desc = "Eliminar carpeta build/" })

vim.api.nvim_create_user_command("BuildRebuild", rebuild_clean,
    { desc = "Limpiar build/ y recompilar" })

vim.api.nvim_create_user_command("PDFCopy", copy_pdf_to_root,
    { desc = "Copiar PDF de build/ a raíz" })

-- Keymaps para gestión de build
vim.keymap.set('n', '<leader>lb', rebuild_clean,
    { desc = 'Limpiar build/ y recompilar' })

vim.keymap.set('n', '<leader>ld', clean_build_dir,
    { desc = 'Eliminar carpeta build/' })

vim.keymap.set('n', '<leader>lx', copy_pdf_to_root,
    { desc = 'Copiar PDF a raíz' })

-- ============================================
-- FUNCIONES PARA VISUALIZAR PDF CON MUPDF
-- ============================================

local function open_pdf_with_mupdf()
    -- Buscar primero en build/, luego en raíz
    local pdf_file = 'build/' .. vim.fn.expand('%:r') .. '.pdf'
    if vim.fn.filereadable(pdf_file) == 0 then
        pdf_file = vim.fn.expand('%:r') .. '.pdf'
    end

    if vim.fn.filereadable(pdf_file) == 0 then
        vim.notify('⚠️  PDF no encontrado: ' .. pdf_file, vim.log.levels.WARN)
        return
    end

    -- Verificar que mupdf esté instalado
    if vim.fn.executable('mupdf') == 0 then
        vim.notify('⚠️  mupdf no está instalado. Instálalo con: sudo pacman -S mupdf', vim.log.levels.ERROR)
        return
    end

    -- Abrir mupdf en background
    vim.fn.jobstart({'mupdf', pdf_file}, {detach = true})
    vim.notify('📄 Abriendo PDF con mupdf: ' .. vim.fn.fnamemodify(pdf_file, ':t'), vim.log.levels.INFO)
end

local function open_pdf_split_mupdf()
    -- Buscar primero en build/, luego en raíz
    local pdf_file = 'build/' .. vim.fn.expand('%:r') .. '.pdf'
    if vim.fn.filereadable(pdf_file) == 0 then
        pdf_file = vim.fn.expand('%:r') .. '.pdf'
    end

    if vim.fn.filereadable(pdf_file) == 0 then
        vim.notify('⚠️  PDF no encontrado: ' .. pdf_file, vim.log.levels.WARN)
        return
    end

    if vim.fn.executable('mupdf') == 0 then
        vim.notify('⚠️  mupdf no está instalado', vim.log.levels.ERROR)
        return
    end

    -- Abrir en split vertical con terminal
    vim.cmd('vsplit')
    vim.cmd('terminal mupdf ' .. vim.fn.shellescape(pdf_file))
    vim.cmd('wincmd p')  -- Volver a la ventana anterior
end

local function show_pdf_preview()
    local pdf_file = 'build/' .. vim.fn.expand('%:r') .. '.pdf'
    if vim.fn.filereadable(pdf_file) == 0 then
        pdf_file = vim.fn.expand('%:r') .. '.pdf'
    end

    if vim.fn.filereadable(pdf_file) == 0 then
        vim.notify('⚠️  PDF no encontrado: ' .. pdf_file, vim.log.levels.WARN)
        return
    end

    if vim.fn.executable('pdftotext') == 0 then
        vim.notify('⚠️  Instala pdftotext: sudo pacman -S poppler', vim.log.levels.WARN)
        return
    end

    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')
    vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')

    vim.cmd('vsplit')
    vim.api.nvim_win_set_buf(0, buf)

    local output = vim.fn.system('pdftotext -layout ' .. vim.fn.shellescape(pdf_file) .. ' -')
    local lines = vim.split(output, '\n')

    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.api.nvim_buf_set_option(buf, 'modifiable', false)
    vim.api.nvim_buf_set_name(buf, 'PDF Preview: ' .. vim.fn.fnamemodify(pdf_file, ':t'))

    vim.keymap.set('n', 'q', ':q<CR>', { buffer = buf, nowait = true })
end

-- Comandos para visualizar PDF
vim.api.nvim_create_user_command("PDFView", open_pdf_with_mupdf,
    { desc = "Ver PDF con mupdf" })

-- vim.api.nvim_create_user_command("PDFSplit", open_pdf_split_mupdf,
--     { desc = "Ver PDF en split vertical con mupdf" })

vim.api.nvim_create_user_command("PDFPreview", show_pdf_preview,
    { desc = "Preview de PDF como texto" })

-- Keymaps para visualizar PDF (CORREGIDO)
vim.keymap.set('n', '<leader>pv', open_pdf_with_mupdf,
    { desc = 'Ver PDF con mupdf' })
-- vim.keymap.set('n', '<leader>ps', open_pdf_split_mupdf,
--     { desc = 'Ver PDF en split con mupdf' })
vim.keymap.set('n', '<leader>pp', show_pdf_preview,
    { desc = 'Preview PDF como texto' })

-- ============================================
-- AYUDA Y COMANDOS ÚTILES
-- ============================================

vim.api.nvim_create_user_command("LaTeXHelp", function()
    local help_text = [[
📝 COMANDOS DE LATEX CON VIMTEX

═══════════════════════════════════════════════════════
COMANDOS PRINCIPALES (VimTeX)
═══════════════════════════════════════════════════════
:VimtexCompile      - Iniciar compilación continua
:VimtexCompileSS    - Compilación única (single shot)
:VimtexClean        - Limpiar archivos auxiliares
:VimtexClean!       - Limpiar TODO (incluye .pdf)
:VimtexView         - Abrir visor PDF (mupdf)
:VimtexStop         - Detener compilación
:VimtexStatus       - Ver estado de compilación

═══════════════════════════════════════════════════════
ATAJOS DE TECLADO
═══════════════════════════════════════════════════════
<leader>ll  - Compilar (continua)
<leader>lc  - Limpiar auxiliares
<leader>lv  - Ver PDF (mupdf, usa VimtexView)
<leader>lk  - Detener compilación
<leader>lt  - Tabla de contenidos

═══════════════════════════════════════════════════════
GESTIÓN DE BUILD/
═══════════════════════════════════════════════════════
:BuildClean    - Eliminar build/
:BuildRebuild  - Limpiar y recompilar
:PDFCopy       - Copiar PDF a raíz
<leader>lb     - Recompilar desde cero
<leader>ld     - Eliminar build/
<leader>lx     - Copiar PDF

═══════════════════════════════════════════════════════
VISUALIZAR PDF CON MUPDF
═══════════════════════════════════════════════════════
<leader>pv  - Abrir con mupdf (ventana separada)
<leader>ps  - Abrir en split con mupdf
<leader>pp  - Preview como texto
:PDFView    - Comando para mupdf

═══════════════════════════════════════════════════════
SNIPPETS: eq (ecuación), fig (figura), sec (sección)
]]

    vim.notify(help_text, vim.log.levels.INFO, {
        title = "LaTeX - Ayuda",
        timeout = false,
    })
    print(help_text)
end, { desc = "Mostrar ayuda de comandos LaTeX" })

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
end, { desc = "Insertar template LaTeX básico" })

return {}
