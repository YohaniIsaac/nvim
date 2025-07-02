-- Añade esto a tu configuración de plugins (en lazy.lua o similar)
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- Esta es la variante más oscura
        transparent_background = true, -- Habilita la transparencia
        term_colors = true,
        dim_inactive = {
          enabled = true,
          percentage = 0.25, -- Reduce el brillo de las ventanas inactivas
        },
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          telescope = true,
          treesitter = true,
          alpha = true, -- Soporte para alpha-nvim (tu dashboard)
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
          },
        },
      })
      -- Establecer el tema
      vim.cmd.colorscheme "catppuccin"
      -- Ajustes adicionales para mejorar la transparencia
      vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
    end,
  },
}
