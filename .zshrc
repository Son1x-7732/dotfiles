# ==========================================
#  ZENO'S POWER USER ZSH CONFIG (CachyOS)
# ==========================================

# --- 1. INSTANT PROMPT (Must be at the top) ---
# Enables the prompt to appear instantly while plugins load in the background
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# --- 2. ENVIRONMENT & SETTINGS ---
export EDITOR='micro'
export VISUAL='micro'
export TERMINAL='kitty'
export MANPAGER="sh -c 'col -bx | bat -l man -p'" # Use bat for man pages
export PATH="$HOME/.local/bin:$PATH"

# History Settings (Optimized for performance)
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY          # Append to history file
setopt INC_APPEND_HISTORY      # Write to history immediately
setopt HIST_IGNORE_DUPS        # Don't record duplicates
setopt HIST_FIND_NO_DUPS       # Do not display duplicates when searching
setopt SHARE_HISTORY           # Share history between terminals
setopt BANG_HIST               # Enable !! and !$ expansion

# --- 3. CACHYOS / ARCH PLUGINS ---
# We source these directly from /usr/share to avoid "Oh My Zsh" bloat

# A. Powerlevel10k Theme
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# B. Fish-like Syntax Highlighting (Must be at the end of plugins)
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# C. Ghost History (Autosuggestions)
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# Tweak: Make suggestions grey (like Fish)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

# D. History Substring Search (Type 'git' then Up Arrow)
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

# E. "Command Not Found" handler (Suggests which package to install)
source /usr/share/doc/pkgfile/command-not-found.zsh

# F. FZF Integration (Ctrl+R for history, Ctrl+T for files)
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh

# --- 4. KEYBINDINGS ---
bindkey -e # Use Emacs mode (Standard)

# Map Up/Down to History Substring Search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# --- 5. HELPER FUNCTIONS ---

# Function: Backup a file (usage: backup file.txt -> file.txt.bak)
function backup() {
    cp -iv "$1" "$1.bak"
}

# Note: Zsh supports '!!' and '!$' natively.
# You don't need functions for them. Just type '!!' and hit Enter.

# --- 6. ALIASES (Ported from Fish) ---

# > Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ll='eza -al --color=always --group-directories-first --icons'
alias ls='eza -al --color=always --group-directories-first --icons'
alias lt='eza -aT --color=always --group-directories-first --icons'

# > Package Management (Paru/Pacman)
alias update='paru -Syu'
alias install='paru -S'
alias search='paru -Ss'
alias delete='paru -Rns'
alias cleanup='paru -Rns $(pacman -Qtdq)' # Removed orphans
alias cleancache='paru -Sc'
alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias mirror="sudo cachyos-rate-mirrors"
alias findpkg="paru -Qs"
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl" # Recent installs

# > Config Shortcuts
alias zshconf="micro ~/.zshrc"
alias fishconf="micro ~/.config/fish/config.fish" # Keep this just in case
alias kittyconf="micro ~/.config/kitty/kitty.conf"
alias alacrittyconf="micro ~/.config/alacritty/alacritty.toml"
alias hyprconf="micro ~/.config/hypr/hyprland.conf"
alias niriconf="micro ~/.config/niri/config.kdl"
alias reload="source ~/.zshrc" # Reload Zsh config instantly
alias waybarjson="micro ~/.config/waybar/config.jsonc"
alias waybarcss="micro ~/.config/waybar/style.css"

# > Utils
alias tb='nc termbin.com 9999'
alias gstatus='gh status'
alias gclone='gh repo clone'
alias gcreate='gh repo create'
alias fixfonts="fc-cache -fv"

# > Safety
alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -v"

# --- 7. LOAD THEME CONFIG ---
# To customize prompt, run `p10k configure`
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ---Git config for Dotfiles---
alias config='/usr/bin/git --git-dir=/home/zen0/.dotfiles/ --work-tree=/home/zen0'

dotsync() {
    /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME add -u
    /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME commit -m "Update: $(date)"
    /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME push
}
