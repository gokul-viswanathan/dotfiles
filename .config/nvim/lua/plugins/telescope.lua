return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- find files in cwd
      { "<leader>ff", function() require("telescope.builtin").find_files({ cwd = vim.fn.getcwd() }) end, desc = "Find files (cwd)" },

      -- grep in cwd
      { "<leader>fg", function() require("telescope.builtin").live_grep({ cwd = vim.fn.getcwd() }) end,  desc = "Grep (cwd)" },

      -- search inside current buffer
      { "<leader>/",  function() require("telescope.builtin").current_buffer_fuzzy_find() end,           desc = "Search buffer" },
    },
  }
}
