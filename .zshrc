# Use powerline
USE_POWERLINE="true"
HAS_WIDECHARS="false"

## Source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
	source /usr/share/zsh/manjaro-zsh-config
fi
# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)
#alias 
alias n='nvim'
alias vs='code'
alias oc='opencode'
alias cs='cursor'
alias ff='fzf --preview "bat --style=numbers --color=always {} || cat {}" --preview-window=right:60%'
alias fg='rg --line-number --no-heading --color=always . | fzf --ansi --delimiter : --nth 3.. --preview "bat --style=numbers --color=always {1} --highlight-line {2}"'
alias ls='eza -lh --icons=always --color=always --group-directories-first --git --time-style=long-iso --no-permissions --no-user'
alias lt='eza --tree --level=2 --icons=always --group-directories-first'

#for neovim
export PATH="$PATH:/opt/nvim-linux64/bin"

#flyway
export FLYCTL_INSTALL="/home/gokul/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"

#starship
export STARSHIP_CONFIG=/home/gokul/.config/starship/starship.toml

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

#java 
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk
export PATH=$JAVA_HOME/bin:$PATH

#terminal blink line for ZSh shell
# Cursor shape for vi mode
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'  # block cursor
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'  # beam cursor
  fi
}
zle -N zle-keymap-select

# Initialize cursor on zsh startup
zle-line-init() {
    echo -ne "\e[5 q"  # beam cursor
}
zle -N zle-line-init
set -o vi
# Reset cursor on exit
preexec() { echo -ne '\e[5 q' ;}

#carapase setup 
# ${UserConfigDir}/zsh/.zshrc
export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
source <(carapace _carapace)
