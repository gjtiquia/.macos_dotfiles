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

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# Setup yazi - y alias
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# Setup zoxide - z alias
eval "$(zoxide init zsh)"
