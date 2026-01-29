local jdtls = require("jdtls")

-- Find project root
local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle", "settings.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)

-- Fallback to current directory if no project root found
if not root_dir then
  root_dir = vim.fn.getcwd()
end

-- Workspace directory for JDTLS (stores project-specific data)
local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name

-- Mason path for jdtls
local mason_path = vim.fn.stdpath("data") .. "/mason"
local jdtls_path = mason_path .. "/packages/jdtls"
local lombok_path = mason_path .. "/packages/lombok-nightly/lombok.jar"

-- Determine OS for config selection
local os_config = "linux"
if vim.fn.has("mac") == 1 then
  os_config = "mac"
elseif vim.fn.has("win32") == 1 then
  os_config = "win"
end

-- Get capabilities from completion plugin
local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok, blink_cmp = pcall(require, "blink.cmp")
if ok then
  capabilities = blink_cmp.get_lsp_capabilities(capabilities)
end

-- Ensure completion item resolve support for documentation
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  },
}

-- Extended capabilities for nvim-jdtls (code generation, etc.)
local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

-- Build the command to launch jdtls
local cmd = {
  "java",
  "-Declipse.application=org.eclipse.jdt.ls.core.id1",
  "-Dosgi.bundles.defaultStartLevel=4",
  "-Declipse.product=org.eclipse.jdt.ls.core.product",
  "-Dlog.protocol=true",
  "-Dlog.level=ALL",
  "-Xmx1g",
  "--add-modules=ALL-SYSTEM",
  "--add-opens", "java.base/java.util=ALL-UNNAMED",
  "--add-opens", "java.base/java.lang=ALL-UNNAMED",
  "-jar", vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
  "-configuration", jdtls_path .. "/config_" .. os_config,
  "-data", workspace_dir,
}

-- Add lombok if available
if vim.fn.filereadable(lombok_path) == 1 then
  table.insert(cmd, 2, "-javaagent:" .. lombok_path)
end

local config = {
  cmd = cmd,
  root_dir = root_dir,
  capabilities = capabilities,

  settings = {
    java = {
      signatureHelp = { enabled = true },
      contentProvider = { preferred = "fernflower" },
      completion = {
        favoriteStaticMembers = {
          "org.junit.Assert.*",
          "org.junit.jupiter.api.Assertions.*",
          "org.mockito.Mockito.*",
          "java.util.Objects.requireNonNull",
          "java.util.Objects.requireNonNullElse",
        },
        filteredTypes = {
          "com.sun.*",
          "io.micrometer.shaded.*",
          "java.awt.*",
          "jdk.*",
          "sun.*",
        },
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      codeGeneration = {
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
        },
        useBlocks = true,
        hashCodeEquals = {
          useInstanceof = true,
          useJava7Objects = true,
        },
      },
      configuration = {
        updateBuildConfiguration = "interactive",
        -- Add your Java runtimes here if needed
        -- runtimes = {
        --   { name = "JavaSE-17", path = "/path/to/jdk-17" },
        --   { name = "JavaSE-21", path = "/path/to/jdk-21" },
        -- },
      },
      maven = {
        downloadSources = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      inlayHints = {
        parameterNames = {
          enabled = "all",
        },
      },
    },
  },

  init_options = {
    extendedClientCapabilities = extendedClientCapabilities,
  },

  on_attach = function(client, bufnr)
    -- Enable document formatting
    client.server_capabilities.documentFormattingProvider = true

    -- Java-specific keymaps
    local opts = { buffer = bufnr, silent = true }
    vim.keymap.set("n", "<leader>jo", jdtls.organize_imports, vim.tbl_extend("force", opts, { desc = "Organize Imports" }))
    vim.keymap.set("n", "<leader>jv", jdtls.extract_variable, vim.tbl_extend("force", opts, { desc = "Extract Variable" }))
    vim.keymap.set("v", "<leader>jv", function() jdtls.extract_variable(true) end, vim.tbl_extend("force", opts, { desc = "Extract Variable" }))
    vim.keymap.set("n", "<leader>jc", jdtls.extract_constant, vim.tbl_extend("force", opts, { desc = "Extract Constant" }))
    vim.keymap.set("v", "<leader>jc", function() jdtls.extract_constant(true) end, vim.tbl_extend("force", opts, { desc = "Extract Constant" }))
    vim.keymap.set("v", "<leader>jm", function() jdtls.extract_method(true) end, vim.tbl_extend("force", opts, { desc = "Extract Method" }))
  end,
}

-- Start or attach to JDTLS
jdtls.start_or_attach(config)
