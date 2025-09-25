-- ============================================
-- Line numbers
-- ============================================
vim.opt.nu = true                   -- Absolute line numbers
vim.opt.relativenumber = false      -- Relative line numbers

-- ============================================
-- Indentation and format
-- ============================================
vim.opt.tabstop = 4                 -- Tab = 4 spaces
vim.opt.softtabstop = 4             -- Backspace removes 4 spaces
vim.opt.shiftwidth = 4              -- Automatic indentation = 4 spaces
vim.opt.expandtab = true            -- Convert tabs to spaces
vim.opt.smartindent = true          -- Maintains previous line indentation
vim.opt.wrap = false                -- No line wrapping

-- ============================================
-- Backups configs
-- ============================================
vim.opt.swapfile = false            -- No swap files
vim.opt.backup = false              -- No automatic backups
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

-- ============================================
-- Search configs
-- ============================================
vim.opt.hlsearch = false            -- No persistent highlighting
vim.opt.incsearch = true            -- Incremental search


-- ============================================
-- Visual and colors
-- ============================================
vim.opt.termguicolors = true        -- 24-bit colors
vim.opt.colorcolumn = "100"         -- Line of sight in column 100

-- ============================================
-- Scroll option
-- ============================================
vim.opt.scrolloff = 8               -- 8 lines of margin when scrolling
vim.opt.smoothscroll = true         -- Soft scroll (Neovim 0.9+)

-- ============================================
-- CLIPBOARD
-- ============================================
-- requires xclip to function
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- ============================================
-- Center screen when jumping between search results
-- ============================================
vim.keymap.set('n', 'n', 'nzz', { noremap = true })     -- Next result
vim.keymap.set('n', 'N', 'Nzz', { noremap = true })     -- Previous result

-- Center screen after initiating search with '/' or '?'
vim.api.nvim_create_autocmd('CmdlineLeave', {
    pattern = { '/', '\\?' },
    callback = function()
        if vim.v.event.aborted == 0 then
            vim.cmd.normal({ 'zz', bang = true })
        end
    end,
})

-- ============================================
-- Customize the color to match your theme
-- ============================================
vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#2a2a2a" })
