# Dotfiles

My personal dotfiles for Arch/Manjaro Linux with Hyprland.

## Features

- **Shell**: Zsh with Starship prompt
- **Editor**: Neovim with custom configuration
- **Terminal**: Ghostty
- **Multiplexer**: Tmux
- **WM**: Hyprland with custom keybindings
- **CLI Tools**: Modern replacements for common utilities

## Quick Start

### One-Line Install

```bash
git clone https://github.com/yourusername/dotfiles.git ~/.dotfiles && cd ~/.dotfiles && ./install.sh
```

### Manual Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

2. Run the install script:
```bash
./install.sh
```

3. Restart your terminal or source the config:
```bash
source ~/.zshrc
```

## What Gets Installed

### Core CLI Tools
- **bat** - Better `cat` with syntax highlighting
- **eza** - Modern `ls` replacement with icons
- **fd** - Better `find` alternative
- **ripgrep** - Fast `grep` alternative
- **fzf** - Fuzzy finder for the command line
- **zoxide** - Smarter `cd` command that learns your habits

### Development Tools
- **neovim** - Modern vim-based editor
- **tmux** - Terminal multiplexer
- **git-delta** - Better git diff viewer
- **lazygit** - TUI for git operations

### System Monitoring
- **btop** - Beautiful resource monitor
- **htop** - Interactive process viewer

### Shell Enhancements
- **starship** - Cross-shell prompt with git integration
- **carapace** - Multi-shell completion engine

## What Gets Symlinked

The install script will create symlinks for:
- `.zshrc` → `~/.zshrc`
- `.tmux.conf` → `~/.tmux.conf`
- `.config/nvim` → `~/.config/nvim`
- `.config/hypr` → `~/.config/hypr`
- `.config/waybar` → `~/.config/waybar`

Existing files will be backed up to `~/.dotfiles_backup_<timestamp>/`

## Custom Aliases

The `.zshrc` includes several useful aliases:

```bash
n      # nvim
oc     # opencode
ff     # fzf with bat preview
fg     # ripgrep with fzf integration
ls     # eza with icons and git status
lt     # eza tree view
```

## Hyprland Configuration

Includes configuration for:
- **hyprland.conf** - Main Hyprland config with keybindings
- **hyprlock.conf** - Lock screen configuration
- **hypridle.conf** - Idle management (auto-lock after 5min, screen off after 10min)
- **waybar** - Status bar configuration

## Post-Installation

### Recommended Fonts

Install Nerd Fonts for proper icon display:
```bash
yay -S ttf-cascadia-code-nerd
```

### Starship Configuration

If you want to customize the prompt:
```bash
nvim ~/.config/starship/starship.toml
```

### Neovim Setup

On first launch, Neovim will automatically install plugins via lazy.nvim.

## Updating

To update your dotfiles:
```bash
cd ~/.dotfiles
git pull
./install.sh  # Re-run to update symlinks
```

## Manual Package Installation

If you prefer to install packages manually, see `packages.txt` for the complete list.

## Supported Systems

- **Primary**: Arch Linux, Manjaro
- **Experimental**: Debian/Ubuntu (some packages need manual installation)

## Troubleshooting

### hypridle not working

Make sure hypridle and hyprutils are up to date:
```bash
sudo pacman -Syu
```

### Missing icons in terminal

Install a Nerd Font and configure your terminal to use it.

### zsh not set as default shell

Manually set it:
```bash
chsh -s $(which zsh)
```

## License

MIT

## Contributing

Feel free to fork and customize for your own use!
