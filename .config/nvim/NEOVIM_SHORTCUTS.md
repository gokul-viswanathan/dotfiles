# 🎯 Complete Neovim Shortcuts Cheat Sheet

Here's your comprehensive guide to all the keybindings in your enhanced Neovim configuration:

---

## 🚀 Core Navigation & Editing

| Shortcut | Description | Mode |
|----------|-------------|------|
| `jk` | Exit insert mode | Insert |
| `<leader>/` | Remove search highlight | Normal |
| `<C-w><left/right/up/down>` | Resize windows | Normal |

---

## 🔍 LSP (Language Server Protocol)

| Shortcut | Description | Mode |
|----------|-------------|------|
| `gd` | Go to definition (vertical split) | Normal |
| `gD` | Go to definition (horizontal split) | Normal |
| `gt` | Go to definition (new tab) | Normal |
| `gr` | Find references | Normal |
| `<leader>k` | Show hover documentation | Normal |
| `<leader>ca` | Code actions | Normal |
| `<leader>rn` | Rename symbol | Normal |
| `[d` | Previous diagnostic | Normal |
| `]d` | Next diagnostic | Normal |
| `<leader>xf` | Show line diagnostics | Normal |

---

## 🔎 Telescope (Fuzzy Finder)

### File Operations
| Shortcut | Description |
|----------|-------------|
| `<leader>ff` | Find files |
| `<leader>fF` | Find all files (including hidden) |
| `<leader>fe` | File browser |
| `<leader>fr` | Recent files |

### Search Operations
| Shortcut | Description |
|----------|-------------|
| `<leader>fg` | Live grep (search in files) |
| `<leader>fG` | Live grep with arguments |
| `<leader>fw` | Grep word under cursor |
| `<leader>fs` | Search in current buffer |

### Buffer & Help
| Shortcut | Description |
|----------|-------------|
| `<leader>fb` | Find buffers |
| `<leader>fh` | Help tags |
| `<leader>fk` | Keymaps |
| `<leader>fc` | Commands |

### LSP Integration
| Shortcut | Description |
|----------|-------------|
| `<leader>fd` | Diagnostics |
| `<leader>fs` | Document symbols |
| `<leader>fS` | Workspace symbols |
| `<leader>fr` | References |
| `<leader>fi` | Implementations |
| `<leader>ft` | Type definitions |

### Git Operations
| Shortcut | Description |
|----------|-------------|
| `<leader>gc` | Git commits |
| `<leader>gb` | Git branches |
| `<leader>gs` | Git status |

### Todo Operations
| Shortcut | Description |
|----------|-------------|
| `<leader>ft` | Find todos |
| `<leader>fT` | Find specific todos (TODO,FIX,FIXME) |

---

## 📁 File Management

### Neo-tree
| Shortcut | Description |
|----------|-------------|
| `<leader>e` | Toggle file explorer |
| `<leader>b` | Show buffers in explorer |
| `<leader>g` | Show git status in explorer |

### Buffer Management
| Shortcut | Description |
|----------|-------------|
| `<leader>bd` | Close current buffer |
| `<leader>bp` | Toggle buffer pin |
| `<leader>bP` | Close non-pinned buffers |
| `<leader>br` | Close buffers to the right |
| `<leader>bl` | Close buffers to the left |
| `<S-J>` | Previous buffer |
| `<S-K>` | Next buffer |
| `[b` | Previous buffer |
| `]b` | Next buffer |
| `[B` | Move buffer left |
| `]B` | Move buffer right |

---

## 🔧 Git Integration (Gitsigns)

| Shortcut | Description | Mode |
|----------|-------------|------|
| `]c` | Next hunk | Normal |
| `[c` | Previous hunk | Normal |
| `<leader>hs` | Stage hunk | Normal |
| `<leader>hr` | Reset hunk | Normal |
| `<leader>hS` | Stage buffer | Normal |
| `<leader>hu` | Undo stage hunk | Normal |
| `<leader>hR` | Reset buffer | Normal |
| `<leader>hp` | Preview hunk | Normal |
| `<leader>hb` | Blame line | Normal |
| `<leader>hD` | Diff this | Normal |
| `<leader>tb` | Toggle blame | Normal |
| `<leader>td` | Toggle deleted | Normal |
| `ih` | Select hunk | Visual/Operator |

---

## ⚡ Flash (Motion)

| Shortcut | Description | Mode |
|----------|-------------|------|
| `s` | Flash jump | Normal/Visual/Operator |
| `S` | Flash treesitter | Normal/Visual/Operator |

---

## 🔍 Diagnostics & Troubleshooting

### Trouble
| Shortcut | Description |
|----------|-------------|
| `<leader>xx` | Toggle project diagnostics |
| `<leader>xX` | Toggle buffer diagnostics |

### Which-Key
| Shortcut | Description |
|----------|-------------|
| `<leader>?` | Show buffer local keymaps |

---

## 💡 Pro Tips

1. **Leader Key**: All shortcuts starting with `<leader>` use `Space` as the leader key
2. **Discovery**: Use `<leader>?` to see available shortcuts in current context
3. **Search**: `<leader>fg` is your most powerful tool for finding anything
4. **Navigation**: `gd` for definitions, `gr` for references
5. **Git**: `<leader>hs` to stage hunks, `<leader>hp` to preview changes
6. **Buffers**: `<S-J/K>` for quick buffer switching

## 🎯 Most Used Shortcuts

- `<leader>ff` - Find files
- `<leader>fg` - Search in project
- `gd` - Go to definition
- `<leader>ca` - Code actions
- `<leader>e` - File explorer
- `<leader>xx` - Diagnostics

---

*This file is auto-generated from your Neovim configuration.*