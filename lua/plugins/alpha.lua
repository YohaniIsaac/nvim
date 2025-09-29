return {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function()
        local dashboard = require("alpha.themes.dashboard")
        require("alpha.term")
        local arttoggle = false

        -- Logo size
        local logo_width = 60   -- Adjust the width of the logo
        local logo_height = 0   -- Adjust the height of the logo

local logo = {
"MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMW0d:,.......',:ldk0NWMMMMMMMMMMMMMMMMMMMMMMMMMMMMWXx:............':dOXWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM",
"MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNOdoddolcc:;,'.....,cokKWMMMMMMMMMMMMMMMMMMMMMMMMMMMNk:..............;oONWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM",
"MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWX0kxxxxxddxkkOkxolc:'...':okXWMMMMMMMMMMMMMMMMMMMMMMMMWXd,...............;o0NMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM",
"MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWOc,...''.....',;cldkOOkdol;...'cd0NWMMMMMMMMMMMMMMMMMMMMWMW0:.................:kXWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM",
"MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMK:..colc;'...........;:ldkkxxdc,...;oOXMMMMMMMMMMMMMMMMMMMMMWKl..................;dKWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM",
"MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWWW0:;OWWWWk'.................'cxxoodkkdooc,:d0WMMMMMMMWWWMMMMMMMMK:....................,dXWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM",
"MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWk:c0WMMWO;....................'o00xlldONKo'.'ckXWNK0dllox0NMMMMMWk'.....................;kNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM",
"MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNx;oXMMMXo'.......................;OWN0dlcdkxo,..lxc,.......cOWMMMMXl......................'lKWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM",
"MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWx,oXMMMKc..........................,kWMMN0dc:c;'cd,..........,kWMMMWk'.......................;kWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM",
"MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNo,kMMMNo..............................:KMMMMWk'..dd............oNMMMMX:..........................lKWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM",
"MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM0;cXMMMO,...............................xWMMMMO'..;dc..........;0WMMMMXc...........................:0MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM",
"MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMk,oWMMNo................................lXMMMMK:...,lc;,......;OWMMMMMX:............................:0WMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM",
"MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMx,dWMMK:................................;kXMMMWx'....';,,....:0WMMMMMM0;.............................cKMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM",
"MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMO,dWMM0,................................,dKMMMMNk;.... ....;xXMMMMMMMMO,..............................lXMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM",
"MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMK:cXMM0;................................,dXMMMMMWXklc:::ldONWMMMMMMMMXl................................oNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM",
"MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMK::KWW0:..............................'l0WMMMMMMMMMMMMMMMMMMMMMMMW0doc'................................cXMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM",
"MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWO:cKMX:............................;lkNMMMMMMMMMMMMMMMMMWX0OkkO0Oxc'...'l;............................:KMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM",
"MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWx,oW0;...........................,coKMMMMMMMMMMMMWWMWNX00OOkdc,.....'ckx,............................'kWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM",
"MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM0;lXx'..........................;llOWMMMMMMMMMMWX0kxl;''''.......':dOOo'..............................oNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM",
"MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM0;l0l.........................;oockWMMMMMMMNXOdc,.............,lx00kl,................................:KMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM",
"MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMXc:x:.....................':okxccOWMMMWX0ko:,.':oddl,.....,cxOXWX0kxxx:...............................,0MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM",
"MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWk;::................,;ldk00xc;oKWWXOxl;'';ldOXWWMMW0c;:lkXWMMMMWWWMMWd...............................'OMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM",
"MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNOlcc:::ccclooodxkO00OOxo:;:lkOxl:,',cok0NWMWWNXNWWWXK0KNWMMMMMMMMMMM0c..............................'kMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM",
"MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWWNXXK000KKKXXK0Okxolc;;;;;::c:,',:ok0XWNXKOOOOOkOXWWMWWMMWWMMMMMMMWWNKOo'.............................'kMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM",
"MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWXOxddddxxxxxxdol:;'',;clodxxdddddoollc:;:lx0XNXXNWMMWO,..,;,,;:ldxO00Od:............................,OMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM",
"MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWKOxxdolc;,.......';:cllooooolc:,..';okO0koc;,;:cooc,..;ldk0KK0Okxddddo:...........................:KMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM",
"MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNo'......'',;:cloooooool:;'....,cokKNXOo:;,'......':ok0K0kdc;,.....................................lNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM",
"MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWKkkkkkkkkkkxddol:,'......,:ox0XWMMWKkoc:;,..':ldOKX0xl;......',;:cllllc:;,'.......................xWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM",
"MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNK0ko::;,,.........',:ldk0XWWMMMWNXOoc;..':oOXNWN0d:......;cloxkKNWMMMMWWNXKOxo:'.................;KMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM",
"MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWXOdc;,'..',;:ccloxkkxoc;'...':ok0XWWMWKd;.......:oodx0XWMMMMMMMMMMMMMMMMMMMMMWXk:...........:KMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM",
"MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWN0kxxxddolllllcc;,.....';cdOXX0dl:cokOc.......:oodkXWNNWMMMMMMMMMMMMMMMMMMMMMMMWXd'........'xWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM",
"MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNOoldOxc'............';codOKNWMMNx'.....'c;.....'looONMWXXWMMMMMMMMMMMMMMMMMMMMMMMMMMNd........oNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM",
"MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWx'...oNN0xlcccclodxk0KNWMMMMMMMWO,.............;ookNWMNKXWMMMMMMMMMMMMMNKKXXXNNWWWWWMMK:......:KMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM",
"MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWO,...;OWWXNWWWKXWMMMMMMMMMMMMMMMXc............;oxkKWMWXOXWMMWMWXXMMMMMMWk,'',;;::ccclo0Wx.....;0WMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM",
"MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWx....cKMXoxWW0kXMMMMMMMMMMMMMMMMWd............dWMMMMMXoxWMMMWOldXMMMMMMMMO'..',;;;;;;:cxN0;..;OWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM",
"MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMk'..'kWMO,lNMWWMMMMWx,..'lKNxcdXMK:..........,OMMMMWO,'OMMK:.;0W0o0MMMMMMMXc...,;;:::ccco0WNWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM",
"MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMk'..cXMWd'oWMWMMMMWNklcclxOd'..dW0;..........:KMMMMXc.;KMKc.'xWKcoNMMMMMMMNl...;:ccccccco0WMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM",
"MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM0;.'xWMNo'dWMMMMMW0c...........lN0;,,.....':':XMMMWk'.lXXo..oNKc,kMMMMMMMMWo...;::cc::ccl0WMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM",
"MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMN0ol0NNWd'dWMMMMM0;............:K0:do.....:x::XMMMXc..l0x'.:KNo.cKMMMMMMMMWx...',;:::::cl0WMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
}

        -- Configuration for alternative art
        local art = {
            -- { name, width, height }
            { "tohru", 20, 15 },
        }

        if arttoggle == true then
            dashboard.opts.opts.noautocmd = true
            dashboard.section.terminal.opts.redraw = true
            local path = vim.fn.stdpath("config") .. "/assets/"
            local currentart = art[1]
            dashboard.section.terminal.command = "cat " .. path .. currentart[1]
            dashboard.section.terminal.width = logo_width
            dashboard.section.terminal.height = logo_height

            dashboard.opts.layout = {
                dashboard.section.terminal,
                { type = "padding", val = 2 },
                dashboard.section.buttons,
                dashboard.section.footer,
            }
        else
            dashboard.section.header.val = logo
        end

        dashboard.section.buttons.val = {
            dashboard.button("󰇘", "  Oxycontroller", ":Neotree /home/yt/git/oxycontroller <CR>"),
            dashboard.button("󰇘", "  Zephyr innovex", ":Neotree /home/yt/git/zephyr_innovex <CR>"),
            dashboard.button("󰇘", "  Git Proyects", ":Neotree /home/yt/git <CR>"),
            dashboard.button("󰇘", "  Neovim config", ":Neotree /home/yt/.config/nvim <CR>"),
        }

        for _, button in ipairs(dashboard.section.buttons.val) do
            button.opts.hl = "AlphaButtons"
            button.opts.hl_shortcut = "AlphaShortcut"
        end

        dashboard.section.header.opts.hl = "Function"
        dashboard.section.buttons.opts.hl = "Identifier"
        dashboard.section.footer.opts.hl = "Function"

        -- SET UP THE LAYOUT
        dashboard.opts.layout = {
            { type = "padding", val = 2 },  -- Space above the logo
            dashboard.section.header,
            { type = "padding", val = 1 },  -- Space between logo and buttons
            dashboard.section.buttons,
            { type = "padding", val = 0 },  -- Space between buttons and footer
            dashboard.section.footer,
        }
        return dashboard
    end,
    config = function(_, dashboard)
        if vim.o.filetype == "lazy" then
            vim.cmd.close()
            vim.api.nvim_create_autocmd("User", {
                pattern = "AlphaReady",
                callback = function()
                    require("lazy").show()
                end,
            })
        end

        require("alpha").setup(dashboard.opts)
        vim.api.nvim_create_autocmd("User", {
            pattern = "LazyVimStarted",
            callback = function()
                local v = vim.version()
                local dev = ""
                if v.prerelease == "dev" then
                    dev = "-dev+" .. v.build
                else
                    dev = ""
                end
                local version = v.major .. "." .. v.minor .. "." .. v.patch .. dev
                local stats = require("lazy").stats()
                local plugins_count = stats.loaded .. "/" .. stats.count
                local ms = math.floor(stats.startuptime + 0.5)
                local time = vim.fn.strftime("%H:%M:%S")
                local date = vim.fn.strftime("%d.%m.%Y")

                local line1 = "󰐫 " .. plugins_count .. " plugins loaded in " .. ms .. "ms"
                local line2 = "󰃭 " .. date .. "  󱑎 " .. time
                local line3 = " " .. version

                local line1_width = vim.fn.strdisplaywidth(line1)
                local line2Padded = string.rep(" ", (line1_width - vim.fn.strdisplaywidth(line2)) / 2) .. line2
                local line3Padded = string.rep(" ", (line1_width - vim.fn.strdisplaywidth(line3)) / 2) .. line3

                dashboard.section.footer.val = {
                    line1,
                    line2Padded,
                    line3Padded,
                }
                pcall(vim.cmd.AlphaRedraw)
            end,
        })
    end,
}
