vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.clipboard = "unnamedplus"
vim.cmd("set relativenumber")
vim.cmd("set number")
vim.opt.tabstop = 4    -- Number of visual spaces per TAB
vim.opt.shiftwidth = 4 -- Spaces per indent
vim.opt.expandtab = true

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldcolumn = "0"
vim.opt.foldtext = ""
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldnestmax = 4

-- vim.opt.cursorline = true
--

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = false
vim.opt.scrolloff = 8

-- Diagnostic display inline
vim.diagnostic.config({
    virtual_text = true,
    underline = true
})

-- Borders for LSP hover & signature help
local border = {
    { "╭", "FloatBorder" },
    { "─", "FloatBorder" },
    { "╮", "FloatBorder" },
    { "│", "FloatBorder" },
    { "╯", "FloatBorder" },
    { "─", "FloatBorder" },
    { "╰", "FloatBorder" },
    { "│", "FloatBorder" },
}

-- Override handlers
-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
--     vim.lsp.handlers.hover,
--     { border = border }
-- )
--
-- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
--     vim.lsp.handlers.signature_help,
--     { border = border }
-- )

-- Improve highlight groups for better readability
-- vim.cmd [[
--   highlight FloatBorder guifg=#7aa2f7 guibg=#1a1b26
--   highlight NormalFloat guibg=#1a1b26
-- ]]
--
-- vim.api.nvim_create_autocmd("ColorScheme", {
--     pattern = "*",
--     callback = function()
--         -- Use TokyoNight specific colors
--         -- vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#565f89", bg = "NONE" }) -- TokyoNight comment color
--         -- Alternative colors you can try:
--         vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#414868", bg = "NONE" }) -- Darker blue-gray
--         -- vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#7aa2f7", bg = "NONE" }) -- TokyoNight blue
--         -- vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#bb9af7", bg = "NONE" }) -- TokyoNight purple
--     end,
-- })

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
