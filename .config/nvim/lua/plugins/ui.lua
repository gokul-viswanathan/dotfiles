return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            preset = "modern",
            delay = 500,
            icons = {
                mappings = false,
            },
            win = {
                border = "rounded",
            },
            layout = {
                height = { min = 4, max = 25 },
                width = { min = 20, max = 50 },
                spacing = 3,
                align = "left",
            },
        },
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        event = "VeryLazy",
        opts = {
            indent = {
                char = "│",
                tab_char = "│",
            },
            scope = {
                enabled = true,
                char = "│",
                show_start = true,
                show_end = false,
            },
            exclude = {
                filetypes = {
                    "help",
                    "alpha",
                    "dashboard",
                    "neo-tree",
                    "Trouble",
                    "trouble",
                    "lazy",
                    "mason",
                    "notify",
                    "toggleterm",
                    "lazyterm",
                },
            },
        },
    },
    {
        "b0o/incline.nvim",
        event = "VeryLazy",
        config = function()
            require("incline").setup({
        highlight = {
            groups = {
                -- Active window
                InclineNormal = {
                    guibg = _G.THEME_CONFIG.colors.bg_dark, -- theme background
                    guifg = _G.THEME_CONFIG.colors.fg, -- theme foreground
                },
                -- Inactive window
                InclineNormalNC = {
                    guibg = _G.THEME_CONFIG.colors.bg_darker, -- darker background
                    guifg = _G.THEME_CONFIG.colors.fg_dark, -- muted foreground
                },
            },
        },
                window = {
                    margin = { vertical = 0, horizontal = 1 },
                    padding = 1,
                    placement = { vertical = "top", horizontal = "right" },
                },
                render = function(props)
                    local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
                    if filename == "" then
                        filename = "[No Name]"
                    end

                    local icon, color = require("nvim-web-devicons").get_icon_color(filename)
                    return {
                        { icon and (icon .. " ") or "", guifg = color },
                        { filename },
                    }
                end,
            })
        end,
    },
}
