return {
    {
        "mason-org/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },
    {
        "mason-org/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "ts_ls", "basedpyright", },
                automatic_installation = true, -- Changed from automatic_enable
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                lua_ls = {},
                ts_ls = {},
                basedpyright = {
                    settings = {
                        basedpyright = {
                            analysis = {
                                typeCheckingMode = "standard",
                            },
                        },
                        python = {
                            pythonPath = "python", -- Add default python path
                        },
                    },
                    on_new_config = function(config, root_dir)
                        local venv_path = root_dir .. "/venv/bin/python"
                        if vim.fn.executable(venv_path) == 1 then
                            config.settings.python.pythonPath = venv_path
                        end
                    end,
                },
                jdtls = {},
                gopls = {},
                ruff = {},
            }
        },
        config = function(_, opts)
            local lspconfig = require('lspconfig')

            -- Get capabilities from your completion plugin
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            if pcall(require, 'blink.cmp') then
                capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)
            end

            -- Setup each server
            for server, config in pairs(opts.servers) do
                -- Merge capabilities
                config.capabilities = vim.tbl_deep_extend('force', capabilities, config.capabilities or {})

                -- Use the traditional lspconfig setup
                -- lspconfig[server].setup(config)
                vim.lsp.config(server, config)
            end
        end
    },
}



-- return {
--     {
--         "mason-org/mason.nvim",
--         config = function()
--             require("mason").setup()
--         end
--     },
--     {
--         "mason-org/mason-lspconfig.nvim",
--         config = function()
--             require("mason-lspconfig").setup({
--                 ensure_installed = { "lua_ls", "ts_ls", "basedpyright", },
--                 automatic_enable = false,
--             })
--         end
--     },
--     {
--         "neovim/nvim-lspconfig",
--         opts = {
--             servers = {
--                 lua_ls = {},
--                 ts_ls = {},
--                 basedpyright = {
--                     settings = {
--                         basedpyright = {
--                             analysis = {
--                                 typeCheckingMode = "standard",
--                             },
--                         },
--                     },
--                     on_new_config = function(config, root_dir)
--                         local venv_path = root_dir .. "/venv/bin/python"
--                         if vim.fn.executable(venv_path) == 1 then
--                             config.settings.python.pythonPath = venv_path
--                         end
--                     end,
--                 },
--                 jdtls = {},
--                 gopls = {},
--                 ruff = {},
--             }
--         },
--         config = function(_, opts)
--             local lspconfig = require('lspconfig')
--             for server, config in pairs(opts.servers) do
--                 config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
--                 -- lspconfig[server].setup(config)
--                 vim.lsp.config(server, config)
--             end
--         end
--     },
-- }
