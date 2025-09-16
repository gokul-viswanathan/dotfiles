return {
    {
        "b0o/incline.nvim",
        event = "VeryLazy",
        config = function()
            require("incline").setup({
                highlight = {
                    groups = {
                        -- Active window
                        InclineNormal = {
                            guibg = "#3b4261", -- deep blue/gray from Tokyonight Night
                            guifg = "#c0caf5", -- light foreground
                        },
                        -- Inactive window
                        InclineNormalNC = {
                            guibg = "#1f2335", -- darker background
                            guifg = "#565f89", -- muted foreground
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
