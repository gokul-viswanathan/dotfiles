local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set("n", "<leader>", "<nop>")
keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
keymap.set('i', 'jk', '<Esc>', { noremap = true })

keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename variable" })
keymap.set("n", "<leader>/", ":noh<cr>", { desc = "Remove highlight" })

vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover docs" })
-- Resize window
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")


vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
vim.keymap.set("n", "<leader>xf", vim.diagnostic.open_float, { desc = "Line diagnostics" })
