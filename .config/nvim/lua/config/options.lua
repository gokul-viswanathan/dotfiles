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

-- Diagnostic display (colors inherit from theme highlight groups)
-- Note: tiny-inline-diagnostic plugin may override virtual_text
vim.diagnostic.config({
  virtual_text = true,
  underline = true,
  signs = true,
  severity_sort = true,
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
