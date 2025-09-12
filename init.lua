require("config.lazy")
require("config.set")
require("config.remaps")
require("config.python-setup")

if vim.env.SSH_TTY then
  vim.opt.clipboard = "unnamedplus"
else
  vim.opt.clipboard = "unnamedplus"
end
