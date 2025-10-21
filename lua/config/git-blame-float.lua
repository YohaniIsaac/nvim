-- ============================================
-- GIT BLAME FLOATING WINDOW
-- ============================================
-- Shows git log -L for selected lines in a floating window

local M = {}

-- Function to show git blame in floating window for visual selection
function M.show_blame_float()
    -- Get the visual selection range
    local start_line = vim.fn.line("'<")
    local end_line = vim.fn.line("'>")
    local file = vim.fn.expand('%:p')

    -- Check if we're in a git repository
    local git_root = vim.fn.system('git rev-parse --show-toplevel 2>/dev/null'):gsub('\n', '')
    if vim.v.shell_error ~= 0 then
        vim.notify('Not in a git repository', vim.log.levels.WARN)
        return
    end

    -- Get the file path relative to git root
    local relative_file = vim.fn.fnamemodify(file, ':.')

    -- Build the git log command with full diff
    -- We use --color=never because Neovim's git syntax will handle coloring
    local cmd = string.format(
        'git log -L%d,%d:%s --color=never',
        start_line,
        end_line,
        relative_file
    )

    -- Execute the command
    local output = vim.fn.system(cmd)

    if vim.v.shell_error ~= 0 then
        vim.notify('Error executing git log: ' .. output, vim.log.levels.ERROR)
        return
    end

    if output == '' then
        vim.notify('No git history found for these lines', vim.log.levels.INFO)
        return
    end

    -- Split output into lines
    local lines = vim.split(output, '\n')

    -- Create a buffer for the floating window
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.api.nvim_buf_set_option(buf, 'modifiable', false)
    vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')
    vim.api.nvim_buf_set_option(buf, 'filetype', 'git')

    -- Enable syntax highlighting
    vim.api.nvim_buf_call(buf, function()
        vim.cmd('syntax on')
    end)

    -- Calculate window size (larger for diff display)
    local width = math.min(120, math.floor(vim.o.columns * 0.9))
    local height = math.min(#lines + 2, math.floor(vim.o.lines * 0.85))

    -- Calculate position (centered)
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    -- Window options
    local opts = {
        relative = 'editor',
        width = width,
        height = height,
        row = row,
        col = col,
        style = 'minimal',
        border = 'rounded',
        title = string.format(' Git Blame (lines %d-%d) ', start_line, end_line),
        title_pos = 'center',
    }

    -- Open the floating window
    local win = vim.api.nvim_open_win(buf, true, opts)

    -- Set window options
    vim.api.nvim_win_set_option(win, 'wrap', true)
    vim.api.nvim_win_set_option(win, 'cursorline', true)

    -- Keybindings for the floating window
    local keymaps = {
        ['q'] = '<cmd>close<CR>',
        ['<Esc>'] = '<cmd>close<CR>',
    }

    for key, cmd in pairs(keymaps) do
        vim.api.nvim_buf_set_keymap(buf, 'n', key, cmd, { noremap = true, silent = true })
    end

    -- Set highlight for the floating window
    vim.api.nvim_win_set_option(win, 'winhl', 'Normal:Normal,FloatBorder:FloatBorder')
end

return M
