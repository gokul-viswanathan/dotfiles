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
                ensure_installed = {
                    "lua_ls", "ts_ls", "basedpyright", "jdtls", "gopls",
                    "rust_analyzer", "html", "cssls", "jsonls", "yamlls",
                    "bashls", "dockerls", "sqls", "ruff"
                },
                automatic_installation = true, -- Changed from automatic_enable
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                lua_ls = {
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = { "vim" },
                            },
                            workspace = {
                                library = vim.api.nvim_get_runtime_file("", true),
                                checkThirdParty = false,
                            },
                            telemetry = {
                                enable = false,
                            },
                        },
                    },
                },
                ts_ls = {
                    settings = {
                        typescript = {
                            inlayHints = {
                                includeInlayParameterNameHints = 'all',
                                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                                includeInlayFunctionParameterTypeHints = true,
                                includeInlayVariableTypeHints = true,
                                includeInlayPropertyDeclarationTypeHints = true,
                                includeInlayFunctionLikeReturnTypeHints = true,
                                includeInlayEnumMemberValueHints = true,
                            }
                        },
                        javascript = {
                            inlayHints = {
                                includeInlayParameterNameHints = 'all',
                                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                                includeInlayFunctionParameterTypeHints = true,
                                includeInlayVariableTypeHints = true,
                                includeInlayPropertyDeclarationTypeHints = true,
                                includeInlayFunctionLikeReturnTypeHints = true,
                                includeInlayEnumMemberValueHints = true,
                            }
                        }
                    }
                },
                basedpyright = {
                    settings = {
                        basedpyright = {
                            analysis = {
                                typeCheckingMode = "standard",
                                autoSearchPaths = true,
                                useLibraryCodeForTypes = true,
                                diagnosticMode = "workspace",
                            },
                        },
                        python = {
                            pythonPath = "python",
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
                gopls = {
                    settings = {
                        gopls = {
                            analyses = {
                                unusedparams = true,
                                shadow = true,
                            },
                            staticcheck = true,
                            gofumpt = true,
                        },
                    },
                },
                rust_analyzer = {
                    settings = {
                        ["rust-analyzer"] = {
                            checkOnSave = {
                                command = "clippy",
                            },
                            diagnostics = {
                                enable = true,
                            },
                        },
                    },
                },
                html = {},
                cssls = {},
                jsonls = {},
                yamlls = {},
                bashls = {},
                dockerls = {},
                sqls = {},
                ruff = {},
            }
        },
        config = function(_, opts)
            local lspconfig = require('lspconfig')

            -- Get capabilities from your completion plugin
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            local ok, blink_cmp = pcall(require, 'blink.cmp')
            if ok then
                capabilities = blink_cmp.get_lsp_capabilities(capabilities)
            end

            -- Setup each server with error handling
            for server, config in pairs(opts.servers) do
                -- Merge capabilities
                config.capabilities = vim.tbl_deep_extend('force', capabilities, config.capabilities or {})

                -- Disable document highlight to remove underlines on current function
                config.on_attach = function(client, bufnr)
                    client.server_capabilities.documentHighlightProvider = false
                end

                -- Setup server with error handling
                local success, err = pcall(function()
                    vim.lsp.config(server, config)
                end)

                if not success then
                    vim.notify(string.format("Failed to setup LSP server '%s': %s", server, err), vim.log.levels.WARN)
                end
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
