return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local fzf = require("fzf-lua")
    -- Configuración para búsqueda de archivos
    -- Usamos --full-path para que fd busque el patrón en la ruta completa
    -- y agregamos --regex para permitir búsquedas exactas
    local files_config = {
      normal = "fd --type f --follow --case-sensitive --full-path --regex "
        .. "--exclude .git "
        .. "--exclude node_modules "
        .. "--exclude **pycache** "
        .. "--exclude .DS_Store "
        .. "--exclude '*.pyc' "
        .. "--exclude .env "
        .. "--exclude '*.rst' "
        .. "--exclude '*.json' "
        .. "--exclude '*.ninja' "
        .. "--exclude '*.map' ",  -- Excluir archivos .map
      hidden = "fd --type f --hidden --follow --no-ignore --case-sensitive --full-path --regex "
        .. "--exclude .git "
        .. "--exclude node_modules "
        .. "--exclude **pycache** "
        .. "--exclude .DS_Store "
        .. "--exclude '*.pyc' "
        .. "--exclude .env "
        .. "--exclude '*.rst' "
        .. "--exclude '*.json' "
        .. "--exclude '*.ninja' "
        .. "--exclude '*.map' "  -- Excluir archivos .map
    }
    -- Configuración para grep
    -- Usamos -w para que rg busque palabras exactas
    local grep_config = {
      normal = "rg --column --line-number --no-heading --color=always --case-sensitive -w "
        .. "--max-columns=150 "
        .. "--max-columns-preview "
        .. "--glob '!.git/*' "
        .. "--glob '!node_modules/*' "
        .. "--glob '!__pycache__/*' "
        .. "--glob '!*.pyc' "
        .. "--glob '!*.rst' "
        .. "--glob '!*.json' "
        .. "--glob '!*.map' "
        .. "--glob '!*.ninja' "
        .. "--glob '!.env' ",
      hidden = "rg --column --line-number --no-heading --color=always --case-sensitive -w --hidden --no-ignore "
        .. "--max-columns=150 "
        .. "--max-columns-preview "
        .. "--glob '!.git/*' "
        .. "--glob '!node_modules/*' "
        .. "--glob '!__pycache__/*' "
        .. "--glob '!*.pyc' "
        .. "--glob '!*.rst' "
        .. "--glob '!*.json' "
        .. "--glob '!*.ninja' "
        .. "--glob '!*.map' "
        .. "--glob '!.env' "
    }
    _G.hidden_search = true
    local config = {
      winopts = {
        height = 0.85,
        width = 0.80,
        preview = {
          layout = "vertical",
          vertical = "down:50%",
          horizontal = "right:50%",
          delay = 50,
          title = true,
          scrollbar = 'float',
        },
        border = true,
        fullscreen = false,
      },
      keymap = {
        builtin = {
          ["<C-j>"] = "down",
          ["<C-k>"] = "up",
          ["<C-Down>"] = "preview-page-down",
          ["<C-Up>"] = "preview-page-up",
          ["<C-space>"] = "toggle-preview",
        },
        fzf = {
          ["ctrl-q"] = "select-all+accept",
        },
      },
      files = {
        prompt = "Archivos > ",
        cmd = files_config.hidden,
        git_icons = true,
        file_icons = true,
        color_icons = true,
        -- Configuramos fzf para que use coincidencia exacta por defecto
        fzf_opts = {
          ['--exact'] = true,
        },
      },
      grep = {
        prompt = "Buscar > ",
        cmd = grep_config.hidden,
        git_icons = true,
        file_icons = true,
        color_icons = true,
        multiprocess = true,
        -- Configuramos fzf para que use coincidencia exacta por defecto
        fzf_opts = {
          ['--exact'] = true,
        },
        no_header = false,
      },
      buffers = {
        prompt = "Buffers > ",
        file_icons = true,
        color_icons = true,
        sort_lastused = true,
        -- Configuramos fzf para que use coincidencia exacta por defecto
        fzf_opts = {
          ['--exact'] = true,
        },
      },
    }
    fzf.setup(config)
    -- Función para alternar búsqueda en archivos ocultos
    local function toggle_hidden_search()
      _G.hidden_search = not _G.hidden_search
      local new_files_cmd = _G.hidden_search and files_config.hidden or files_config.normal
      local new_grep_cmd = _G.hidden_search and grep_config.hidden or grep_config.normal
      fzf.config.files.cmd = new_files_cmd
      fzf.config.grep.cmd = new_grep_cmd
      vim.notify("Búsqueda en archivos ocultos: " .. (_G.hidden_search and "activada" or "desactivada"))
    end

    vim.api.nvim_create_user_command('ToggleHiddenSearch', toggle_hidden_search, {})

    -- Nueva función para buscar la palabra bajo el cursor
    local function grep_cword()
      local word = vim.fn.expand("<cword>")
      require('fzf-lua').grep({ search = word })
    end
-- Nuevo mapeo de teclas para buscar la palabra bajo el cursor
    vim.keymap.set('n', '<leader>gg', grep_cword, {
      desc = "Buscar palabra bajo el cursor",
      silent = true
    })


  end,
}
