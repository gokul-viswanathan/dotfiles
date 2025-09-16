return {
    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    },
    {
        'stevearc/conform.nvim',
        opts = {},
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    lua = { "stylua" },
                    python = { "ruff" }, -- Ruff first
                    java = { "google-java-format" }
                },
                format_on_save = {
                    timeout_ms = 3000,
                    lsp_format = "fallback", -- Use LSP formatting if no formatter found
                },
            })
        end
    },
    {
        "folke/trouble.nvim",
        opts = { use_diagnostic_signs = true },
        keys = {
            {
                "<leader>xx",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Project Diagnostics (Trouble)",
            },
            {
                "<leader>xX",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Buffer Diagnostics (Trouble)",
            },
        },
    },
    {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "VeryLazy",
        priority = 1000,
        config = function()
            require('tiny-inline-diagnostic').setup({
                preset = "classic",
                options = {
                    -- Customize the appearance
                    show_source = true,
                    throttle = 20,
                    softwrap = 15,
                    multilines = {
                        enabled = true,
                        always_show = false,
                    },
                    overflow = {
                        mode = "wrap"
                    }
                }
            })
            vim.diagnostic.config({ virtual_text = false }) -- Disable default virtual text
        end
    }
}
