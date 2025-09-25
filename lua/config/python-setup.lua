local M = {}
-- ============================================
-- DOCSTRING DETECTION AND MANAGEMENT
-- ============================================

-- Function to detect multiline docstrings
function M.find_multiline_docstring_range(line_num)
    local line = vim.fn.getline(line_num)
    local quote_pattern = '"""'
    local alt_quote_pattern = "'''"

    -- Determine what type of quotes to use
    local quote_type = nil
    if string.match(line, '"""') then
        quote_type = '"""'
    elseif string.match(line, "'''") then
        quote_type = "'''"
    else
        return nil
    end

    -- Check if it is a single-line docstring
    local quote_count = 0
    for _ in string.gmatch(line, quote_type) do
        quote_count = quote_count + 1
    end

    -- If there are 2 or more quotes on the same line, it is a one-line docstring.
    if quote_count >= 2 then
        return nil -- Do not process single-line docstrings
    end

    -- Find the end of a multiline docstring
    local start_line = line_num
    local end_line = nil

    -- Search down until you find the end
    for i = line_num + 1, math.min(vim.fn.line('$'), line_num + 50) do
        local current_line = vim.fn.getline(i)
        if string.match(current_line, quote_type) then
            end_line = i
            break
        end
    end

    -- Only process if it is truly multiline
    if end_line and end_line > start_line then
        return { start_line, end_line }
    end

    return nil
end

-- Function to check if a line is part of a docstring after def/class
function M.is_docstring_after_definition(line_num)
    -- Search up to find def or class
    local found_definition = false
    local definition_line = nil

    for i = line_num - 1, math.max(1, line_num - 10), -1 do
        local prev_line = vim.fn.getline(i)
        local trimmed = vim.trim(prev_line)

        -- If we find def o class
        if string.match(prev_line, '^%s*def ') or string.match(prev_line, '^%s*class ') then
            found_definition = true
            definition_line = i
            break
        -- If we find something other than decorator or empty line, stop
        elseif trimmed ~= "" and not string.match(prev_line, '^%s*@') and not string.match(prev_line, '^%s*#') then
            break
        end
    end

    return found_definition, definition_line
end

-- ============================================
-- FOLDING FUNCTIONS FOR DOCSTRINGS
-- ============================================

-- Function to toggle current docstring
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

    -- Create a specific manual fold for the docstring
    local start_line, end_line = range[1], range[2]

    -- Go to the beginning of the docstring
    vim.fn.cursor(start_line, 1)

    -- Check if a fold already exists in this specific region
    if vim.fn.foldclosed(start_line) ~= -1 then
        -- If it is folded, unfold it
        vim.cmd('normal! zo')
        print("Docstring desplegado")
    else
        -- Create a manual fold for the docstring specifically
        vim.cmd(string.format('%d,%dfold', start_line, end_line))
        print("Docstring plegado")
    end
end

-- Function to fold all multiline docstrings
function M.fold_all_docstrings()
    local current_pos = vim.fn.getcurpos()
    local total_lines = vim.fn.line('$')
    local folded_count = 0

    -- Temporarily disable the fold method to use manual
    local original_foldmethod = vim.opt_local.foldmethod:get()
    vim.opt_local.foldmethod = 'manual'

    -- First, clean up existing folds from docstrings
    vim.cmd('normal! zE')  -- Delete all manual folds

    for line_num = 1, total_lines do
        local range = M.find_multiline_docstring_range(line_num)

        if range then
            local is_docstring, def_line = M.is_docstring_after_definition(range[1])

            if is_docstring then
                local start_line, end_line = range[1], range[2]

                -- Create a specific manual fold for this docstring
                vim.cmd(string.format('%d,%dfold', start_line, end_line))
                folded_count = folded_count + 1

                -- Jump to the end of the docstring to avoid processing it multiple times
                line_num = end_line
            end
        end
    end

    -- Restore original fold method
    vim.opt_local.foldmethod = original_foldmethod

    -- Restore position
    vim.fn.setpos('.', current_pos)
    print(string.format("Plegados %d docstrings multilinea", folded_count))
end

-- Function to display all docstrings
function M.unfold_all_docstrings()
    local current_pos = vim.fn.getcurpos()

    -- Open all folds
    vim.cmd('normal! zR')

    -- Restore position
    vim.fn.setpos('.', current_pos)
    print("Desplegados todos los docstrings")
end

-- ============================================
-- NAVIGATION BETWEEN DOCSTRINGS
-- ============================================

-- Function for intelligent navigation of docstrings
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

-- ============================================
-- FOLDING CONFIGURATION
-- ============================================
function M.setup_folding()
    -- Configure hybrid folding (manual + treesitter)
    vim.opt_local.foldmethod = 'expr'
    vim.opt_local.foldexpr = 'nvim_treesitter#foldexpr()'
    vim.opt_local.foldlevel = 99
    vim.opt_local.foldlevelstart = 99

    -- Allow manual folds too
    vim.opt_local.foldtext = 'v:lua.vim.treesitter.foldtext()'
end

-- ============================================
-- MAIN SETUP FUNCTIONS
-- ============================================
function M.setup_python_buffer()
    -- Configure folding
    M.setup_folding()

    -- Confirmation message (optional)
    vim.notify("Configuración Python cargada - Docstrings configurados", vim.log.levels.INFO, {
        title = "Python Setup",
        timeout = 2000,
    })
end

-- Main setup function (called from init.lua)
function M.setup()
    -- Create the autogroup for Python configuration
    local python_group = vim.api.nvim_create_augroup("PythonDocstringConfig", { clear = true })

    -- Autocommand to configure Python when opening a .py file
    vim.api.nvim_create_autocmd({ "FileType" }, {
        group = python_group,
        pattern = "python",
        callback = function()
            M.setup_python_buffer()
        end,
    })

    -- ============================================
    -- USER COMMANDS
    -- ============================================

    -- Utility function to display help for commands
    vim.api.nvim_create_user_command("PythonDocHelp", function()
        local help_text = [[
Comandos disponibles para Docstrings de Python:

<leader>dt  - Toggle docstring actual (plegar/desplegar el docstring donde estás)
<leader>df  - Plegar todos los docstrings del archivo
<leader>du  - Desplegar todos los docstrings del archivo
<leader>da  - Alternar entre plegar/desplegar todos los docstrings
<leader>dn  - Ir al siguiente docstring multilinea
<leader>dp  - Ir al docstring multilinea anterior

Folding nativo:
zo/zc      - Abrir/cerrar fold actual
zR/zM      - Abrir/cerrar todos los folds
zr/zm      - Abrir/cerrar folds por niveles

Los docstrings ahora se muestran en color gris tenue e itálica.
]]

        vim.notify(help_text, vim.log.levels.INFO, {
            title = "Python Docstring - Ayuda",
            timeout = 8000,
        })

        -- Also print to the command line for reference
        print(help_text)
    end, { desc = "Mostrar ayuda de comandos Python Docstring" })

    -- Command to reload Python configuration
    vim.api.nvim_create_user_command("PythonDocReload", function()
        -- Clear the module cache to force reload
        package.loaded["config.python-setup"] = nil

        if vim.bo.filetype == "python" then
            local python_config = require("config.python-setup")
            python_config.setup_python_buffer()
            vim.notify("Configuración Python recargada", vim.log.levels.INFO)
        else
            vim.notify("Este comando solo funciona en archivos Python", vim.log.levels.WARN)
        end
    end, { desc = "Recargar configuración Python Docstring" })
end

return M
