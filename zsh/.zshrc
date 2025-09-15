if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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

    zgenom load romkatv/powerlevel10k powerlevel10k

    zgenom save
fi

# Set NeoVim as default editor
export EDITOR="nvim"
export VISUAL="nvim"

export PATH="/usr/local/sbin:$PATH"

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

envload() {
  set -o allexport
  source "$1"
  set +o allexport
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

# AWS Route53 domain record fetcher
alias dnsrecord="~/scripts/aws-r53-record-fetcher/get_r53_records_fzf.sh"

# Yazi as f and Superfile as F
alias F='spf'
alias f='y'

alias G='lazygit'

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
