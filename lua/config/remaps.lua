vim.g.mapleader = " "
-- PLUGINS
-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', builtin.live_grep, {})

--remaps for neo-tree
vim.keymap.set('n', '<C-n>', ':Neotree filesystem reveal left<CR>', {})
vim.keymap.set('n', '<C-n>', ':Neotree toggle<CR>', {})

----------------------------------------------------------
-- Mover a la ventana izquierda (Ctrl + felchas)
vim.keymap.set('n', '<C-Right>', '<C-w>h', { noremap = true, silent = true, desc = 'Mover a la ventana izquierda' })
vim.keymap.set('n', '<C-Left>', '<C-w>l', { noremap = true, silent = true, desc = 'Mover a la ventana derecha' })
vim.keymap.set('n', '<C-Up>', '<C-w>k', { noremap = true, silent = true, desc = 'Mover a la ventana de arriba' })
vim.keymap.set('n', '<C-Down>', '<C-w>j', { noremap = true, silent = true, desc = 'Mover a la ventana de abajo' })

-- Navegación entre ventanas
vim.keymap.set('n', '<C-Left>', '<C-w>h', {}) -- Mover a la ventana izquierda
vim.keymap.set('n', '<C-Right>', '<C-w>l', {})-- Mover a la ventana derecha
vim.keymap.set('n', '<C-Up>', '<C-w>k', {})   -- Mover a la ventana de arriba
vim.keymap.set('n', '<C-Down>', '<C-w>j', {}) -- Mover a la ventana de abajo

-- Función para cambiar de ventana repetidamente
local function repeatable_move(direction)
    return function()
        vim.cmd('wincmd ' .. direction)                                            -- Ejecuta el comando de movimiento
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Ignore>', true, false, true)) -- Ignora la tecla presionada
    end
end

-- Mapea Ctrl+W en modo terminal para permitir la navegación entre ventanas
vim.api.nvim_set_keymap('t', '<C-w>', [[<C-\><C-n><C-w>]], { noremap = true, silent = true })
-- vim.cmd("set smartcase")

--Cerrar ventana actual
vim.cmd("command! CloseWindow close")
vim.keymap.set('n', '<Leader>q', ':CloseWindow<CR>', { noremap = true, silent = true })

-- Abrir terminal
vim.keymap.set('n', '<Leader>t', ':terminal<CR>', { noremap = true, silent = true })

-- Función para limpiar la búsqueda de palabras cada vez que se realiza una
vim.api.nvim_create_autocmd("CmdlineLeave", {
    pattern = "/,?",
    callback = function()
        vim.cmd("let @/ = ''")
    end,
})

-- Configuración para copiar y pegar con Ctrl+c y Ctrl+v
vim.api.nvim_set_keymap('v', '<C-c>', '"+y', { noremap = true, silent = true }) -- Copiar con Ctrl+c
vim.api.nvim_set_keymap('n', '<C-v>', '"+p', { noremap = true, silent = true }) -- Pegar con Ctrl+v en modo normal
vim.api.nvim_set_keymap('v', '<C-v>', '"+p', { noremap = true, silent = true }) -- Pegar con Ctrl+v en modo visual

-- shift + tab para ir al buffer anterior
vim.keymap.set("n", "<S-Tab>", vim.cmd.bprevious)                               -- Moverse entre buffers
-- Cerrar el buffer actual
vim.keymap.set("n", "<Leader>bd", ":bdelete<CR>", { noremap = true, silent = true, desc = "Cerrar buffer actual" })
-- Cerrar el buffer actual y abrir el siguiente
vim.keymap.set("n", "<Leader>bn", ":bdelete<CR>:bnext<CR>", { noremap = true, silent = true, desc = "Cerrar buffer y abrir el siguiente" })

-- Mapea Ctrl+W en modo terminal para permitir la navegación entre ventanas
vim.api.nvim_set_keymap('t', '<C-w>', [[<C-\><C-n><C-w>]], { noremap = true, silent = true })

-- then you need to set the option below.
vim.g.lazyvim_picker = "telescope"

-- Keymaps para buscar archivos y hacer live grep con Telescope
local builtin = require("telescope.builtin")

-- Busca archivos incluyendo ocultos
vim.keymap.set("n", "<leader>ff", function()
    builtin.find_files({
        hidden = true,
        no_ignore = true,
    })
end, { noremap = true, silent = true, desc = "Find files" })

-- Realiza búsqueda de texto en archivos
vim.keymap.set("n", "<leader>fg", function()
    builtin.live_grep({
        hidden = true,
        no_ignore = true,
    })
end, { noremap = true, silent = true, desc = "Live grep" })

-- Buscar la palabra bajo el cursor en Telescope
vim.keymap.set("n", "<leader>gg", function()
    builtin.grep_string({
        word_match = "-w",
        hidden = true,
        no_ignore = true,
    })
end, { noremap = true, silent = true, desc = "Buscar palabra bajo el cursor" })

--remaps for harpoon
local harpoon = require("harpoon")

-- Añade el archivo actual a la lista Harpooon
vim.keymap.set('n', '<leader>a', function() harpoon:list():add() end)
-- Muestra u oculta el menú de Harpooon ctrl + E
vim.keymap.set('n', '<C-e>', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
-- Saltar rápidamente a los archivos marcados de 1 al 6
vim.keymap.set('n', '<leader>1', function() harpoon:list():select(1) end)
vim.keymap.set('n', '<leader>2', function() harpoon:list():select(2) end)
vim.keymap.set('n', '<leader>3', function() harpoon:list():select(3) end)
vim.keymap.set('n', '<leader>4', function() harpoon:list():select(4) end)
vim.keymap.set('n', '<leader>5', function() harpoon:list():select(5) end)
vim.keymap.set('n', '<leader>6', function() harpoon:list():select(6) end)
-- vim.keymap.set('n', '<Tab>', function() harpoon:list():prev() end)
-- vim.keymap.set('n', '<S-Tab>', function() harpoon:list():next() end)

-- Mapeos estilo Vim tradicional (extendiendo <C-w>)
vim.keymap.set("n", "<C-A-Down>", "<Cmd>resize -1<CR>", { noremap = true, silent = true, desc = "Disminuir altura de la ventana" })  -- Disminuir alto
vim.keymap.set("n", "<C-A-Up>", "<Cmd>resize +1<CR>", { noremap = true, silent = true, desc = "Aumentar altura de la ventana" })   -- Aumentar alto
vim.keymap.set("n", "<C-A-Right>", "<Cmd>vertical resize +1<CR>", { noremap = true, silent = true, desc = "Aumentar ancho de la ventana" })  -- Aumentar ancho
vim.keymap.set("n", "<C-A-Left>", "<Cmd>vertical resize -1<CR>", { noremap = true, silent = true, desc = "Disminuir ancho de la ventana" })  -- Disminuir ancho

-- remap to replace words
--vim.keymap.set('n', '<leader>p', ':%s/\\<<C-r><C-w>\\>//c<Left><Left>', { noremap = true, silent = true })
-- Guarda el archivo actual
vim.keymap.set('n', '<C-s>', '<cmd> w <CR>', opts)

-- Copiar el contenido de todo el archivo
vim.keymap.set('n', '<leader>ya', 'ggVGy<C-o>', opts)

-- Mover documento manteniendo el cursor en su posición (modo insertar)
vim.keymap.set('i', '<C-j>', '<C-o><C-e>', { noremap = true, silent = true }) -- Desplaza documento hacia abajo
vim.keymap.set('i', '<C-k>', '<C-o><C-y>', { noremap = true, silent = true }) -- Desplaza documento hacia arriba

-- Mover ventanas (intercambiar posiciones) con Alt + flechas
-- Intercambiar posiciones con la ventana adyacente (Alt + flechas)
-- Intercambiar posiciones con la ventana adyacente (Alt + flechas)
vim.keymap.set('n', '<A-Left>', function()
    local winid = vim.api.nvim_get_current_win()  -- Obtiene el ID de la ventana actual
    vim.cmd('wincmd h')
    if vim.api.nvim_get_current_win() ~= winid then
        vim.cmd('wincmd x')  -- Intercambia las ventanas
    else
        -- No hay ventana a la izquierda, volvemos a la ventana original
        vim.api.nvim_set_current_win(winid)
    end
end, { noremap = true, silent = true, desc = 'Intercambiar con ventana a la izquierda' })

vim.keymap.set('n', '<A-Right>', function()
    local winid = vim.api.nvim_get_current_win()  -- Obtiene el ID de la ventana actual
    vim.cmd('wincmd l')
    if vim.api.nvim_get_current_win() ~= winid then
        vim.cmd('wincmd x')  -- Intercambia las ventanas
    else
        -- No hay ventana a la derecha, volvemos a la ventana original
        vim.api.nvim_set_current_win(winid)
    end
end, { noremap = true, silent = true, desc = 'Intercambiar con ventana a la derecha' })

vim.keymap.set('n', '<A-Up>', function()
    local winid = vim.api.nvim_get_current_win()  -- Obtiene el ID de la ventana actual
    vim.cmd('wincmd k')
    if vim.api.nvim_get_current_win() ~= winid then
        vim.cmd('wincmd x')  -- Intercambia las ventanas
    else
        -- No hay ventana arriba, volvemos a la ventana original
        vim.api.nvim_set_current_win(winid)
    end
end, { noremap = true, silent = true, desc = 'Intercambiar con ventana arriba' })

vim.keymap.set('n', '<A-Down>', function()
    local winid = vim.api.nvim_get_current_win()  -- Obtiene el ID de la ventana actual
    vim.cmd('wincmd j')
    if vim.api.nvim_get_current_win() ~= winid then
        vim.cmd('wincmd x')  -- Intercambia las ventanas
    else
        -- No hay ventana abajo, volvemos a la ventana original
        vim.api.nvim_set_current_win(winid)
    end
end, { noremap = true, silent = true, desc = 'Intercambiar con ventana abajo' })





-- -- Mapeo para salir del modo terminal con doble Escape
-- local term_esc_count = 0
-- local term_esc_timer = nil
--
-- vim.api.nvim_set_keymap('t', '<Esc>', function()
--   local now = vim.loop.now()
--
--   -- Si es la primera pulsación de Escape
--   if term_esc_count == 0 then
--     term_esc_count = 1
--     term_esc_timer = vim.defer_fn(function()
--       term_esc_count = 0
--     end, 300) -- 300ms para detectar la segunda pulsación
--     return '<Esc>'
--
--   -- Si es la segunda pulsación dentro del tiempo
--   elseif term_esc_count == 1 then
--     term_esc_count = 0
--     if term_esc_timer then
--       vim.fn.timer_stop(term_esc_timer)
--       term_esc_timer = nil
--     end
--     return '<C-\\><C-n>' -- Esto cambia al modo normal
--   end
-- end, { expr = true, noremap = true })

-- Alternativa: Mapeo con Control+Escape para salir del modo terminal
vim.api.nvim_set_keymap('t', '<C-Esc>', [[<C-\><C-n>]], { noremap = true, silent = true })

-- Configuración para reemplazar palabras/texto en Neovim
-- Agregar estas líneas a tu archivo lua/config/remaps.lua

-- ============================================
-- REEMPLAZO DE PALABRAS Y TEXTO
-- ============================================

-- 1. Reemplazar la palabra bajo el cursor en todo el archivo (con confirmación)
-- Presiona <leader>rw y luego escribe la nueva palabra
vim.keymap.set('n', '<leader>rw', ':%s/\\<<C-r><C-w>\\>//gc<Left><Left><Left>',
    { noremap = true, desc = "Reemplazar palabra bajo el cursor (con confirmación)" })

-- 2. Reemplazar la palabra bajo el cursor en todo el archivo (sin confirmación)
-- Más rápido pero más peligroso
vim.keymap.set('n', '<leader>RW', ':%s/\\<<C-r><C-w>\\>//g<Left><Left>',
    { noremap = true, desc = "Reemplazar palabra bajo el cursor (sin confirmación)" })

-- 3. Reemplazar palabra seleccionada en modo visual
vim.keymap.set('v', '<leader>rw', '"hy:%s/<C-r>h//gc<left><left><left>',
    { noremap = true, desc = "Reemplazar texto seleccionado (con confirmación)" })

-- 4. Reemplazar en la línea actual solamente
vim.keymap.set('n', '<leader>rl', ':s/\\<<C-r><C-w>\\>//gc<Left><Left><Left>',
    { noremap = true, desc = "Reemplazar palabra en línea actual" })

-- 5. Búsqueda y reemplazo interactivo (más potente)
vim.keymap.set('n', '<leader>rs', ':s/',
    { noremap = true, desc = "Búsqueda y reemplazo manual" })

-- 6. Reemplazo global interactivo
vim.keymap.set('n', '<leader>rg', ':%s/',
    { noremap = true, desc = "Búsqueda y reemplazo global manual" })

-- ============================================
-- FUNCIONES AVANZADAS PARA REEMPLAZO
-- ============================================

-- Función para reemplazar con confirmación visual mejorada
local function replace_word_confirm()
    local word = vim.fn.expand('<cword>')
    local input = vim.fn.input('Reemplazar "' .. word .. '" por: ')
    if input ~= '' then
        vim.cmd('%s/\\<' .. word .. '\\>/' .. input .. '/gc')
    end
end

-- Función para reemplazar en archivos múltiples (requiere confirmación)
local function replace_in_multiple_files()
    local word = vim.fn.expand('<cword>')
    local replacement = vim.fn.input('Reemplazar "' .. word .. '" por: ')
    if replacement ~= '' then
        local pattern = vim.fn.input('Archivos a modificar (ej: *.lua, *.py): ', '*.lua')
        if pattern ~= '' then
            vim.cmd('args ' .. pattern)
            vim.cmd('argdo %s/\\<' .. word .. '\\>/' .. replacement .. '/gc | update')
        end
    end
end

-- Atajos para las funciones avanzadas
vim.keymap.set('n', '<leader>rc', replace_word_confirm,
    { noremap = true, desc = "Reemplazar palabra con diálogo" })

vim.keymap.set('n', '<leader>rm', replace_in_multiple_files,
    { noremap = true, desc = "Reemplazar en múltiples archivos" })

-- ============================================
-- ATAJOS ADICIONALES ÚTILES
-- ============================================

-- Resaltar todas las ocurrencias de la palabra bajo el cursor
vim.keymap.set('n', '<leader>*', '*N',
    { noremap = true, desc = "Resaltar palabra bajo el cursor" })

-- Limpiar resaltado de búsqueda
vim.keymap.set('n', '<leader>nh', ':nohlsearch<CR>',
    { noremap = true, silent = true, desc = "Limpiar resaltado de búsqueda" })

-- ============================================
-- INFORMACIÓN DE USO
-- ============================================

--[[
GUÍA DE USO:

1. <leader>rw - Coloca el cursor sobre la palabra que quieres cambiar y presiona estas teclas.
               Te aparecerá algo como: :%s/\<palabra\>//gc
               Escribe la nueva palabra y presiona Enter.
               Te preguntará en cada ocurrencia si quieres reemplazar (y/n/a/q)

2. <leader>RW - Igual que el anterior pero reemplaza todas sin preguntar (¡cuidado!)

3. En modo visual: Selecciona texto y presiona <leader>rw para reemplazarlo

4. <leader>rl - Solo reemplaza en la línea actual

5. <leader>rc - Versión con diálogo más amigable

6. <leader>rm - Para reemplazar en múltiples archivos

OPCIONES EN EL DIÁLOGO DE CONFIRMACIÓN:
- y: Sí, reemplazar esta ocurrencia
- n: No, saltar esta ocurrencia
- a: Sí a todo (reemplazar todas las restantes)
- q: Quit (salir sin hacer más cambios)
- l: Last (reemplazar esta y salir)
]]
