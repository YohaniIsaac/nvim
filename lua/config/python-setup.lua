-- lua/config/python-setup.lua
-- Este archivo debe ser requerido en tu init.lua

-- Crear el autogrupo para configuración de Python
local python_group = vim.api.nvim_create_augroup("PythonDocstringConfig", { clear = true })

-- Autocomando para configurar Python cuando se abre un archivo .py
vim.api.nvim_create_autocmd({ "FileType" }, {
    group = python_group,
    pattern = "python",
    callback = function()
        -- Cargar nuestra configuración personalizada
        local python_config = require("config.python-colors")
        python_config.setup()

        -- Mensaje de confirmación (opcional, puedes comentarlo después)
        vim.notify("🐍 Configuración Python cargada - Docstrings configurados", vim.log.levels.INFO, {
            title = "Python Setup",
            timeout = 2000,
        })
    end,
})

-- Autocomando adicional para actualizar colores cuando cambie el esquema de color
vim.api.nvim_create_autocmd({ "ColorScheme" }, {
    group = python_group,
    callback = function()
        -- Recargar colores de docstrings después de cambiar tema
        vim.defer_fn(function()
            if vim.bo.filetype == "python" then
                local python_config = require("config.python-colors")
                python_config.setup_python_colors()
            end
        end, 100)
    end,
})

-- Función utilitaria para mostrar ayuda de comandos
vim.api.nvim_create_user_command("PythonDocHelp", function()
    local help_text = [[
🐍 Comandos disponibles para Docstrings de Python:

<leader>dt  - Toggle docstring actual (plegar/desplegar el docstring donde estás)
<leader>df  - Plegar todos los docstrings del archivo
<leader>du  - Desplegar todos los docstrings del archivo
<leader>da  - Alternar entre plegar/desplegar todos los docstrings

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

    -- También imprimir en el command line para referencia
    print(help_text)
end, { desc = "Mostrar ayuda de comandos Python Docstring" })

-- Comando para recargar configuración Python
vim.api.nvim_create_user_command("PythonDocReload", function()
    -- Limpiar el cache del módulo para forzar recarga
    package.loaded["config.python-colors"] = nil

    if vim.bo.filetype == "python" then
        local python_config = require("config.python-colors")
        python_config.setup()
        vim.notify("🔄 Configuración Python recargada", vim.log.levels.INFO)
    else
        vim.notify("⚠️  Este comando solo funciona en archivos Python", vim.log.levels.WARN)
    end
end, { desc = "Recargar configuración Python Docstring" })
