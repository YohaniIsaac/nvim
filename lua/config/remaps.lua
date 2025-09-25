-- ============================================
-- KEYMAPS AND CUSTOM REMAPS
-- ============================================

-- Set leader key to space
vim.g.mapleader = " "

-- ============================================
-- TELESCOPE - FILE FINDER AND SEARCH
-- ============================================
local builtin = require('telescope.builtin')

-- Basic Telescope commands
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})   -- Find files in project
vim.keymap.set('n', '<C-p>', builtin.git_files, {})         -- Find git-tracked files
vim.keymap.set('n', '<leader>ps', builtin.live_grep, {})    -- Search text in files

-- Set telescope as default picker for LazyVim
vim.g.lazyvim_picker = "telescope"

-- Enhanced Telescope commands (includes hidden files)
vim.keymap.set("n", "<leader>ff", function()
    builtin.find_files({
        hidden = true,                                      -- Include hidden files
        no_ignore = true,                                   -- Ignore .gitignore rules
    })
end, { noremap = true, silent = true, desc = "Find files (including hidden)" })

vim.keymap.set("n", "<leader>fg", function()
    builtin.live_grep({
        hidden = true,                                      -- Search in hidden files
        no_ignore = true,                                   -- Ignore .gitignore rules
    })
end, { noremap = true, silent = true, desc = "Live grep (including hidden)" })

-- Search for word under cursor using Telescope
vim.keymap.set("n", "<leader>gg", function()
    builtin.grep_string({
        word_match = "-w",                                  -- Match whole words only
        hidden = true,                                      -- Search in hidden files
        no_ignore = true,                                   -- Ignore .gitignore rules
    })
end, { noremap = true, silent = true, desc = "Search word under cursor" })

-- ============================================
-- NEO-TREE - FILE EXPLORER
-- ============================================
-- Note: These are duplicate mappings (both map to <C-n>)
vim.keymap.set('n', '<C-n>', ':Neotree filesystem reveal left<CR>', {}) -- Open file explorer (reveal current file)
vim.keymap.set('n', '<C-n>', ':Neotree toggle<CR>', {})                 -- Toggle file explorer

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
vim.keymap.set('n', '<C-s>', function()
    -- Check if file has trailing whitespace
    local has_whitespace = vim.fn.search('\\s\\+$', 'nw') > 0

    if has_whitespace then
        local choice = vim.fn.input("Clean whitespace? (y/n): ")
        if choice:lower() == 'y' then
            vim.cmd('StripWhitespace')              -- Requires vim-better-whitespace plugin
        end
    end

    vim.cmd('write')                                -- Save file
end, { noremap = true, silent = true })

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
