return {
    "saghen/blink.cmp",
    version = "1.4.*",
    event = "InsertEnter",
    dependencies = {
        "rafamadriz/friendly-snippets",
        { "ray-x/lsp_signature.nvim", event = "LspAttach" }, -- signature help
        "L3MON4D3/LuaSnip",
    },
    opts = {
        snippets = {
            expand = function(snippet)
                -- Pick ONE:
                -- vim.fn["vsnip#anonymous"](snippet)         -- vsnip
                require("luasnip").lsp_expand(snippet) -- luasnip
            end,
        },
        appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = "mono",
            kind_icons = {
                Text = " ",
                Method = " ",
                Function = "󰊕 ",
                Constructor = " ",
                Field = " ",
                Variable = "󰀫 ",
                Class = " ",
                Interface = " ",
                Module = "󰏓 ",
                Property = " ",
                Unit = " ",
                Value = "󰎠 ",
                Enum = " ",
                Keyword = " ",
                Snippet = " ",
                Color = " ",
                File = " ",
                Reference = " ",
                Folder = " ",
                EnumMember = " ",
                Constant = " ",
                Struct = " ",
                Event = " ",
                Operator = " ",
                TypeParameter = " ",
            },
        },
        completion = {
            menu = { border = "rounded" },
            accept = { auto_brackets = { enabled = true } },
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 200,
                window = { border = "rounded" },
            },
            ghost_text = { enabled = false },
        },
        sources = { default = { "lsp", "path", "snippets", "buffer" } },
        keymap = {
            preset = 'default',
            ["<CR>"] = { "accept", "fallback" }, -- Enter confirms or inserts newline
            ["<Tab>"] = { "select_next", "fallback" },
            ["<S-Tab>"] = { "select_prev", "fallback" },
        },
    },
    config = function(_, opts)
        require("blink.cmp").setup(opts)
        require("lsp_signature").setup({
            floating_window = true,
            hint_enable = false,
            handler_opts = { border = "rounded" },
        })
    end,
}
