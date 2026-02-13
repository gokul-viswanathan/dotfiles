local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set("n", "<leader>", "<nop>")
keymap.set('i', 'jk', '<Esc>', { noremap = true })

keymap.set("n", "<leader>/", ":noh<cr>", { desc = "Remove highlight" })

-- Resize window
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")

-- Diagnostics
vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, { desc = "Prev diagnostic" })
vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, { desc = "Next diagnostic" })
vim.keymap.set("n", "<leader>xf", vim.diagnostic.open_float, { desc = "Line diagnostics" })

vim.keymap.set("n", "<leader>ud", function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Toggle diagnostics" })
