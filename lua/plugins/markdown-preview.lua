-- ============================================
-- RENDER-MARKDOWN - IN-EDITOR MARKDOWN RENDERING
-- ============================================
-- Renderiza markdown directamente en el buffer de nvim.
-- No requiere Node.js ni browser. Usa extmarks de nvim nativos.
-- Muestra headings con íconos/colores, tablas formateadas,
-- bloques de código resaltados, listas con íconos, checkboxes, etc.
return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown" },
        opts = {
            -- Headings con fondo de color y padding
            heading = {
                sign = false,
                icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
            },
            -- Bloques de código con fondo y ícono de lenguaje
            code = {
                sign = false,
                width = "block",
                right_pad = 1,
            },
            -- Checkboxes con íconos
            checkbox = {
                unchecked = { icon = "󰄱 " },
                checked   = { icon = "󰱒 " },
            },
            -- En modo insert se muestra el markdown crudo para editar
            render_modes = { "n", "c" },
        },
    },
}
