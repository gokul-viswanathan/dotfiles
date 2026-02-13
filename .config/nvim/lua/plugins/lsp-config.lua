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
          "lua_ls", "ts_ls", "basedpyright", "gopls",
          "rust_analyzer", "html", "cssls", "jsonls", "yamlls",
          "bashls", "dockerls", "sqls", "ruff"
        },
        automatic_installation = true,
        automatic_enable = {
          exclude = { "jdtls", "rust_analyzer" },
        },
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "b0o/schemastore.nvim",
    },
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
              workspace = {
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
            local venv_paths = {
              root_dir .. "/.venv/bin/python",
              root_dir .. "/venv/bin/python",
            }
            for _, venv_path in ipairs(venv_paths) do
              if vim.fn.executable(venv_path) == 1 then
                config.settings.python.pythonPath = venv_path
                break
              end
            end
          end,
        },
        -- jdtls configured separately via nvim-jdtls plugin (see ftplugin/java.lua)
        gopls = {
          settings = {
            gopls = {
              analyses = {
                unusedparams = true,
                shadow = true,
                nilness = true,
                unusedwrite = true,
                useany = true,
              },
              staticcheck = true,
              gofumpt = true,
              completeUnimported = true,
              usePlaceholders = true,
              semanticTokens = true,
              codelenses = {
                gc_details = true,
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
              },
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
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
      local schemastore = require('schemastore')

      -- Inject schemastore schemas (deferred so the plugin is loaded)
      opts.servers.jsonls = {
        settings = {
          json = {
            schemas = schemastore.json.schemas(),
            validate = { enable = true },
          },
        },
      }
      opts.servers.yamlls = {
        settings = {
          yaml = {
            schemaStore = { enable = false, url = "" },
            schemas = schemastore.yaml.schemas(),
          },
        },
      }

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

      -- Buffer-local LSP keymaps via LspAttach
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
        callback = function(ev)
          local bufnr = ev.buf
          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
          end

          -- Navigation
          map("n", "gd", vim.lsp.buf.definition, "Go to definition")
          map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
          map("n", "gr", vim.lsp.buf.references, "References")
          map("n", "gI", vim.lsp.buf.implementation, "Go to implementation")
          map("n", "gy", vim.lsp.buf.type_definition, "Go to type definition")

          -- Docs / info
          map("n", "K", vim.lsp.buf.hover, "Hover docs")
          map({ "n", "i" }, "<C-k>", vim.lsp.buf.signature_help, "Signature help")

          -- Actions
          map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
          map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
          map("n", "<leader>lf", function() vim.lsp.buf.format({ async = true }) end, "Format buffer")

          -- Inlay hints (capability-conditional)
          if client and client:supports_method("textDocument/inlayHint") then
            map("n", "<leader>th", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
            end, "Toggle inlay hints")
          end

          -- Codelens (capability-conditional)
          if client and client:supports_method("textDocument/codeLens") then
            map("n", "<leader>cl", vim.lsp.codelens.run, "Run codelens")
            map("n", "<leader>cL", vim.lsp.codelens.refresh, "Refresh codelens")

            vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
              buffer = bufnr,
              callback = vim.lsp.codelens.refresh,
            })
          end
        end,
      })
    end
  },
}
