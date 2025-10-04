return {
    {
        'numToStr/Comment.nvim',
        event = "VeryLazy",
        config = function()
            require('Comment').setup()
        end
    },
    {
        'stevearc/conform.nvim',
        opts = {},
        config = function()
            local success, conform = pcall(require, "conform")
            if not success then
                vim.notify("Failed to load conform: " .. conform, vim.log.levels.ERROR)
                return
            end

            conform.setup({
                formatters_by_ft = {
                    lua = { "stylua" },
                    python = { "ruff_format", "ruff" },
                    javascript = { "prettierd", "prettier" },
                    typescript = { "prettierd", "prettier" },
                    javascriptreact = { "prettierd", "prettier" },
                    typescriptreact = { "prettierd", "prettier" },
                    json = { "prettierd", "prettier" },
                    jsonc = { "prettierd", "prettier" },
                    html = { "prettierd", "prettier" },
                    css = { "prettierd", "prettier" },
                    scss = { "prettierd", "prettier" },
                    yaml = { "prettierd", "prettier" },
                    markdown = { "prettierd", "prettier" },
                    java = { "google-java-format" },
                    go = { "gofmt", "goimports" },
                    rust = { "rustfmt" },
                    sh = { "shfmt" },
                    bash = { "shfmt" },
                    zsh = { "shfmt" },
                    sql = { "sql_formatter" },
                    xml = { "xmllint" },
                },
                format_on_save = {
                    timeout_ms = 3000,
                    lsp_format = "fallback", -- Use LSP formatting if no formatter found
                },
                formatters = {
                    shfmt = {
                        prepend_args = { "-i", "2", "-ci" }, -- 2 spaces indentation, case indent
                    },
                    prettierd = {
                        condition = function(ctx)
                            return vim.fs.basename(ctx.filename) ~= "package.json"
                        end,
                    },
                },
            })
        end
    },
    {
        "folke/trouble.nvim",
        event = "VeryLazy",
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
