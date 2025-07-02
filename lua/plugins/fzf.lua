return{
  {
    "junegunn/fzf",
    build = ":call fzf#install()", -- Instala dependencias de fzf
    dependencies = { "junegunn/fzf.vim" }, -- Si también usas fzf.vim
    config = function()
      -- Configuración adicional de fzf (opcional)
      vim.keymap.set("n", "<leader>ff", ":Files<CR>", { noremap = true, silent = true })
    end,
  },
}
