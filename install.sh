#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Dotfiles directory
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Print colored output
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Detect package manager
detect_package_manager() {
    if command -v pacman &> /dev/null; then
        echo "pacman"
    elif command -v apt &> /dev/null; then
        echo "apt"
    elif command -v dnf &> /dev/null; then
        echo "dnf"
    else
        echo "unknown"
    fi
}

# Install packages for Arch/Manjaro
install_arch_packages() {
    print_info "Installing packages for Arch-based system..."

    # Core packages from official repos
    PACKAGES=(
        bat
        eza
        fd
        ripgrep
        fzf
        zoxide
        neovim
        tmux
        git-delta
        lazygit
        btop
        htop
        starship
        carapace-bin
    )

    # Check if yay is installed
    if ! command -v yay &> /dev/null; then
        print_warning "yay (AUR helper) not found. Installing yay..."
        sudo pacman -S --needed --noconfirm git base-devel
        git clone https://aur.archlinux.org/yay.git /tmp/yay
        cd /tmp/yay
        makepkg -si --noconfirm
        cd "$DOTFILES_DIR"
        print_success "yay installed successfully"
    fi

    # Install packages
    print_info "Installing official repository packages..."
    for package in "${PACKAGES[@]}"; do
        if pacman -Qi "$package" &> /dev/null; then
            print_success "$package is already installed"
        else
            print_info "Installing $package..."
            sudo pacman -S --needed --noconfirm "$package" || print_warning "Failed to install $package"
        fi
    done

    # Install ghostty from AUR if not installed
    if ! pacman -Qi ghostty &> /dev/null; then
        print_info "Installing ghostty from AUR..."
        yay -S --needed --noconfirm ghostty || print_warning "Failed to install ghostty"
    else
        print_success "ghostty is already installed"
    fi
}

# Install packages for Debian/Ubuntu
install_debian_packages() {
    print_info "Installing packages for Debian-based system..."

    sudo apt update

    PACKAGES=(
        bat
        fd-find
        ripgrep
        fzf
        neovim
        tmux
        git-delta
        btop
        htop
    )

    for package in "${PACKAGES[@]}"; do
        if dpkg -l | grep -q "^ii  $package "; then
            print_success "$package is already installed"
        else
            print_info "Installing $package..."
            sudo apt install -y "$package" || print_warning "Failed to install $package"
        fi
    done

    # Install tools not in repos
    print_warning "Some tools (eza, zoxide, starship, lazygit) need manual installation on Debian/Ubuntu"
    print_info "Visit their GitHub pages for installation instructions"
}

# Create symlinks
create_symlinks() {
    print_info "Creating symlinks for dotfiles..."

    # Backup existing files
    backup_dir="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"

    # Define files/directories to symlink
    declare -A SYMLINKS=(
        ["$DOTFILES_DIR/.zshrc"]="$HOME/.zshrc"
        ["$DOTFILES_DIR/.tmux.conf"]="$HOME/.tmux.conf"
        ["$DOTFILES_DIR/.config/nvim"]="$HOME/.config/nvim"
        ["$DOTFILES_DIR/.config/hypr"]="$HOME/.config/hypr"
        ["$DOTFILES_DIR/.config/waybar"]="$HOME/.config/waybar"
    )

    for src in "${!SYMLINKS[@]}"; do
        dest="${SYMLINKS[$src]}"

        # Skip if source doesn't exist
        if [ ! -e "$src" ]; then
            print_warning "Source $src does not exist, skipping..."
            continue
        fi

        # Backup existing file/directory
        if [ -e "$dest" ] && [ ! -L "$dest" ]; then
            print_warning "Backing up existing $dest to $backup_dir"
            mkdir -p "$backup_dir"
            mv "$dest" "$backup_dir/"
        elif [ -L "$dest" ]; then
            print_info "Removing existing symlink $dest"
            rm "$dest"
        fi

        # Create parent directory if needed
        mkdir -p "$(dirname "$dest")"

        # Create symlink
        ln -sf "$src" "$dest"
        print_success "Linked $src -> $dest"
    done
}

# Setup shell
setup_shell() {
    print_info "Setting up shell configurations..."

    # Check if zsh is installed
    if ! command -v zsh &> /dev/null; then
        print_info "Installing zsh..."
        case $(detect_package_manager) in
            pacman)
                sudo pacman -S --needed --noconfirm zsh
                ;;
            apt)
                sudo apt install -y zsh
                ;;
            *)
                print_warning "Please install zsh manually"
                return
                ;;
        esac
    fi

    # Change default shell to zsh if not already
    if [ "$SHELL" != "$(which zsh)" ]; then
        print_info "Changing default shell to zsh..."
        chsh -s "$(which zsh)"
        print_success "Default shell changed to zsh (will take effect on next login)"
    else
        print_success "zsh is already the default shell"
    fi
}

# Post-install steps
post_install() {
    print_info "Running post-install configuration..."

    # Source fzf if available
    if [ -f /usr/share/fzf/key-bindings.zsh ]; then
        print_success "fzf key bindings available"
    fi

    # Check starship config
    if [ ! -d "$HOME/.config/starship" ]; then
        mkdir -p "$HOME/.config/starship"
        print_info "Created starship config directory"
    fi

    print_info "You may need to install additional fonts for best experience:"
    print_info "  - CaskaydiaMono Nerd Font (for icons in terminal)"
    print_info "  - Run: yay -S ttf-cascadia-code-nerd"
}

# Main installation flow
main() {
    echo ""
    print_info "===== Dotfiles Installation ====="
    echo ""

    # Detect system
    PKG_MANAGER=$(detect_package_manager)
    print_info "Detected package manager: $PKG_MANAGER"
    echo ""

    # Ask for confirmation
    read -p "This will install packages and create symlinks. Continue? [y/N] " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_warning "Installation cancelled"
        exit 0
    fi

    # Install packages based on package manager
    case $PKG_MANAGER in
        pacman)
            install_arch_packages
            ;;
        apt)
            install_debian_packages
            ;;
        *)
            print_error "Unsupported package manager: $PKG_MANAGER"
            print_info "Please install packages manually from packages.txt"
            ;;
    esac

    echo ""

    # Create symlinks
    create_symlinks

    echo ""

    # Setup shell
    setup_shell

    echo ""

    # Post-install
    post_install

    echo ""
    print_success "===== Installation Complete ====="
    print_info "Please restart your terminal or run: source ~/.zshrc"
    echo ""
}

# Run main function
main
