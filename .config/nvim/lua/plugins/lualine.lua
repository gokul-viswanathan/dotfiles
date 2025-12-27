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
    config = function()
      local colors = _G.THEME_CONFIG.colors

      -- Mode colors using theme palette
      local mode_colors = {
        normal = colors.green,
        insert = colors.blue,
        visual = colors.orange,
        replace = colors.red,
        command = colors.yellow,
      }

      require("lualine").setup({
        options = {
          theme = {
            normal = {
              a = { fg = colors.bg, bg = mode_colors.normal, gui = "bold" },
              b = { fg = colors.fg_dark, bg = colors.bg_dark },
              c = { fg = colors.fg_dark, bg = colors.bg },
            },
            insert = {
              a = { fg = colors.bg, bg = mode_colors.insert, gui = "bold" },
              b = { fg = colors.fg_dark, bg = colors.bg_dark },
              c = { fg = colors.fg_dark, bg = colors.bg },
            },
            visual = {
              a = { fg = colors.bg, bg = mode_colors.visual, gui = "bold" },
              b = { fg = colors.fg_dark, bg = colors.bg_dark },
              c = { fg = colors.fg_dark, bg = colors.bg },
            },
            replace = {
              a = { fg = colors.bg, bg = mode_colors.replace, gui = "bold" },
              b = { fg = colors.fg_dark, bg = colors.bg_dark },
              c = { fg = colors.fg_dark, bg = colors.bg },
            },
            command = {
              a = { fg = colors.bg, bg = mode_colors.command, gui = "bold" },
              b = { fg = colors.fg_dark, bg = colors.bg_dark },
              c = { fg = colors.fg_dark, bg = colors.bg },
            },
            inactive = {
              a = { fg = colors.fg_darker, bg = colors.bg_dark },
              b = { fg = colors.fg_darker, bg = colors.bg_dark },
              c = { fg = colors.fg_darker, bg = colors.bg_dark },
            },
          },
          globalstatus = true,
          section_separators = { left = "", right = "" },
          component_separators = { left = "", right = "" },
          disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
        },
        sections = {
          lualine_a = {
            {
              "mode",
              padding = { left = 1, right = 1 },
              fmt = function(str) return str:sub(1, 1) end,
            },
          },
          lualine_b = {
            { "branch", icon = "", color = { fg = colors.blue } },
            {
              function()
                local venv = require("swenv.api").get_current_venv()
                return venv and venv.name or ""
              end,
              icon = "",
              color = { fg = colors.green },
              cond = function()
                local ok, swenv = pcall(require, "swenv.api")
                return ok and swenv.get_current_venv() ~= nil
              end,
            },
            {
              "diff",
              colored = true,
              symbols = { added = " ", modified = " ", removed = " " },
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
              symbols = { error = " ", warn = " ", info = " ", hint = " " },
              colored = true,
              update_in_insert = false,
              always_visible = false,
            },
            {
              "filename",
              path = 1,
              symbols = {
                modified = " ●",
                readonly = " ",
                unnamed = " ",
                newfile = " ",
              },
              color = { fg = colors.fg },
            },
          },
          lualine_x = {
            {
              function()
                local clients = vim.lsp.get_clients({ bufnr = 0 })
                if #clients == 0 then return "" end
                local names = {}
                for _, client in ipairs(clients) do
                  table.insert(names, client.name)
                end
                return " " .. table.concat(names, ", ")
              end,
              color = { fg = colors.purple },
            },
            {
              "filetype",
              colored = true,
              icon_only = false,
            },
            {
              "encoding",
              color = { fg = colors.fg_dark },
              cond = function() return vim.bo.fileencoding ~= "utf-8" end,
            },
            {
              "fileformat",
              color = { fg = colors.fg_dark },
              symbols = { unix = "LF", dos = "CRLF", mac = "CR" },
            },
          },
          lualine_y = {
            { "progress", color = { fg = colors.fg } },
          },
          lualine_z = {
            { "location", padding = { left = 1, right = 1 }, color = { fg = colors.bg } },
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
      })
    end,
  },
}
