# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# load zgen
source "${HOME}/.zgen/zgen.zsh"

if ! zgen saved; then
    zgen oh-my-zsh

    # plugins
    zgen oh-my-zsh plugins/wd
    zgen oh-my-zsh plugins/colorize
    zgen load ohmyzsh/ohmyzsh plugins/zsh-navigation-tools
    zgen load zsh-users/zsh-syntax-highlighting
    zgen load zsh-users/zsh-autosuggestions

    # completions
    zgen oh-my-zsh plugins/git
    zgen oh-my-zsh plugins/docker
    zgen oh-my-zsh plugins/httpie
    zgen load zsh-users/zsh-completions src

    # theme
    zgen load romkatv/powerlevel10k powerlevel10k

    # save all to init script
    zgen save
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Set NeoVim as default editor
export EDITOR="nvim"
export VISUAL="nvim"

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# Virtualenvwrapper
export VIRTUALENVWRAPPER_PYTHON=~/.pyenv/shims/python3
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/workspace
source /usr/local/bin/virtualenvwrapper.sh

# Postgresql binary
export PATH=/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH
export PATH="/usr/local/sbin:$PATH"

# Node 16 binary
export PATH="/usr/local/opt/node@16/bin:$PATH"

# Rancher desktop binaries
export PATH="$HOME/.rd/bin:$PATH"

# Kubectl package manager Krew
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# Set default docker platform
export DOCKER_DEFAULT_PLATFORM=linux/amd64

# FZF default command
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
# On history search use exact matches by default and don't sort results (they are chronological)
export FZF_CTRL_R_OPTS="--no-sort --exact"


export FZF_ALT_C_OPTS="--preview 'tree -C {}'"

# Pyenv
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
fi

# Kubectl completion
# source <(kubectl completion zsh)
source <(helm completion zsh)
source <(limactl completion zsh)

source ~/.vault.config

# Aliases
alias vim=nvim
alias cat='bat -p'
alias ll='ls -lah'
alias lln='ls -latrh'
# alias idea="$HOME/.dotfiles/scripts/idea.sh"
# alias docker='nerdctl'


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
