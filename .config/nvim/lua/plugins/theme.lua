return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            style = "night", -- or "strom", "night", "moon", "day"
            -- transparent = true,
            -- styles = {
            --     sidebars = "transparent",
            --     floats = "transparent",
            -- },
        },
        config = function(_, opts)
            require("tokyonight").setup(opts)
            vim.cmd.colorscheme("tokyonight")
            vim.cmd [[
                hi LineNr guibg=NONE ctermbg=NONE guifg=#565f89
                hi CursorLineNr guibg=NONE ctermbg=NONE guifg=#7aa2f7
            ]]
        end,
    }
}
