if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lazy load NVM and AUTO USE when it is loaded, needs to be specified before plugin load
export NVM_LAZY_LOAD=true
export NVM_AUTO_USE=true

# load zgen
source "${HOME}/.zgen/zgen.zsh"

if ! zgen saved; then
    zgen oh-my-zsh

    # plugins
    zgen load zsh-users/zsh-syntax-highlighting
    zgen load zsh-users/zsh-autosuggestions
    zgen load lukechilds/zsh-nvm

    zgen load romkatv/powerlevel10k powerlevel10k

    # completions
    zgen oh-my-zsh plugins/git
    zgen load zsh-users/zsh-completions src

    # save all to init script
    zgen save
fi

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

# Rancher desktop binaries
# export PATH="$HOME/.rd/bin:$PATH"
export PATH="/opt/homebrew/opt/kubernetes-cli@1.30/bin:$PATH"

# Kubectl package manager Krew
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# Set default docker platform
export DOCKER_DEFAULT_PLATFORM=linux/amd64

# FZF default command
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
# On history search use exact matches by default and don't sort results (they are chronological)
export FZF_CTRL_R_OPTS="--no-sort --exact"

export FZF_ALT_C_OPTS="--preview 'tree -C {}'"

# Pyenv
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
fi

source ~/.vault.config

export _ZO_ECHO=1
eval "$(zoxide init zsh)"

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# Aliases
alias vim=nvim
alias cat='bat -p'
alias ls='ls --color'
alias l='ls -lah --color'
alias ll='ls -lah'
alias lln='ls -latrh'

alias kp='k9s --kubeconfig ~/.kube/config-personal '
alias kps='source ~/.dotfiles/scripts/k8s_personal_config_switcher.sh'
alias ks='source ~/.dotfiles/scripts/k8s_config_switcher.sh'

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

