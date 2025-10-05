return {
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            -- Simple GitSigns configuration
            require('gitsigns').setup({
                signs = {
                    add          = { text = '▎' }, -- New lines added
                    change       = { text = '▎' }, -- Modified lines
                    delete       = { text = '-' }, -- Deleted lines
                    topdelete    = { text = '‾' }, -- Lines deleted at top
                    changedelete = { text = '▎' }, -- Changed and deleted
                    untracked    = { text = '┆' }, -- Untracked files
                },

                -- Show signs in the number column instead of sign column
                signcolumn = true,

                -- Show line numbers with changes highlighted
                numhl = false,

                -- Show line highlights for changes
                linehl = false,

                -- Show word diff in current line
                word_diff = false,

                -- Keymaps for navigation and actions
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns

                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation between hunks
                    map('n', ']c', function()
                        if vim.wo.diff then return ']c' end
                        vim.schedule(function() gs.next_hunk() end)
                        return '<Ignore>'
                    end, { expr = true, desc = "Next hunk" })

                    map('n', '[c', function()
                        if vim.wo.diff then return '[c' end
                        vim.schedule(function() gs.prev_hunk() end)
                        return '<Ignore>'
                    end, { expr = true, desc = "Previous hunk" })

                    -- Actions
                    map('n', '<leader>hs', gs.stage_hunk, { desc = "Stage hunk" })
                    map('n', '<leader>hr', gs.reset_hunk, { desc = "Reset hunk" })
                    map('n', '<leader>hS', gs.stage_buffer, { desc = "Stage buffer" })
                    map('n', '<leader>hu', gs.undo_stage_hunk, { desc = "Undo stage hunk" })
                    map('n', '<leader>hR', gs.reset_buffer, { desc = "Reset buffer" })
                    map('n', '<leader>hp', gs.preview_hunk, { desc = "Preview hunk" })
                    map('n', '<leader>hb', function() gs.blame_line { full = true } end, { desc = "Blame line" })
                    map('n', '<leader>hd', gs.diffthis, { desc = "Diff this" })
                    map('n', '<leader>hD', function() gs.diffthis('~') end, { desc = "Diff this ~" })

                    -- Toggle options
                    map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = "Toggle blame" })
                    map('n', '<leader>td', gs.toggle_deleted, { desc = "Toggle deleted" })

                    -- Text object for hunks
                    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = "Select hunk" })
                end,

                -- Auto-attach to buffers
                attach_to_untracked = true,

                -- Update signs as you type
                update_debounce = 100,

                -- Show blame info for current line
                current_line_blame = false,
                current_line_blame_opts = {
                    virt_text = true,
                    virt_text_pos = 'eol',
                    delay = 1000,
                },

                -- Preview window config
                preview_config = {
                    border = 'single',
                    style = 'minimal',
                    relative = 'cursor',
                    row = 0,
                    col = 1
                },
            })

            -- Optional: Custom highlights for better visibility
            vim.api.nvim_set_hl(0, 'GitSignsAdd', { fg = _G.THEME_CONFIG.colors.green })   -- Green
            vim.api.nvim_set_hl(0, 'GitSignsChange', { fg = _G.THEME_CONFIG.colors.blue }) -- Blue
            vim.api.nvim_set_hl(0, 'GitSignsDelete', { fg = _G.THEME_CONFIG.colors.red })  -- Red
        end
    }
}
