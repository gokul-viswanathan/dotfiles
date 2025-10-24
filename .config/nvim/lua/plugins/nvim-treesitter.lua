return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require 'nvim-treesitter.configs'.setup({
                -- A list of parser names, or "all" (the listed parsers MUST always be installed)
                ensure_installed = {
                    "c", "cpp", "lua", "vim", "vimdoc", "query",
                    "python", "javascript", "typescript", "tsx",
                    "java", "go", "rust", "bash",
                    "json", "yaml", "toml", "html", "css", "scss",
                    "markdown", "markdown_inline",
                    "dockerfile", "gitignore", "sql",
                },

                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                indent = { enable = true, disable = { "lua" } },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<CR>",
                        node_incremental = "<CR>",
                        node_decremental = "<BS>",
                        scope_incremental = "<TAB>",
                    },
                },
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                            ["ab"] = "@block.outer",
                            ["ib"] = "@block.inner",
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true,
                        goto_next_start = {
                            ["]f"] = "@function.outer",
                            ["]c"] = "@class.outer",
                        },
                        goto_next_end = {
                            ["]F"] = "@function.outer",
                            ["]C"] = "@class.outer",
                        },
                        goto_previous_start = {
                            ["[f"] = "@function.outer",
                            ["[c"] = "@class.outer",
                        },
                        goto_previous_end = {
                            ["[F"] = "@function.outer",
                            ["[C"] = "@class.outer",
                        },
                    },
                },
                rainbow = {
                    enable = true,
                    extended_mode = true, -- Also highlight non-bracket delimiters
                    max_file_lines = nil, -- Do not enable for files with more than n lines
                },
            })
        end,
    }
}
