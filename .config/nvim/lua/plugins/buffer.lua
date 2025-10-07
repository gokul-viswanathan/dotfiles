return {
    {
        "akinsho/bufferline.nvim",
        event = "VeryLazy",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        keys = {
            { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>",            desc = "Toggle Pin" },
            { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
            { "<leader>br", "<Cmd>BufferLineCloseRight<CR>",           desc = "Delete Buffers to the Right" },
            { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>",            desc = "Delete Buffers to the Left" },
            { "<leader>bd", "<cmd>bdelete<cr>",                        desc = "Close Buffer" },
            { "<S-J>",      "<cmd>BufferLineCyclePrev<cr>",            desc = "Prev Buffer" },
            { "<S-k>",      "<cmd>BufferLineCycleNext<cr>",            desc = "Next Buffer" },
            { "[B",         "<cmd>BufferLineMovePrev<cr>",             desc = "Move buffer prev" },
            { "]B",         "<cmd>BufferLineMoveNext<cr>",             desc = "Move buffer next" },
        },
        opts = {
            options = {
                mode = "buffers",    -- set to "tabs" to only show tabpages instead
                numbers = "ordinal", -- "none" | "ordinal" | "buffer_id" | "both" | function
                close_command = function(n)
                    -- replace with your own logic or bufdelete
                    vim.api.nvim_buf_delete(n, { force = false })
                end,
                right_mouse_command = function(n)
                    vim.api.nvim_buf_delete(n, { force = false })
                end,
                left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
                middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
                indicator = {
                    icon = '▎', -- this should be omitted if indicator style is not 'icon'
                    style = 'icon', -- 'icon' | 'underline' | 'none'
                },
                buffer_close_icon = '󰅖',
                modified_icon = '●',
                close_icon = '',
                left_trunc_marker = '',
                right_trunc_marker = '',
                diagnostics = "nvim_lsp",
                diagnostics_update_in_insert = false,
                diagnostics_indicator = function(count, level, diagnostics_dict, context)
                    local icons = {
                        error = " ",
                        warning = " ",
                        info = " ",
                        hint = " ",
                    }
                    local ret = (diagnostics_dict.error and icons.error .. diagnostics_dict.error .. " " or "")
                        .. (diagnostics_dict.warning and icons.warning .. diagnostics_dict.warning or "")
                    return vim.trim(ret)
                end,
                always_show_bufferline = false,
                persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
                max_name_length = 18,
                max_prefix_length = 15,     -- prefix used when a buffer is de-duplicated
                truncate_names = true,      -- whether or not tab names should be truncated
                tab_size = 18,
                show_buffer_icons = true,
                -- show_buffer_default_icon
                show_close_icon = true,
                show_tab_indicators = true,
                show_duplicate_prefix = true,    -- whether to show duplicate buffer prefix
                duplicates_across_groups = true, -- whether to consider duplicate paths in different groups as duplicates
                separator_style = "thick",       -- "slant" | "thick" | "thin" | "padded_slant"
                enforce_regular_tabs = false,    -- false | true
                offsets = {
                    {
                        filetype = "neo-tree",
                        text = "Neo-tree",
                        highlight = "Directory",
                        text_align = "left",
                        separator = true,
                    },
                    {
                        filetype = "undotree",
                        text = "Undotree",
                        highlight = "PanelHeading",
                        separator = true,
                    },
                    {
                        filetype = "DiffviewFiles",
                        text = "Diff View",
                        highlight = "PanelHeading",
                        separator = true,
                    },
                },
                color_icons = true, -- whether or not to add the filetype icon highlights
                get_element_icon = function(opts)
                    local devicons = require("nvim-web-devicons")
                    local icon, hl = devicons.get_icon(opts.filename or "", opts.extension, { default = true })
                    return icon, hl
                end,
                sort_by = 'insert_after_current', -- 'insert_after_current' |'insert_at_end' | 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
                ---@param opts bufferline.IconFetcherOpts
                get_element_icon = function(opts)
                    local devicons = require("nvim-web-devicons")
                    local icon, _ = devicons.get_icon(opts.filename or "", opts.extension, { default = true })
                    return icon
                end,
            },
            highlights = {
                buffer_selected = {
                    fg = "#ffffff",
                    bg = "#3b82f6",
                    bold = true,
                },
                separator_selected = {
                    fg = "#3b82f6",
                },
                indicator_selected = {
                    fg = "#3b82f6",
                },
            },
        },
        config = function(_, opts)
            require("bufferline").setup(opts)

            -- Fix bufferline when restoring a session
            vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
                callback = function()
                    vim.schedule(function()
                        pcall(vim.cmd, "BufferLineRefresh")
                    end)
                end,
            })
        end,
    },
}
