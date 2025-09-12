-- lua/plugins/python-docstring.lua (VERSIÓN SIMPLIFICADA)
return {
    -- Plugin para folding avanzado
    {
        "kevinhwang91/nvim-ufo",
        dependencies = {
            "kevinhwang91/promise-async",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            -- Configuración básica para folding
            vim.o.foldcolumn = '0'
            vim.o.foldlevel = 99
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true

            -- Configuración de nvim-ufo
            require('ufo').setup({
                provider_selector = function(bufnr, filetype, buftype)
                    if filetype == 'python' then
                        return {'treesitter', 'indent'}
                    else
                        return {'treesitter', 'indent'}
                    end
                end,
                -- Configuración para Python docstrings
                fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
                    local newVirtText = {}
                    local suffix = ('  %d líneas'):format(endLnum - lnum)
                    local sufWidth = vim.fn.strdisplaywidth(suffix)
                    local targetWidth = width - sufWidth
                    local curWidth = 0

                    for _, chunk in ipairs(virtText) do
                        local chunkText = chunk[1]
                        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                        if targetWidth > curWidth + chunkWidth then
                            table.insert(newVirtText, chunk)
                        else
                            chunkText = truncate(chunkText, targetWidth - curWidth)
                            local hlGroup = chunk[2]
                            table.insert(newVirtText, {chunkText, hlGroup})
                            chunkWidth = vim.fn.strdisplaywidth(chunkText)
                            if curWidth + chunkWidth < targetWidth then
                                suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
                            end
                            break
                        end
                        curWidth = curWidth + chunkWidth
                    end

                    -- Cambiar el color del texto plegado para docstrings
                    table.insert(newVirtText, {suffix, 'MoreMsg'})
                    return newVirtText
                end
            })

            -- Keymaps para folding avanzado (opcionales, complementan los básicos)
            vim.keymap.set('n', 'zR', require('ufo').openAllFolds, { desc = 'Abrir todos los pliegues' })
            vim.keymap.set('n', 'zM', require('ufo').closeAllFolds, { desc = 'Cerrar todos los pliegues' })
        end,
    }
}
