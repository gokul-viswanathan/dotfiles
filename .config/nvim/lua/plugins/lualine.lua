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
                    theme = "github_dark",
                    globalstatus = true,
                    section_separators = { left = "", right = "" },
                    component_separators = { left = "", right = "" },
                    disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
                },
                sections = {
                    -- left
                    lualine_a = {
                        { "mode", separator = { left = "" }, right_padding = 2 },
                    },
                    lualine_b = {
                        { "branch", icon = "" },
                        { "swenv", icon = "", },
                        {
                            "diff",
                            colored = true,
                            symbols = { added = "+", modified = "~", removed = "-" },
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
                        { "diagnostics", sources = { "nvim_lsp" } },
                        {
                            "filename",
                            path = 1, -- relative path
                            symbols = { modified = " ", readonly = " ", unnamed = "" },
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
                        },
                        -- encoding/fileformat
                        { "encoding" },
                        { "fileformat" },
                    },
                    lualine_y = {
                        { "progress" },
                    },
                    lualine_z = {
                        { "location", separator = { right = "" }, left_padding = 2 },
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
