return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        -- Optional image support for file preview: See `# Preview Mode` for more information.
        -- {"3rd/image.nvim", opts = {}},
        -- OR use snacks.nvim's image module:
        -- "folke/snacks.nvim",
    },
    lazy = false, -- neo-tree will lazily load itself
    keys = {
        { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle Neo-tree" },
    },
    opts = {
        close_if_last_window = false, -- Close Neo-tree if it's the last window
        popup_border_style = "rounded",
        enable_git_status = true,
        enable_diagnostics = true,
        filesystem = {
            filtered_items = {
                visible = false,
                hide_dotfiles = false,
                hide_gitignored = false,
                hide_hidden = true,
            },
            follow_current_file = {
                enabled = true,
                leave_dirs_open = false,
            },
            use_libuv_file_watcher = true,
        },
        buffers = {
            follow_current_file = {
                enabled = true,
                leave_dirs_open = false,
            },
        },
        git_status = {
            window = {
                position = "float",
                width = 40,
                height = 12,
            },
        },
        default_component_configs = {
            git_status = {
                symbols = {
                    -- Change type
                    added = "✚",
                    modified = "",
                    deleted = "✖",
                    renamed = "󰁕",
                    -- Status type
                    untracked = "",
                    ignored = "",
                    unstaged = "󰄱",
                    staged = "",
                    conflict = "",
                },
            },
            icon = {
                folder_closed = "",
                folder_open = "",
                folder_empty = "󰜌",
                default = "*",
                highlight = "NeoTreeFileIcon"
            },
            modified = {
                symbol = "●",
                highlight = "NeoTreeModified",
            },
            name = {
                trailing_slash = false,
                use_git_status_colors = true,
                highlight = "NeoTreeFileName",
            },
            diagnostics = {
                symbols = {
                    hint = "",
                    info = "",
                    warn = "",
                    error = "",
                },
                highlights = {
                    hint = "DiagnosticSignHint",
                    info = "DiagnosticSignInfo",
                    warn = "DiagnosticSignWarn",
                    error = "DiagnosticSignError",
                },
            },
        },
        window = {
            position = "left",
            width = 35,
            mapping_options = {
                noremap = true,
                nowait = true,
            },
            mappings = {
                ["<space>"] = {
                    "toggle_node",
                    nowait = false,
                },
                ["<2-LeftMouse>"] = "open",
                ["<cr>"] = "open",
                ["<esc>"] = "cancel",
                ["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
                ["l"] = "focus_preview",
                -- ["S"] = "open_split",
                -- ["s"] = "open_vsplit",
                ["t"] = "open_tabnew",
                ["C"] = "close_node",
                ["z"] = "close_all_nodes",
                ["a"] = {
                    "add",
                    config = {
                        show_path = "none",
                    },
                },
                ["A"] = "add_directory",
                ["d"] = "delete",
                ["r"] = "rename",
                ["y"] = "copy_to_clipboard",
                ["x"] = "cut_to_clipboard",
                ["p"] = "paste_from_clipboard",
                ["c"] = "copy",
                ["m"] = "move",
                ["q"] = "close_window",
                ["R"] = "refresh",
                ["?"] = "show_help",
                ["<"] = "prev_source",
                [">"] = "next_source",
                ["i"] = "show_file_details",
            },
        },
        source_selector = {
            winbar = true,
            statusline = false,
            sources = {
                { source = "filesystem" },
            },
        },
    },
}
