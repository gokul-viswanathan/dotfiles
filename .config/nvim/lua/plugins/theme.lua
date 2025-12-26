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

-- Centralized theme configuration
-- When changing themes, update the THEME_CONFIG below and check these files:
-- - lua/plugins/lualine.lua (theme name)
-- - lua/plugins/ui.lua (incline colors)
-- - lua/plugins/git.lua (gitsigns colors)
-- - lua/config/options.lua (any theme-specific highlights)

local THEME_CONFIG = {
  name = "github_dark_default",
  style = "dark_default",
  colors = {
    -- GitHub Dark Default theme colors
    bg = "#0d1117",          -- background
    bg_dark = "#161b22",     -- darker background
    bg_darker = "#0d1117",   -- even darker background
    fg = "#c9d1d9",          -- foreground
    fg_dark = "#8b949e",     -- muted foreground
    fg_darker = "#6e7681",   -- more muted foreground
    blue = "#58a6ff",        -- blue accent
    green = "#56d364",       -- green accent
    green_muted = "#7c9f7c", -- green accent (muted)
    red = "#f85149",         -- red accent
    yellow = "#d29922",      -- yellow accent
    purple = "#bc8cff",      -- purple accent
    orange = "#d29922",      -- orange accent
  }
}

-- Make theme config available globally for other plugins
_G.THEME_CONFIG = THEME_CONFIG

return {
  {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    config = function()
      require("github-theme").setup({
        options = {
          theme_style = THEME_CONFIG.style,
          transparent = true,
        },
      })
      vim.cmd.colorscheme(THEME_CONFIG.name)

      -- Optional tweaks for line numbers
      vim.cmd(string.format([[
            hi LineNr guibg=NONE ctermbg=NONE guifg=%s
            hi CursorLineNr guibg=NONE ctermbg=NONE guifg=%s
            ]], THEME_CONFIG.colors.fg_darker, THEME_CONFIG.colors.blue))
    end,
  },
}
