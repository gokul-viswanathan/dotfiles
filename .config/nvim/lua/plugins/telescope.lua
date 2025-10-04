return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    lazy = false,
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        "nvim-telescope/telescope-file-browser.nvim",
        'nvim-telescope/telescope-ui-select.nvim',
        "folke/todo-comments.nvim",
        "nvim-telescope/telescope-live-grep-args.nvim",
    },
    keys = {
        -- File operations
        { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
        { "<leader>fF", "<cmd>Telescope find_files hidden=true<cr>", desc = "Find all files" },
        { "<leader>fe", "<cmd>Telescope file_browser<cr>", desc = "File browser" },
        { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },

        -- Search operations
        { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
        { "<leader>fG", "<cmd>Telescope live_grep_args<cr>", desc = "Live grep with args" },
        { "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "Grep word under cursor" },
        { "<leader>fs", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search in buffer" },

        -- Buffer operations
        { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find buffers" },
        { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
        { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
        { "<leader>fc", "<cmd>Telescope commands<cr>", desc = "Commands" },

        -- LSP operations
        { "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
        { "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document symbols" },
        { "<leader>fS", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "Workspace symbols" },
        { "<leader>fr", "<cmd>Telescope lsp_references<cr>", desc = "References" },
        { "<leader>fi", "<cmd>Telescope lsp_implementations<cr>", desc = "Implementations" },
        { "<leader>ft", "<cmd>Telescope lsp_type_definitions<cr>", desc = "Type definitions" },

        -- Git operations
        { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Git commits" },
        { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Git branches" },
        { "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "Git status" },

        -- Todo operations
        { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Find todos" },
        { "<leader>fT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Find specific todos" },
    },
    config = function()
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        local telescope = require("telescope")
        telescope.setup({
            extensions = {
                file_browser = {
                    theme = "ivy",
                    hijack_netrw = true,
                },
            },
        })

        local extensions = { "file_browser", "ui-select", "fzf", "live_grep_args" }
        for _, ext in ipairs(extensions) do
            local success, err = pcall(function()
                telescope.load_extension(ext)
            end)
            if not success then
                vim.notify(string.format("Failed to load telescope extension '%s': %s", ext, err), vim.log.levels.WARN)
            end
        end

        require("todo-comments").setup({
            signs = true,
            sign_priority = 8,
            keywords = {
                FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
                TODO = { icon = " ", color = "info" },
                HACK = { icon = " ", color = "warning" },
                WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
                PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
                NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
                TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
            },
        })
    end,
}
