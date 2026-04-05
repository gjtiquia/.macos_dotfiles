# GJ's MacOS .zshrc
# repo: github.com/gjtiquia/.macos_dotfiles

# =======================================
# ubuntu defaults minimalist version
# - replicating default prompt colors

autoload -U colors && colors
PROMPT='%F{green}%n@%m%f:%F{blue}%~%f %# '

# =======================================
# oh-my-zsh minimalist version

# Initialize the completion system
autoload -Uz compinit
compinit

# Enable colors for the 'ls' command 
# 'G' enables color, 'F' adds symbols (like / for dirs)
export CLICOLOR=1
alias ls='ls -GF'

# Tell the Zsh completion system to use the same colors as 'ls'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# For the completion list to be "selectable" 
# (so you can see the colors clearly while navigating)
zstyle ':completion:*' menu select

# =======================================
# BASE SETUP
# - keybindings and aliases

# vi keybindings
bindkey -v

# alias - shortcuts
alias v="nvim"
alias lg="lazygit"
alias ff="fastfetch"
alias c="clear"
alias q="exit"

# alias - dotfiles
alias nvimrc="cd ~/.config/nvim"

# dotfiles management
DOTFILES_HOME=$HOME
DOTFILES_GIT_DIR=.macos_dotfiles
alias dotfiles="git --git-dir=$DOTFILES_HOME/$DOTFILES_GIT_DIR/ --work-tree=$DOTFILES_HOME"

# =======================================
# ENV SETUP
# - most of these have to do with adding to PATH

# setup local binaries
export PATH="$PATH:$HOME/.local/bin"

# android studio platform tools setup (eg. adb)
export PATH="$PATH:$HOME/Library/Android/sdk/platform-tools"

# homebrew setup
eval "$(/opt/homebrew/bin/brew shellenv)"

# nvm setup
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# bob setup
export PATH="$PATH:$HOME/.local/share/bob/nvim-bin"

# direnv setup
eval "$(direnv hook zsh)"

# bun completions
[ -s "/Users/gjtiquia/.bun/_bun" ] && source "/Users/gjtiquia/.bun/_bun"

# bun setup
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# opencode setup
export PATH="$HOME/.opencode/bin:$PATH"

# go setup
export PATH="$HOME/go/bin:$PATH"

# .NET Core SDK tools setup
export PATH="$PATH:/Users/gjtiquia/.dotnet/tools"

# =======================================
# TOOLS SETUP
# - needs to be set after ENV SETUP cuz some tools are installed via `go install`

# fzf setup
source <(fzf --zsh)

# yazi setup
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# zoxide setup
eval "$(zoxide init zsh)"

# ifg setup
eval "$(ifg --sh)"

# =======================================
