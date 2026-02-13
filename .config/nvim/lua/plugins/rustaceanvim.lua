return {
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    lazy = false,
    init = function()
      vim.g.rustaceanvim = {
        server = {
          on_attach = function(client, bufnr)
            client.server_capabilities.documentHighlightProvider = false

            local map = function(mode, lhs, rhs, desc)
              vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
            end

            map("n", "<leader>rd", function() vim.cmd.RustLsp("debuggables") end, "Rust debuggables")
            map("n", "<leader>rr", function() vim.cmd.RustLsp("runnables") end, "Rust runnables")
            map("n", "<leader>re", function() vim.cmd.RustLsp("expandMacro") end, "Rust expand macro")
            map("n", "<leader>rc", function() vim.cmd.RustLsp("openCargo") end, "Rust open Cargo.toml")
            map("n", "<leader>rp", function() vim.cmd.RustLsp("parentModule") end, "Rust parent module")
          end,
          default_settings = {
            ["rust-analyzer"] = {
              checkOnSave = {
                command = "clippy",
              },
              cargo = {
                allFeatures = true,
              },
              procMacro = {
                enable = true,
              },
              inlayHints = {
                closingBraceHints = { enable = true },
                parameterHints = { enable = true },
                typeHints = { enable = true },
              },
              lens = {
                enable = true,
                references = { adt = { enable = true }, method = { enable = true } },
              },
            },
          },
        },
      }
    end,
  },
}
