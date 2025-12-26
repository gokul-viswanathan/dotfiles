local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set("n", "<leader>", "<nop>")
keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
keymap.set('i', 'jk', '<Esc>', { noremap = true })

keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename variable" })
keymap.set("n", "<leader>/", ":noh<cr>", { desc = "Remove highlight" })

-- vim.keymap.set('n', 'gd', '<cmd>vsplit | lua vim.lsp.buf.definition()<CR>')
-- vim.keymap.set('n', 'gD', '<cmd>split | lua vim.lsp.buf.definition()<CR>')
local function lsp_def_in(cmd)
  return function()
    vim.cmd(cmd)
    vim.lsp.buf.definition()
  end
end

vim.keymap.set("n", "gd", lsp_def_in("vsplit"), { desc = "Definition vsplit" })
vim.keymap.set("n", "gD", lsp_def_in("split"), { desc = "Definition split" })
vim.keymap.set("n", "gt", lsp_def_in("tabnew"), { desc = "Definition tab" })

vim.keymap.set('n', 'gr', vim.lsp.buf.references)
vim.keymap.set("n", "<leader>k", vim.lsp.buf.hover, { noremap = true, silent = true })
-- vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover docs" })
-- Resize window
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")


vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
vim.keymap.set("n", "<leader>xf", vim.diagnostic.open_float, { desc = "Line diagnostics" })

vim.keymap.set("n", "<leader>lf", function() vim.lsp.buf.format({ async = true }) end, { desc = "Format buffer" })
