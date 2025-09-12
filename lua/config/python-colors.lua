-- lua/config/python-colors.lua
-- Configuración específica para archivos Python (VERSIÓN CORREGIDA)

local M = {}

-- Función para configurar colores de docstrings
function M.setup_python_colors()
    -- Colores tenues para docstrings usando treesitter
    vim.api.nvim_set_hl(0, "@string.documentation.python", {
        fg = "#6c7086",  -- Color gris tenue (ajústalo según tu tema)
        italic = true,
        bg = "NONE"
    })

    -- También para docstrings multilinea
    vim.api.nvim_set_hl(0, "@comment.documentation.python", {
        fg = "#6c7086",
        italic = true,
        bg = "NONE"
    })

    -- Alternativos si los anteriores no funcionan
    vim.api.nvim_set_hl(0, "pythonDocstring", {
        fg = "#6c7086",
        italic = true,
        bg = "NONE"
    })

    -- Para compatibilidad con diferentes versiones de treesitter
    vim.api.nvim_set_hl(0, "@string.special.python", {
        fg = "#6c7086",
        italic = true,
        bg = "NONE"
    })
end

-- Función mejorada para detectar docstrings multilinea
function M.find_multiline_docstring_range(line_num)
    local line = vim.fn.getline(line_num)
    local quote_pattern = '"""'
    local alt_quote_pattern = "'''"

    -- Determinar qué tipo de quotes usar
    local quote_type = nil
    if string.match(line, '"""') then
        quote_type = '"""'
    elseif string.match(line, "'''") then
        quote_type = "'''"
    else
        return nil
    end

    -- Verificar si es docstring de una sola línea
    local quote_count = 0
    for _ in string.gmatch(line, quote_type) do
        quote_count = quote_count + 1
    end

    -- Si hay 2 o más quotes en la misma línea, es docstring de una línea
    if quote_count >= 2 then
        return nil -- No procesar docstrings de una línea
    end

    -- Buscar el final del docstring multilinea
    local start_line = line_num
    local end_line = nil

    -- Buscar hacia abajo hasta encontrar el final
    for i = line_num + 1, math.min(vim.fn.line('$'), line_num + 50) do
        local current_line = vim.fn.getline(i)
        if string.match(current_line, quote_type) then
            end_line = i
            break
        end
    end

    -- Solo procesar si es realmente multilinea
    if end_line and end_line > start_line then
        return { start_line, end_line }
    end

    return nil
end

-- Función para verificar si una línea es parte de un docstring después de def/class
function M.is_docstring_after_definition(line_num)
    -- Buscar hacia arriba para encontrar def o class
    local found_definition = false
    local definition_line = nil

    for i = line_num - 1, math.max(1, line_num - 10), -1 do
        local prev_line = vim.fn.getline(i)
        local trimmed = vim.trim(prev_line)  -- Arreglado: usar vim.trim en lugar de string.trim

        -- Si encontramos def o class
        if string.match(prev_line, '^%s*def ') or string.match(prev_line, '^%s*class ') then
            found_definition = true
            definition_line = i
            break
        -- Si encontramos algo que no sea decorador o línea vacía, parar
        elseif trimmed ~= "" and not string.match(prev_line, '^%s*@') and not string.match(prev_line, '^%s*#') then
            break
        end
    end

    return found_definition, definition_line
end

-- Función mejorada para toggle docstring actual
function M.toggle_current_docstring()
    local line_num = vim.fn.line('.')
    local range = M.find_multiline_docstring_range(line_num)

    if not range then
        print("No hay docstring multilinea en esta línea")
        return
    end

    local is_docstring, def_line = M.is_docstring_after_definition(range[1])
    if not is_docstring then
        print("Este no es un docstring de función/clase")
        return
    end

    -- Crear un fold manual específico para el docstring
    local start_line, end_line = range[1], range[2]

    -- Ir al inicio del docstring
    vim.fn.cursor(start_line, 1)

    -- Verificar si ya existe un fold en esta región específica
    if vim.fn.foldclosed(start_line) ~= -1 then
        -- Si está plegado, desplegarlo
        vim.cmd('normal! zo')
        print("Docstring desplegado")
    else
        -- Crear un fold manual para el docstring específicamente
        vim.cmd(string.format('%d,%dfold', start_line, end_line))
        print("Docstring plegado")
    end
end

-- Función mejorada para plegar todos los docstrings multilinea
function M.fold_all_docstrings()
    local current_pos = vim.fn.getcurpos()
    local total_lines = vim.fn.line('$')
    local folded_count = 0

    -- Deshabilitar temporalmente el método de fold para usar manual
    local original_foldmethod = vim.opt_local.foldmethod:get()
    vim.opt_local.foldmethod = 'manual'

    -- Primero, limpiar folds existentes de docstrings
    vim.cmd('normal! zE')  -- Eliminar todos los folds manuales

    for line_num = 1, total_lines do
        local range = M.find_multiline_docstring_range(line_num)

        if range then
            local is_docstring, def_line = M.is_docstring_after_definition(range[1])

            if is_docstring then
                local start_line, end_line = range[1], range[2]

                -- Crear fold manual específico para este docstring
                vim.cmd(string.format('%d,%dfold', start_line, end_line))
                folded_count = folded_count + 1

                -- Saltar al final del docstring para evitar procesarlo múltiples veces
                line_num = end_line
            end
        end
    end

    -- Restaurar método de fold original
    vim.opt_local.foldmethod = original_foldmethod

    -- Restaurar posición
    vim.fn.setpos('.', current_pos)
    print(string.format("Plegados %d docstrings multilinea", folded_count))
end

-- Función para desplegar todos los docstrings
function M.unfold_all_docstrings()
    local current_pos = vim.fn.getcurpos()

    -- Abrir todos los folds
    vim.cmd('normal! zR')

    -- Restaurar posición
    vim.fn.setpos('.', current_pos)
    print("Desplegados todos los docstrings")
end

-- Función mejorada para navegación inteligente de docstrings
function M.go_to_next_docstring()
    local current_line = vim.fn.line('.')
    local total_lines = vim.fn.line('$')

    for line_num = current_line + 1, total_lines do
        local range = M.find_multiline_docstring_range(line_num)
        if range then
            local is_docstring = M.is_docstring_after_definition(range[1])
            if is_docstring then
                vim.fn.cursor(range[1], 1)
                print("Siguiente docstring multilinea")
                return
            end
        end
    end

    print("No hay más docstrings multilinea")
end

function M.go_to_prev_docstring()
    local current_line = vim.fn.line('.')

    for line_num = current_line - 1, 1, -1 do
        local range = M.find_multiline_docstring_range(line_num)
        if range then
            local is_docstring = M.is_docstring_after_definition(range[1])
            if is_docstring then
                vim.fn.cursor(range[1], 1)
                print("Docstring multilinea anterior")
                return
            end
        end
    end

    print("No hay docstrings multilinea anteriores")
end

-- Configurar keymaps específicos para Python
function M.setup_python_keymaps()
    local opts = { buffer = true, noremap = true, silent = true }

    -- Toggle docstring multilinea actual
    vim.keymap.set('n', '<leader>dt', M.toggle_current_docstring,
        vim.tbl_extend('force', opts, { desc = 'Toggle docstring multilinea actual' }))

    -- Plegar todos los docstrings multilinea
    vim.keymap.set('n', '<leader>df', M.fold_all_docstrings,
        vim.tbl_extend('force', opts, { desc = 'Plegar todos los docstrings multilinea' }))

    -- Desplegar todos los docstrings
    vim.keymap.set('n', '<leader>du', M.unfold_all_docstrings,
        vim.tbl_extend('force', opts, { desc = 'Desplegar todos los docstrings' }))

    -- Alternar entre plegar/desplegar todos
    vim.keymap.set('n', '<leader>da', function()
        local line = vim.fn.line('.')
        local has_folds_closed = false

        -- Verificar si hay folds cerrados
        for i = 1, vim.fn.line('$') do
            if vim.fn.foldclosed(i) ~= -1 then
                has_folds_closed = true
                break
            end
        end

        if has_folds_closed then
            M.unfold_all_docstrings()
        else
            M.fold_all_docstrings()
        end
    end, vim.tbl_extend('force', opts, { desc = 'Alternar todos los docstrings multilinea' }))

    -- Navegación entre docstrings (NUEVO)
    vim.keymap.set('n', '<leader>dn', M.go_to_next_docstring,
        vim.tbl_extend('force', opts, { desc = 'Ir al siguiente docstring multilinea' }))

    vim.keymap.set('n', '<leader>dp', M.go_to_prev_docstring,
        vim.tbl_extend('force', opts, { desc = 'Ir al docstring multilinea anterior' }))
end

-- Función principal de setup
function M.setup()
    M.setup_python_colors()
    M.setup_python_keymaps()

    -- Configurar folding híbrido (manual + treesitter)
    vim.opt_local.foldmethod = 'expr'
    vim.opt_local.foldexpr = 'nvim_treesitter#foldexpr()'
    vim.opt_local.foldlevel = 99
    vim.opt_local.foldlevelstart = 99

    -- Permitir folds manuales también
    vim.opt_local.foldtext = 'v:lua.vim.treesitter.foldtext()'
end

return M
