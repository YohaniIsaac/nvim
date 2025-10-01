-- ============================================
-- CUSTOM ICONS FOR ZEPHYR DEVELOPMENT
-- ============================================
return {
    {
        "nvim-tree/nvim-web-devicons",
        config = function()
            require('nvim-web-devicons').setup({
                -- ============================================
                -- ZEPHYR-SPECIFIC FILE ICONS
                -- ============================================
                override = {
                    -- CMakeLists.txt
                    ["CMakeLists.txt"] = {
                        icon = "CM",
                        color = "#4756f0",
                        cterm_color = "66",
                        name = "CMakeLists"
                    },
                    -- Zephyr project configuration
                    ["prj.conf"] = {
                        icon = "",
                        color = "#a074c4",
                        cterm_color = "140",
                        name = "PrjConf"
                    },
                    -- Zephyr project configuration
                    ["dts"] = {
                        icon = "dts",
                        color = "#FFD700",
                        cterm_color = "184",
                        name = "DTS"
                    },
                    -- Device Tree Source Include
                    ["dtsi"] = {
                        icon = "dtsi",
                        color = "#cd2551",
                        cterm_color = "184",
                        name = "DTSI"
                    },
                    -- YAML files
                    ["yaml"] = {
                        icon = "",
                        color = "#8af047",
                        cterm_color = "66",
                        name = "YAML"
                    }
                },

                -- ============================================
                -- DEFAULT ICON BEHAVIOR
                -- ============================================
                default = true,
            })
        end
    }
}
