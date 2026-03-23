-- ============================================
-- KEYMAPS AND CUSTOM REMAPS
-- ============================================

-- Set leader key to space
vim.g.mapleader = " "

-- ============================================
-- NEO-TREE - FILE EXPLORER
-- ============================================
vim.keymap.set('n', '<C-n>', ':Neotree toggle<CR>',
    { noremap = true, silent = true, desc = "Toggle Neo-tree" })

-- ============================================
-- HARPOON - QUICK FILE NAVIGATION
-- ============================================
local harpoon = require("harpoon")

-- Add current file to Harpoon list
vim.keymap.set('n', '<leader>a', function() harpoon:list():add() end)

-- Toggle Harpoon quick menu
vim.keymap.set('n', '<C-e>', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

-- Quick jump to marked files (1-6)
vim.keymap.set('n', '<leader>1', function() harpoon:list():select(1) end) -- Jump to file 1
vim.keymap.set('n', '<leader>2', function() harpoon:list():select(2) end) -- Jump to file 2
vim.keymap.set('n', '<leader>3', function() harpoon:list():select(3) end) -- Jump to file 3
vim.keymap.set('n', '<leader>4', function() harpoon:list():select(4) end) -- Jump to file 4
vim.keymap.set('n', '<leader>5', function() harpoon:list():select(5) end) -- Jump to file 5
vim.keymap.set('n', '<leader>6', function() harpoon:list():select(6) end) -- Jump to file 6

-- Alternative navigation
-- vim.keymap.set('n', '<Tab>', function() harpoon:list():prev() end)
-- vim.keymap.set('n', '<S-Tab>', function() harpoon:list():next() end)

-- ============================================
-- WINDOW NAVIGATION - MOVE BETWEEN SPLITS
-- ============================================
-- Navigate between windows using Ctrl + Arrow keys
-- Note: The descriptions don't match the actual directions due to the key mappings
vim.keymap.set('n', '<C-Right>', '<C-w>l', { noremap = true, silent = true, desc = 'Move to right window' })
vim.keymap.set('n', '<C-Left>', '<C-w>h', { noremap = true, silent = true, desc = 'Move to left window' })
vim.keymap.set('n', '<C-Up>', '<C-w>k', { noremap = true, silent = true, desc = 'Move to window above' })
vim.keymap.set('n', '<C-Down>', '<C-w>j', { noremap = true, silent = true, desc = 'Move to window below' })

-- ============================================
-- TERMINAL INTEGRATION
-- ============================================
-- Allow Ctrl+W in terminal mode to switch between windows
vim.api.nvim_set_keymap('t', '<C-w>', [[<C-\><C-n><C-w>]], { noremap = true, silent = true })

-- ============================================
-- WINDOW AND BUFFER MANAGEMENT
-- ============================================
-- Close current window
vim.cmd("command! CloseWindow close")
vim.keymap.set('n', '<Leader>q', ':CloseWindow<CR>', { noremap = true, silent = true })

-- Open terminal in current window
vim.keymap.set('n', '<Leader>t', ':terminal<CR>', { noremap = true, silent = true })

-- ============================================
-- SEARCH BEHAVIOR CUSTOMIZATION
-- ============================================
-- Clear search register after leaving command line (removes search highlighting)
vim.api.nvim_create_autocmd("CmdlineLeave", {
    pattern = "/,?",
    callback = function()
        vim.cmd("let @/ = ''")
    end,
})

-- ============================================
-- CLIPBOARD OPERATIONS
-- ============================================
-- Copy and paste using system clipboard with Ctrl+C and Ctrl+V
vim.api.nvim_set_keymap('v', '<C-c>', '"+y', { noremap = true, silent = true }) -- Copy selection to system clipboard
vim.api.nvim_set_keymap('n', '<C-v>', '"+p', { noremap = true, silent = true }) -- Paste from system clipboard (normal mode)
vim.api.nvim_set_keymap('v', '<C-v>', '"+p', { noremap = true, silent = true }) -- Paste from system clipboard (visual mode)

-- ============================================
-- BUFFER NAVIGATION
-- ============================================
-- Navigate between open buffers
vim.keymap.set("n", "<S-Tab>", vim.cmd.bprevious)                               -- Go to previous buffer

-- Buffer management
vim.keymap.set("n", "<Leader>bd", ":bdelete<CR>", { noremap = true, silent = true, desc = "Close current buffer" })
vim.keymap.set("n", "<Leader>bn", ":bdelete<CR>:bnext<CR>", { noremap = true, silent = true, desc = "Close current buffer and open next" })

-- ============================================
-- TERMINAL MODE NAVIGATION (DUPLICATE)
-- ============================================
-- Duplicate mapping: Allow Ctrl+W in terminal mode (already defined above)
vim.api.nvim_set_keymap('t', '<C-w>', [[<C-\><C-n><C-w>]], { noremap = true, silent = true })

-- ============================================
-- WINDOW RESIZING
-- ============================================
-- Resize windows using Ctrl+Shift+Arrow keys
vim.keymap.set("n", "<C-S-Down>", "<Cmd>resize -1<CR>", { noremap = true, silent = true, desc = "Decrease window height" })
vim.keymap.set("n", "<C-S-Up>", "<Cmd>resize +1<CR>", { noremap = true, silent = true, desc = "Increase window height" })
vim.keymap.set("n", "<C-S-Right>", "<Cmd>vertical resize +1<CR>", { noremap = true, silent = true, desc = "Increase window width" })
vim.keymap.set("n", "<C-S-Left>", "<Cmd>vertical resize -1<CR>", { noremap = true, silent = true, desc = "Decrease window width" })

-- ============================================
-- FILE OPERATIONS
-- ============================================
-- Word replacement with confirmation
vim.keymap.set('n', '<leader>p', ':%s/\\<<C-r><C-w>\\>//gc<Left><Left><Left>', { noremap = true, desc = "Replace word under cursor (with confirmation)" })

-- Smart save with whitespace cleaning option
vim.keymap.set('n', '<C-s>', ':write<CR>', { noremap = true, silent = true })

-- Copy entire file content to clipboard
-- Note: 'opts' variable is not defined, this might cause an error
vim.keymap.set('n', '<leader>ya', 'ggVGy<C-o>', opts)

-- ============================================
-- DOCUMENT SCROLLING (INSERT MODE)
-- ============================================
-- Scroll document while keeping cursor position in insert mode
vim.keymap.set('i', '<C-j>', '<C-o><C-e>', { noremap = true, silent = true }) -- Scroll document down
vim.keymap.set('i', '<C-k>', '<C-o><C-y>', { noremap = true, silent = true }) -- Scroll document up

-- ============================================
-- WINDOW SWAPPING - MOVE WINDOW POSITIONS
-- ============================================
-- Swap current window with adjacent windows using Alt + Arrow keys

-- Swap with left window
vim.keymap.set('n', '<A-Left>', function()
    local winid = vim.api.nvim_get_current_win()    -- Get current window ID
    vim.cmd('wincmd h')                             -- Move to left window
    if vim.api.nvim_get_current_win() ~= winid then
        vim.cmd('wincmd x')                         -- Swap windows if movement was successful
    else
        -- No window to the left, return to original window
        vim.api.nvim_set_current_win(winid)
    end
end, { noremap = true, silent = true, desc = 'Swap with left window' })

-- Swap with right window
vim.keymap.set('n', '<A-Right>', function()
    local winid = vim.api.nvim_get_current_win()    -- Get current window ID
    vim.cmd('wincmd l')                             -- Move to right window
    if vim.api.nvim_get_current_win() ~= winid then
        vim.cmd('wincmd x')                         -- Swap windows if movement was successful
    else
        -- No window to the right, return to original window
        vim.api.nvim_set_current_win(winid)
    end
end, { noremap = true, silent = true, desc = 'Swap with right window' })

-- Swap with upper window
vim.keymap.set('n', '<A-Up>', function()
    local winid = vim.api.nvim_get_current_win()    -- Get current window ID
    vim.cmd('wincmd k')                             -- Move to upper window
    if vim.api.nvim_get_current_win() ~= winid then
        vim.cmd('wincmd x')                         -- Swap windows if movement was successful
    else
        -- No window above, return to original window
        vim.api.nvim_set_current_win(winid)
    end
end, { noremap = true, silent = true, desc = 'Swap with upper window' })

-- Swap with lower window
vim.keymap.set('n', '<A-Down>', function()
    local winid = vim.api.nvim_get_current_win()    -- Get current window ID
    vim.cmd('wincmd j')                             -- Move to lower window
    if vim.api.nvim_get_current_win() ~= winid then
        vim.cmd('wincmd x')                         -- Swap windows if movement was successful
    else
        -- No window below, return to original window
        vim.api.nvim_set_current_win(winid)
    end
end, { noremap = true, silent = true, desc = 'Swap with lower window' })


-- ============================================
-- PYTHON-SPECIFIC KEYMAPS
-- ============================================
-- These keymaps are only available in Python (.py) files
-- They are automatically set when a Python file is opened

vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = function()
        local python_setup = require("config.python-setup")
        local opts = { buffer = true, noremap = true, silent = true }

        -- Toggle current multiline docstring
        vim.keymap.set('n', '<leader>dt', python_setup.toggle_current_docstring,
            vim.tbl_extend('force', opts, { desc = 'Toggle docstring multilinea actual' }))

        -- Fold all multiline docstrings
        vim.keymap.set('n', '<leader>df', python_setup.fold_all_docstrings,
            vim.tbl_extend('force', opts, { desc = 'Plegar todos los docstrings multilinea' }))

        -- Display all docstrings
        vim.keymap.set('n', '<leader>du', python_setup.unfold_all_docstrings,
            vim.tbl_extend('force', opts, { desc = 'Desplegar todos los docstrings' }))

        -- Toggle between folding/unfolding all
        vim.keymap.set('n', '<leader>da', function()
            local has_folds_closed = false

            -- Check for closed folds
            for i = 1, vim.fn.line('$') do
                if vim.fn.foldclosed(i) ~= -1 then
                    has_folds_closed = true
                    break
                end
            end

            if has_folds_closed then
                python_setup.unfold_all_docstrings()
            else
                python_setup.fold_all_docstrings()
            end
        end, vim.tbl_extend('force', opts, { desc = 'Alternar todos los docstrings multilinea' }))

        -- Navigating between docstrings
        vim.keymap.set('n', '<leader>dn', python_setup.go_to_next_docstring,
            vim.tbl_extend('force', opts, { desc = 'Ir al siguiente docstring multilinea' }))

        vim.keymap.set('n', '<leader>dp', python_setup.go_to_prev_docstring,
            vim.tbl_extend('force', opts, { desc = 'Ir al docstring multilinea anterior' }))
    end,
})

-- ============================================
-- BARBAR - BUFFER TAB BAR NAVIGATION
-- ============================================
local map = vim.api.nvim_set_keymap
local barbar_opts = { noremap = true, silent = true }

-- Jump to specific buffers using Tab + number
for i = 1, 9 do
    vim.keymap.set("n", "<Tab>" .. i, ":BufferGoto " .. i .. "<CR>",
        vim.tbl_extend('force', barbar_opts, { desc = "Go to buffer " .. i }))
end

-- Tab+0 goes to last buffer
vim.keymap.set("n", "<Tab>0", ":BufferLast<CR>",
    vim.tbl_extend('force', barbar_opts, { desc = "Go to last buffer" }))

-- Double Tab for next buffer
vim.keymap.set("n", "<Tab><Tab>", ":BufferNext<CR>",
    vim.tbl_extend('force', barbar_opts, { desc = "Next buffer" }))

-- Shift+Tab for previous buffer
vim.keymap.set("n", "<S-Tab>", ":BufferPrevious<CR>",
    vim.tbl_extend('force', barbar_opts, { desc = "Previous buffer" }))

-- Close buffer
vim.keymap.set("n", "<leader>c", ":BufferClose<CR>",
    vim.tbl_extend('force', barbar_opts, { desc = "Close buffer" }))

-- ============================================
-- DUCK.NVIM - ANIMATED EMOJIS
-- ============================================
local duck_opts = { noremap = true, silent = true }

-- Number of emojis to spawn
local number_of_emojis = 30

-- Define emoji types
local emoji_beer = "🍺"
local emoji_angry = "🤬"
local emoji_heart = "💜"

-- Spawn beer emojis
vim.keymap.set('n', '<leader>da', function()
    local duck = require("duck")
    for _ = 1, number_of_emojis do
        duck.hatch(emoji_beer, math.random(10, 30))
    end
end, vim.tbl_extend('force', duck_opts, { desc = "Spawn beer emojis 🍺" }))

-- Spawn angry emojis
vim.keymap.set('n', '<leader>ds', function()
    local duck = require("duck")
    for _ = 1, number_of_emojis do
        duck.hatch(emoji_angry, math.random(10, 30))
    end
end, vim.tbl_extend('force', duck_opts, { desc = "Spawn angry emojis 🤬" }))

-- Spawn heart emojis
vim.keymap.set('n', '<leader>dd', function()
    local duck = require("duck")
    for _ = 1, number_of_emojis do
        duck.hatch(emoji_heart, math.random(10, 30))
    end
end, vim.tbl_extend('force', duck_opts, { desc = "Spawn heart emojis 💜" }))

-- Remove all emojis
vim.keymap.set('n', '<leader>dk', function()
    require("duck").cook_all()
end, vim.tbl_extend('force', duck_opts, { desc = "Remove all emojis" }))


-- ============================================
-- FORMATTING - CONFORM.NVIM
-- ============================================
vim.keymap.set({ "n", "v" }, "<leader>kk", function()
    require("conform").format({
        lsp_fallback = true,
        async = true,
    })
end, { noremap = true, silent = true, desc = "Format file or range (in visual mode)" })


-- ============================================
-- FZF - FUZZY FINDER
-- ============================================
vim.keymap.set("n", "<leader>fz", ":Files<CR>",
    { noremap = true, silent = true, desc = 'FZF: Find files' })

-- ============================================
-- GIT - FUGITIVE AND LAZYGIT
-- ============================================
local git_opts = { noremap = true, silent = true }

-- Vim Fugitive
vim.keymap.set("n", "<leader>gs", ":Git<CR>",
    vim.tbl_extend('force', git_opts, { desc = "Git status (Fugitive)" }))

vim.keymap.set("n", "<leader>gb", ":Git branch<CR>",
    vim.tbl_extend('force', git_opts, { desc = "Git branches (Fugitive)" }))

-- LazyGit
vim.keymap.set("n", "<leader>fw", ":LazyGit<CR>",
    vim.tbl_extend('force', git_opts, { desc = "Open LazyGit" }))

vim.keymap.set("n", "<leader>gl", ":LazyGit<CR>",
    vim.tbl_extend('force', git_opts, { desc = "Open LazyGit (alt)" }))

-- Git Blame Float (visual selection)
vim.keymap.set("v", "<leader>gv", function()
    require("config.git-blame-float").show_blame_float()
end, vim.tbl_extend('force', git_opts, { desc = "Show git blame in floating window" }))

-- ============================================
-- WINDOW PICKER - VISUAL WINDOW SELECTION
-- ============================================
vim.keymap.set('n', '<leader>w',
    function() require('window-picker').pick_window() end,
    { noremap = true, silent = true, desc = "Pick window" }
)

-- ============================================
-- TRANSLATE.NVIM - TRANSLATION KEYMAPS
-- ============================================

-- Helper function to create translation keymaps
local function translate(mode, target, output)
    return function()
        local cmd = string.format("Translate %s -output=%s", target, output or "floating")
        if mode == "n" then
            vim.cmd(cmd)
        else
            vim.cmd("'<,'>" .. cmd)
        end
    end
end

local translate_opts = { noremap = true, silent = true }

-- TRANSLATION TO SPANISH

-- Normal mode: translate current line
vim.keymap.set("n", "<leader>te", translate("n", "ES"),
    vim.tbl_extend("force", translate_opts, { desc = "Translate line to Spanish (floating)" }))

-- Visual mode: translate selection
vim.keymap.set("v", "<leader>te", translate("v", "ES"),
    vim.tbl_extend("force", translate_opts, { desc = "Translate selection to Spanish (floating)" }))

-- Translate and insert below
vim.keymap.set("n", "<leader>tei", translate("n", "ES", "insert"),
    vim.tbl_extend("force", translate_opts, { desc = "Translate and insert to Spanish" }))
vim.keymap.set("v", "<leader>tei", translate("v", "ES", "insert"),
    vim.tbl_extend("force", translate_opts, { desc = "Translate and insert to Spanish" }))

-- Translate and replace
vim.keymap.set("n", "<leader>ter", translate("n", "ES", "replace"),
    vim.tbl_extend("force", translate_opts, { desc = "Translate and replace to Spanish" }))
vim.keymap.set("v", "<leader>ter", translate("v", "ES", "replace"),
    vim.tbl_extend("force", translate_opts, { desc = "Translate and replace to Spanish" }))

-- TRANSLATION TO ENGLISH

vim.keymap.set("n", "<leader>ti", translate("n", "EN"),
    vim.tbl_extend("force", translate_opts, { desc = "Translate line to English (floating)" }))
vim.keymap.set("v", "<leader>ti", translate("v", "EN"),
    vim.tbl_extend("force", translate_opts, { desc = "Translate selection to English (floating)" }))

vim.keymap.set("n", "<leader>tii", translate("n", "EN", "insert"),
    vim.tbl_extend("force", translate_opts, { desc = "Translate and insert to English" }))
vim.keymap.set("v", "<leader>tii", translate("v", "EN", "insert"),
    vim.tbl_extend("force", translate_opts, { desc = "Translate and insert to English" }))

vim.keymap.set("n", "<leader>tir", translate("n", "EN", "replace"),
    vim.tbl_extend("force", translate_opts, { desc = "Translate and replace to English" }))
vim.keymap.set("v", "<leader>tir", translate("v", "EN", "replace"),
    vim.tbl_extend("force", translate_opts, { desc = "Translate and replace to English" }))

-- COMMENT TRANSLATION

-- Translate comment to Spanish
vim.keymap.set("n", "<leader>tc", function()
    vim.cmd("Translate ES -comment")
end, vim.tbl_extend("force", translate_opts, { desc = "Translate comment to Spanish" }))

-- Translate comment to English
vim.keymap.set("n", "<leader>tci", function()
    vim.cmd("Translate EN -comment")
end, vim.tbl_extend("force", translate_opts, { desc = "Translate comment to English" }))

-- WORD UNDER CURSOR TRANSLATION

vim.keymap.set("n", "<leader>tw", function()
    -- Select word under cursor and translate
    vim.cmd("normal! viw")
    vim.cmd("'<,'>Translate ES")
end, vim.tbl_extend("force", translate_opts, { desc = "Translate word to Spanish" }))

vim.keymap.set("n", "<leader>twi", function()
    vim.cmd("normal! viw")
    vim.cmd("'<,'>Translate EN")
end, vim.tbl_extend("force", translate_opts, { desc = "Translate word to English" }))

-- SPLIT WINDOW TRANSLATION

vim.keymap.set("n", "<leader>ts", translate("n", "ES", "split"),
    vim.tbl_extend("force", translate_opts, { desc = "Translate in split window" }))
vim.keymap.set("v", "<leader>ts", translate("v", "ES", "split"),
    vim.tbl_extend("force", translate_opts, { desc = "Translate in split window" }))


-- ============================================
-- LATEX - VIMTEX KEYMAPS
-- ============================================
-- These keymaps are only available in files .tex
vim.api.nvim_create_autocmd("FileType", {
    pattern = "tex",
    callback = function()
        local opts = { buffer = true, noremap = true, silent = true }

        -- COMPILATION

        vim.keymap.set('n', '<leader>ll', '<cmd>VimtexCompile<CR>',
            vim.tbl_extend('force', opts, { desc = 'LaTeX: Compilar' }))

        vim.keymap.set('n', '<leader>lc', '<cmd>VimtexClean<CR>',
            vim.tbl_extend('force', opts, { desc = 'LaTeX: Limpiar auxiliares' }))

        vim.keymap.set('n', '<leader>lk', '<cmd>VimtexStop<CR>',
            vim.tbl_extend('force', opts, { desc = 'LaTeX: Detener compilación' }))

        -- DISPLAY

        vim.keymap.set('n', '<leader>lv', function()
            _G.latex_open_pdf_okular()
        end, vim.tbl_extend('force', opts, { desc = 'LaTeX: Ver PDF en Okular' }))

        -- NAVIGATION AND INFO

        vim.keymap.set('n', '<leader>lt', '<cmd>VimtexTocOpen<CR>',
            vim.tbl_extend('force', opts, { desc = 'LaTeX: Tabla de contenidos' }))

        vim.keymap.set('n', '<leader>li', '<cmd>VimtexInfo<CR>',
            vim.tbl_extend('force', opts, { desc = 'LaTeX: Información VimTeX' }))

        vim.keymap.set('n', '<leader>ls', '<cmd>VimtexStatus<CR>',
            vim.tbl_extend('force', opts, { desc = 'LaTeX: Estado compilación' }))

        -- LSP DIAGNOSTICS

        vim.keymap.set('n', 'gd', vim.lsp.buf.definition,
            vim.tbl_extend('force', opts, { desc = 'LaTeX: Ir a definición' }))

        vim.keymap.set('n', 'gr', vim.lsp.buf.references,
            vim.tbl_extend('force', opts, { desc = 'LaTeX: Ver referencias' }))

        vim.keymap.set('n', 'K', vim.lsp.buf.hover,
            vim.tbl_extend('force', opts, { desc = 'LaTeX: Documentación' }))

        vim.keymap.set('n', '<leader>lp', vim.diagnostic.goto_prev,
            vim.tbl_extend('force', opts, { desc = 'LaTeX: Error anterior' }))

        vim.keymap.set('n', '<leader>ln', vim.diagnostic.goto_next,
            vim.tbl_extend('force', opts, { desc = 'LaTeX: Siguiente error' }))

        vim.keymap.set('n', '<leader>le', vim.diagnostic.open_float,
            vim.tbl_extend('force', opts, { desc = 'LaTeX: Mostrar diagnóstico flotante' }))

        vim.keymap.set('n', '<leader>lq', vim.diagnostic.setloclist,
            vim.tbl_extend('force', opts, { desc = 'LaTeX: Lista de diagnósticos' }))

        vim.keymap.set('n', '<leader>ee', function()
            _G.latex_show_all_errors()
        end, vim.tbl_extend('force', opts, { desc = 'LaTeX: Ver todos los errores (texlab + ChkTeX)' }))

        vim.keymap.set('n', '<leader>lw', '<cmd>VimtexCountWords<CR>',
            vim.tbl_extend('force', opts, { desc = 'LaTeX: Contar palabras' }))

        -- BUILD/ MANAGEMENT

        vim.keymap.set('n', '<leader>lb', function()
            _G.latex_rebuild_clean()
        end, vim.tbl_extend('force', opts, { desc = 'LaTeX: Recompilar desde cero' }))

        vim.keymap.set('n', '<leader>ld', function()
            _G.latex_clean_build_dir()
        end, vim.tbl_extend('force', opts, { desc = 'LaTeX: Eliminar build/' }))

        vim.keymap.set('n', '<leader>lx', function()
            _G.latex_copy_pdf_to_root()
        end, vim.tbl_extend('force', opts, { desc = 'LaTeX: Copiar PDF a raíz' }))
    end,
})

-- ============================================
-- MARKDOWN - MARKDOWN-PREVIEW KEYMAPS
-- ============================================
-- These keymaps are only available in files .md
vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        local opts = { buffer = true, noremap = true, silent = true }

        -- VISUALIZATION
        vim.keymap.set('n', '<leader>lv', '<cmd>MarkdownPreview<CR>',
            vim.tbl_extend('force', opts, { desc = 'Markdown: Abrir vista previa en navegador' }))

        vim.keymap.set('n', '<leader>lk', '<cmd>MarkdownPreviewStop<CR>',
            vim.tbl_extend('force', opts, { desc = 'Markdown: Detener vista previa' }))

        vim.keymap.set('n', '<leader>lt', '<cmd>MarkdownPreviewToggle<CR>',
            vim.tbl_extend('force', opts, { desc = 'Markdown: Alternar vista previa' }))
    end,
})

-- ============================================
-- CUSTOM CODE CHECKER (OXYCONTROLLER)
-- ============================================
vim.keymap.set('n', '<leader>cc', function()
    -- Get the file path relative to the git root
    local file = vim.fn.expand('%')
    local git_root = vim.fn.system('git rev-parse --show-toplevel 2>/dev/null'):gsub('\n', '')

    -- Check if we're in the oxycontroller project
    if git_root:match('oxycontroller$') then
        -- Calculate floating window dimensions (80% of screen)
        local width = math.floor(vim.o.columns * 0.8)
        local height = math.floor(vim.o.lines * 0.8)
        local row = math.floor((vim.o.lines - height) / 2)
        local col = math.floor((vim.o.columns - width) / 2)

        -- Create a buffer for the floating window
        local buf = vim.api.nvim_create_buf(false, true)

        -- Define floating window configuration
        local opts = {
            relative = 'editor',
            width = width,
            height = height,
            row = row,
            col = col,
            style = 'minimal',
            border = 'rounded',
            title = ' Code Checker ',
            title_pos = 'center',
        }

        -- Open the floating window
        local win = vim.api.nvim_open_win(buf, true, opts)

        -- Start the terminal in the floating window
        vim.fn.termopen('cd ' .. vim.fn.shellescape(git_root) ..
                        ' && ./scripts/checker -k ' .. vim.fn.shellescape(file), {
            on_exit = function()
                -- When the command finishes, switch to normal mode automatically
                vim.cmd('stopinsert')
            end
        })

        -- Set keymaps to close the floating window easily
        vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = buf, silent = true })
        vim.keymap.set('n', '<Esc>', '<cmd>close<cr>', { buffer = buf, silent = true })

        -- Start in insert mode but switch to normal mode after command finishes
        vim.cmd('startinsert')

        -- Wait a bit and then switch to normal mode to allow navigation
        vim.defer_fn(function()
            if vim.api.nvim_win_is_valid(win) then
                vim.cmd('stopinsert')
            end
        end, 100)
    else
        vim.notify('Not in oxycontroller project!', vim.log.levels.WARN)
    end
end, { desc = 'Check code with custom checker script (floating)' })

-- ============================================
-- RELOAD NEOVIM CONFIGURATION
-- ============================================
vim.keymap.set('n', '<leader>rr', function()
    -- Clear module cache for local modules
    for name, _ in pairs(package.loaded) do
        if name:match('^lua') or name:match('^config') or name:match('^plugins') then
            package.loaded[name] = nil
        end
    end

    -- Reload init.lua
    dofile(vim.env.MYVIMRC)

    -- Restart LSP servers
    vim.cmd('LspRestart')

    vim.notify('Configuración recargada completamente', vim.log.levels.INFO)
end, { desc = 'Recargar configuración completa de Neovim' })
