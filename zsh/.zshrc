if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export XDG_CACHE_HOME="${HOME}/.cache"

# setup zsh vi mode
bindkey -v

# Make command history larger
export HISTSIZE=110000
export SAVEHIST=100000

# Removes oldest command duplicate from history first
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE

# Automatically cd if command is not a command and is equal to directory name
setopt AUTO_CD

# Append history as soon as command is ran, all shells share same history
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY

# Lazy load NVM and AUTO USE when it is loaded, needs to be specified before plugin load
export NVM_LAZY_LOAD=true
export NVM_AUTO_USE=true
export NVM_LAZY_LOAD_EXTRA_COMMANDS=('vim', 'nvim')

# load zgenom
source "${HOME}/.zgenom/zgenom.zsh"

zgenom autoupdate

if ! zgenom saved; then
    zgenom load zsh-users/zsh-syntax-highlighting
    zgenom load zsh-users/zsh-autosuggestions
    zgenom load lukechilds/zsh-nvm
    zgenom load Aloxaf/fzf-tab

    zgenom load romkatv/powerlevel10k powerlevel10k

    zgenom save
fi

# fzf-tab init
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup

# Set NeoVim as default editor
export EDITOR="nvim"
export VISUAL="nvim"

export MANPAGER="sh -c 'col -bx | bat -l man -p'"

export PATH="/Users/sibin/.local/bin:/usr/local/sbin:$PATH"

# Set default docker platform
export DOCKER_DEFAULT_PLATFORM=linux/amd64

# Source FZF
source <(fzf --zsh)

# FZF default command
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='--tmux 80% --cycle'

# On history search use exact matches by default and don't sort results (they are chronological)
export FZF_CTRL_R_OPTS="--no-sort --exact"
export FZF_ALT_C_OPTS="--preview 'tree -C {}'"

# Source Vault config
source ~/.vault.config

# Init zoxide
eval "$(zoxide init zsh)"

# Yazi switch to directory when exiting
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# Loads ENV files without exports, expects filename as first argument
envload() {
  set -o allexport
  source "$1"
  set +o allexport
  
  echo "Loaded environment variables:"
  grep -v '^#' "$1" | grep -v '^[[:space:]]*$' | cut -d'=' -f1 | sed 's/^/  /'
}

# Sources virtualenv in current path
workon() {
  source .venv/bin/activate
}

# Aliases
alias vim=nvim
alias v=nvim
alias cat='bat -p'
alias ls='ls --color'
alias l='ls -lah --color'
alias ll='ls -lah'
alias lln='ls -latrh'

alias k='kubectl'
alias ku='k9s'
alias kp='k9s --kubeconfig ~/.kube/config-personal '
alias kps='source ~/scripts/k8s_personal_config_switcher.sh'
alias ks='source ~/scripts/k8s_config_switcher.sh'

# AWS Route53 domain record fetcher
alias dnsrecord="~/scripts/aws-r53-record-fetcher/get_r53_records_fzf.sh"

# Yazi as f and Superfile as F
alias F='spf'
alias f='y'

alias G='lazygit'

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
