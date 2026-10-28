# ~/.config/fish/config.fish

if status is-interactive
    zoxide init fish | source
    starship init fish | source
end

function fish_greeting
    fastfetch
end

# PATH and man pages (needs bat)
fish_add_path ~/.local/bin
set -x MANROFFOPT "-c"
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

# Listing (eza)
alias ls='eza -al --group-directories-first --icons=always'
alias ll='eza -l --group-directories-first --icons=always'
alias lt='eza -aT --group-directories-first --icons=always'

# Safety and navigation
alias rm='trash-put'
alias ..='cd ..'
alias ...='cd ../..'
alias grep='grep --color=auto'

# System
alias update='sudo pacman -Syu'
alias install='sudo pacman -S'
alias search='pacman -Ss'
alias mirror='sudo cachyos-rate-mirrors'
alias cleanup='sudo pacman -Rns (pacman -Qtdq)'
alias jctl='journalctl -p 3 -xb'
alias ff='fastfetch'
alias fishconf='micro ~/.config/fish/config.fish'
alias niriconf='micro ~/.config/niri/config.kdl'

# Push dotfiles: `dotsync` or `dotsync "tweak niri binds"`
function dotsync -d "Commit and push dotfiles"
    set -l msg "update configs"
    test (count $argv) -gt 0; and set msg "$argv"
    git -C ~/dotfiles status --short
    git -C ~/dotfiles add .
    git -C ~/dotfiles commit -m "$msg"; and git -C ~/dotfiles push
end

#Push obsidian notes
function notesync -d "Commit and push Obsidian notes"
    set -l vault ~/Documents/obsidianVault   # change this

    set -l msg "notes: "(date '+%Y-%m-%d %H:%M')
    test (count $argv) -gt 0; and set msg "$argv"

    git -C $vault status --short
    git -C $vault add -A
    git -C $vault commit -m "$msg"
    git -C $vault pull --rebase; and git -C $vault push
end
