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
                automatic_enable = false,
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
            for server, config in pairs(opts.servers) do
                config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
                -- lspconfig[server].setup(config)
                vim.lsp.config(server, config)
            end
        end
    },
}
