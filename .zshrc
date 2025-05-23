echo "loading .zshrc..."

alias so="source ~/.zshrc"
alias nvimrc="cd ~/.config/nvim"

# this was already here lol, not deleting it haha
. "/Users/gjtiquia/.deno/env"

# dotfiles management
DOTFILES_HOME=$HOME
DOTFILES_GIT_DIR=.macos_dotfiles
alias dotfiles="git --git-dir=$DOTFILES_HOME/$DOTFILES_GIT_DIR/ --work-tree=$DOTFILES_HOME"

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)
