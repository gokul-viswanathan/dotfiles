return {
    {
        "AckslD/swenv.nvim",
    },
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "projekt0n/github-nvim-theme",
        },
        opts = function()
            local opts = {
                options = {
                    theme = {
                        normal = {
                            a = { fg = _G.THEME_CONFIG.colors.fg, bg = "#5f875f", gui = "bold" },
                            b = { fg = _G.THEME_CONFIG.colors.fg_dark, bg = "#444444" },
                            c = { fg = _G.THEME_CONFIG.colors.fg_dark, bg = "#222222" },
                        },
                        insert = {
                            a = { fg = _G.THEME_CONFIG.colors.fg, bg = "#5f87af", gui = "bold" },
                            b = { fg = _G.THEME_CONFIG.colors.fg_dark, bg = "#444444" },
                            c = { fg = _G.THEME_CONFIG.colors.fg_dark, bg = "#222222" },
                        },
                        visual = {
                            a = { fg = _G.THEME_CONFIG.colors.fg, bg = "#af875f", gui = "bold" },
                            b = { fg = _G.THEME_CONFIG.colors.fg_dark, bg = "#444444" },
                            c = { fg = _G.THEME_CONFIG.colors.fg_dark, bg = "#222222" },
                        },
                        replace = {
                            a = { fg = _G.THEME_CONFIG.colors.fg, bg = "#af5f5f", gui = "bold" },
                            b = { fg = _G.THEME_CONFIG.colors.fg_dark, bg = "#444444" },
                            c = { fg = _G.THEME_CONFIG.colors.fg_dark, bg = "#222222" },
                        },
                        command = {
                            a = { fg = _G.THEME_CONFIG.colors.fg, bg = "#87875f", gui = "bold" },
                            b = { fg = _G.THEME_CONFIG.colors.fg_dark, bg = "#444444" },
                            c = { fg = _G.THEME_CONFIG.colors.fg_dark, bg = "#222222" },
                        },
                        inactive = {
                            a = { fg = _G.THEME_CONFIG.colors.fg_darker, bg = "#333333" },
                            b = { fg = _G.THEME_CONFIG.colors.fg_darker, bg = "#333333" },
                            c = { fg = _G.THEME_CONFIG.colors.fg_darker, bg = "#333333" },
                        },
                    },
                    globalstatus = true,
                    section_separators = { left = "", right = "" },
                    component_separators = { left = "", right = "" },
                    disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
                    refresh = {
                        statusline = 1000,
                        tabline = 1000,
                        winbar = 1000,
                    },
                },
                sections = {
                    -- left
                    lualine_a = {
                        {
                            "mode",
                            right_padding = 2,
                            fmt = function(str) return str:sub(1, 1) end -- Show only first letter
                        },
                    },
                    lualine_b = {
                        { "branch", icon = "", color = { fg = "#87afaf" } },
                        {
                            "swenv",
                            icon = "",
                            color = { fg = _G.THEME_CONFIG.colors.green },
                            cond = function() return vim.g.swenv ~= nil end
                        },
                        {
                            "diff",
                            colored = true,
                            symbols = { added = " ", modified = " ", removed = " " },
                            source = function()
                                local gitsigns = vim.b.gitsigns_status_dict
                                if gitsigns then
                                    return {
                                        added = gitsigns.added,
                                        modified = gitsigns.changed,
                                        removed = gitsigns.removed,
                                    }
                                end
                            end,
                        },
                    },
                    lualine_c = {
                        {
                            "diagnostics",
                            sources = { "nvim_lsp" },
                            symbols = { error = " ", warn = " ", info = " ", hint = " " },
                            colored = true,
                            update_in_insert = false,
                            always_visible = false,
                        },
                        {
                            "filename",
                            path = 1, -- relative path
                            symbols = {
                                modified = " ●",
                                readonly = " ",
                                unnamed = " ",
                                newfile = " "
                            },
                            color = { fg = _G.THEME_CONFIG.colors.fg },
                        },
                    },

                    -- right
                    lualine_x = {
                        -- Show LSP client(s)
                        {
                            function()
                                local clients = vim.lsp.get_clients({ bufnr = 0 })
                                if #clients == 0 then
                                    return "No LSP"
                                end
                                local names = {}
                                for _, client in ipairs(clients) do
                                    table.insert(names, client.name)
                                end
                                return " " .. table.concat(names, ",")
                            end,
                            color = { fg = _G.THEME_CONFIG.colors.purple },
                            cond = function() return #vim.lsp.get_clients({ bufnr = 0 }) > 0 end
                        },
                        -- File type with icon
                        {
                            "filetype",
                            colored = true,
                            icon_only = false,
                            icon = { align = 'right' },
                        },
                        -- encoding/fileformat
                        {
                            "encoding",
                            color = { fg = _G.THEME_CONFIG.colors.fg_dark },
                            cond = function() return vim.bo.fileencoding ~= 'utf-8' end
                        },
                        {
                            "fileformat",
                            color = { fg = _G.THEME_CONFIG.colors.fg_dark },
                            symbols = {
                                unix = 'LF',
                                dos = 'CRLF',
                                mac = 'CR',
                            },
                        },
                    },
                     lualine_y = {
                         {
                             "progress",
                             color = { fg = _G.THEME_CONFIG.colors.fg },
                         },
                     },
                     lualine_z = {
                         {
                             "location",
                             left_padding = 2,
                             color = { fg = _G.THEME_CONFIG.colors.fg },
                         },
                     },
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { "filename" },
                    lualine_x = { "location" },
                    lualine_y = {},
                    lualine_z = {},
                },
            }

            require("lualine").setup(opts) -- ✅ no extra braces, just pass opts
        end,
    },
}
