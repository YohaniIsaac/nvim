-- ============================================
-- KEYMAPS AND CUSTOM REMAPS
-- ============================================

-- Set leader key to space
vim.g.mapleader = " "

-- ============================================
-- TELESCOPE - FILE FINDER AND SEARCH
-- ============================================
local builtin = require('telescope.builtin')

-- Set telescope as default picker for LazyVim
vim.g.lazyvim_picker = "telescope"

-- BASIC TELESCOPE COMMANDS

-- Find files in project
vim.keymap.set('n', '<leader>pf', builtin.find_files,
    { desc = "Find files in project" })

-- Find git-tracked files only
vim.keymap.set('n', '<C-p>', builtin.git_files,
    { desc = "Find git-tracked files" })

-- Live grep (basic)
vim.keymap.set('n', '<leader>ps', builtin.live_grep,
    { desc = "Live grep" })

-- ENHANCED TELESCOPE COMMANDS (WITH HIDDEN FILES)

-- Live grep in current directory (includes hidden files and all options)
vim.keymap.set("n", "<leader>ff", function()
    builtin.live_grep({
        search_dirs = { vim.fn.getcwd() },
        hidden = true,
        no_ignore = true,
        additional_args = {
            "--hidden",
            "--no-ignore",
            "--follow",
            "--max-depth=8",
            "--glob=!build/**",
            "--glob=!.git/**",
            "--glob=!.venv/**",
            "--glob=!.cache/**",
            "--glob=!*.hex"
        }
    })
end, { noremap = true, silent = true, desc = "Live grep in current directory (full options)" })

-- Live grep with hidden files (simpler version)
vim.keymap.set("n", "<leader>fg", function()
    builtin.live_grep({
        hidden = true,
        no_ignore = true,
    })
end, { noremap = true, silent = true, desc = "Live grep (including hidden)" })

-- GREP WORD UNDER CURSOR

-- Grep word under cursor (simple version)
vim.keymap.set("n", "<leader>gg", function()
    builtin.grep_string({
        word_match = "-w",
        hidden = true,
        no_ignore = true,
    })
end, { noremap = true, silent = true, desc = "Find word under cursor (simple)" })

-- Grep word under cursor (full options version)
vim.keymap.set("n", "<leader>gw", function()
    builtin.grep_string({
        word_match = "-w",
        search_dirs = { vim.fn.getcwd() },
        hidden = true,
        no_ignore = true,
        additional_args = {
            "--hidden",
            "--no-ignore",
            "--follow",
            "--max-depth=8",
            "--glob=!build/**",
            "--glob=!.git/**",
            "--glob=!.venv/**",
            "--glob=!.cache/**",
            "--glob=!*.hex"
        }
    })
end, { noremap = true, silent = true, desc = "Find word under cursor (full options)" })

-- ADVANCED FILE SEARCH WITH EXCLUSIONS
vim.keymap.set("n", "<leader>fe", function()
    -- Ask for search term
    local search_term = vim.fn.input("Buscar término: ")
    if search_term == "" then return end

    -- Ask for exclusion terms
    local exclude_terms = vim.fn.input("Excluir términos (separados por coma): ")
    local exclude_args = {}

    -- Process exclusion terms
    if exclude_terms ~= "" then
        for term in string.gmatch(exclude_terms, "([^,]+)") do
            term = string.gsub(term, "^%s*(.-)%s*$", "%1") -- trim whitespace
            table.insert(exclude_args, "--glob=!" .. term)
        end
    end

    -- Configure additional arguments for ripgrep
    local additional_args = {
        "--hidden",
        "--no-ignore",
        "--follow",
        "--max-depth=8",
        "--glob=!build/**",
        "--glob=!.git/**",
        "--glob=!.venv/**",
        "--glob=!.cache/**",
        "--glob=!*.hex"
    }

    -- Add exclusion terms to arguments
    for _, arg in ipairs(exclude_args) do
        table.insert(additional_args, arg)
    end

    -- Execute search
    builtin.find_files({
        search_dirs = { vim.fn.getcwd() },
        hidden = true,
        no_ignore = true,
        additional_args = additional_args,
        search_file = search_term
    })
end, { noremap = true, silent = true, desc = "Advanced file search with exclusions" })

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
-- Word replacement
-- vim.keymap.set('n', '<leader>p', ':%s/\\<<C-r><C-w>\\>//c<Left><Left>', { noremap = true, silent = true })

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
