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

# setup local binaries
export PATH="$PATH:$HOME/.local/bin"

# homebrew setup
eval "$(/opt/homebrew/bin/brew shellenv)"

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

# nvm setup
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# bob setup
export PATH="$PATH:$HOME/.local/share/bob/nvim-bin"
