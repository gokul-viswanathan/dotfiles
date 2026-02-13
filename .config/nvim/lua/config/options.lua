vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.clipboard = "unnamedplus"
vim.cmd("set relativenumber")
vim.cmd("set number")
vim.opt.tabstop = 2     -- Number of visual spaces per TAB
vim.opt.shiftwidth = 2  -- Spaces per indent
vim.opt.softtabstop = 2 -- Spaces per backspace
vim.opt.expandtab = true

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldcolumn = "0"
vim.opt.foldtext = ""
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldnestmax = 4

-- Enable auto indentation
vim.opt.autoindent = true
vim.opt.smartindent = true
-- vim.opt.indentexpr = "v:lua.vim.treesitter.indentexpr()"

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = false
vim.opt.scrolloff = 10

-- Diagnostic display
vim.opt.signcolumn = "yes"
vim.diagnostic.config({
  virtual_text = false,
  virtual_lines = { current_line = true },
  underline = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "✘",
      [vim.diagnostic.severity.WARN] = "▲",
      [vim.diagnostic.severity.INFO] = "ℹ",
      [vim.diagnostic.severity.HINT] = "⚑",
    },
  },
  severity_sort = true,
  update_in_insert = false,
  float = {
    source = "if_many",
    border = "rounded",
  },
})

vim.o.winborder = 'rounded'

-- Set the separator characters
vim.opt.fillchars:append({
  vert = "│",
  horiz = "─",
  horizup = "┴",
  horizdown = "┬",
  vertleft = "┤",
  vertright = "├",
  verthoriz = "┼"
})
