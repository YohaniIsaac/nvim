-- return {
--   {
--     "iamcco/markdown-preview.nvim",
--     cmd = { "MarkdownPreview", "MarkdownPreviewStop" },
--     build = function()
--       -- Aseguramos que npm instale todas las dependencias necesarias
--       vim.fn.system("cd " .. vim.fn.stdpath("data") .. "/lazy/markdown-preview.nvim/app && npm install")
--       vim.fn["mkdp#util#install"]()
--     end,
--     init = function()
--       vim.g.mkdp_filetypes = { "markdown" }
--       vim.g.mkdp_echo_preview_url = true
--       -- Configuramos un puerto específico y aseguramos que el servidor local esté accesible
--       vim.g.mkdp_port = '8888'
--       vim.g.mkdp_open_to_the_world = false
--       -- Aseguramos que node use la versión correcta
--       vim.g.mkdp_node_modules_folder = vim.fn.stdpath("data") .. "/lazy/markdown-preview.nvim/app/node_modules"
--     end,
--     ft = { "markdown" },
--   }
-- }
--
--
return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreview", "MarkdownPreviewStop" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    config = function()
      -- Configuración principal para la vista previa
      vim.g.mkdp_open_to_the_world = 0
      vim.g.mkdp_open_ip = '127.0.0.1'
      vim.g.mkdp_port = '8888'

      -- Configuración de la vista previa
      vim.g.mkdp_preview_options = {
        sync_scroll_type = 'middle',
        theme = 'light'
      }

      -- Función para manejar la vista previa
      local function toggle_markdown_preview()
        if vim.bo.filetype ~= 'markdown' then
          print("Este comando solo funciona en archivos markdown")
          return
        end

        -- Si la vista previa está activa, la detenemos
        if vim.g.mkdp_preview_active then
          vim.cmd('MarkdownPreviewStop')
          print("Vista previa cerrada")
        else
          -- Si no está activa, la iniciamos
          vim.cmd('MarkdownPreview')
          print("Vista previa abierta en el navegador")
        end
      end

      -- Asignamos Control+k para alternar la vista previa
      vim.keymap.set('n', '<C-k>', toggle_markdown_preview,
        { silent = true, desc = "Alternar vista previa de Markdown" })
    end,
    ft = { "markdown" }
  }
}
