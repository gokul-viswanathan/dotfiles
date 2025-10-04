-- return {
--     {
--         "folke/tokyonight.nvim",
--         opts = {
--             style = "night", -- "storm", "night", "moon", "day"
--         },
--         config = function(_, opts)
--             require("tokyonight").setup(opts)
--             vim.cmd.colorscheme("tokyonight")
--             vim.cmd [[
--             hi LineNr guibg=NONE ctermbg=NONE guifg=#565f89
--             hi CursorLineNr guibg=NONE ctermbg=NONE guifg=#7aa2f7
--             ]]
--         end,
--     },
-- }
--

return {
    {
        "projekt0n/github-nvim-theme",
        name = "github-theme",
        config = function()
            require("github-theme").setup({
                options = {
                    -- Variants: "dark", "dimmed", "dark_default", "light"
                    -- "dark_default" = GitHub Dark (default)
                    theme_style = "dark_default",
                    transparent = false, -- set true if you want your terminal background
                },
            })
            vim.cmd.colorscheme("github_dark_default")

            -- Optional tweaks for line numbers
            vim.cmd [[
            hi LineNr guibg=NONE ctermbg=NONE guifg=#6e7681
            hi CursorLineNr guibg=NONE ctermbg=NONE guifg=#58a6ff
            ]]
        end,
    },
}
