#!/usr/bin/env bash

PYTHON_VERSION="3.10"
NODEJS_VERSION="16"

set -e

RED='\e[1;31m'
BLUE='\e[1;34m'
GREEN='\e[1;32m'
LIGHTGRAY='\e[1;37m'
NOCOLOR='\e[0m'


printf "${BLUE}Checking if homebrew is installed${NOCOLOR}\n"
if ! command -v brew &> /dev/null
then
  printf "${GREEN}Homebrew not found, installing...${NOCOLOR}\n"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
printf "${BLUE}Checking if homebrew is installed: ${NOCOLOR}${GREEN}OK${NC}\n"

tools=(
  "bat"
  "cookiecutter"
  "colima"
  "dive"
  "docker"
  "git-delta"
  "git-lfs"
  "helm"
  "htop"
  "httpie"
  "iperf3"
  "jq"
  "k9s"
  "kubernetes-cli"
  "lima"
  "mtr"
  "ncdu"
  "neovim"
  "nmap"
  "node@${NODEJS_VERSION}"
  "pwgen"
  "pyenv"
  "python@${PYTHON_VERSION}"
  "ripgrep"
  "sqlite"
  "the_silver_searcher"
  "tldr"
  "tmux"
  "wget"
  "youtube-dl"
)

printf "${BLUE}Installing brew tools${NOCOLOR}\n"
printf "${LIGHTGRAY}brew install ${tools[@]}${NOCOLOR}\n"
brew install ${tools[@]}

apps=(
  "alfred"
  "anydesk"
  "dropbox"
  "enpass"
  "font-hack-nerd-font"
  "google-chrome"
  "hammerspoon"
  "hma-pro-vpn"
  "intellij-idea"
  "intune-company-portal"
  "iterm2"
  "joplin"
  "karabiner-elements"
  "keepassx"
  "microsoft-office"
  "obs"
  "onedrive"
  "plex"
  "postman"
  "rancher"
  "signal"
  "skype"
  "slack"
  "spotify"
  "steam"
  "teamviewer" "telegram"
  "tunnelblick"
  "vlc"
  "webex"
  "wireshark"
)

printf "${BLUE}Add casks for brew${NOCOLOR}\n" 
brew tap homebrew/cask
brew tap homebrew/cask-fonts
printf "${BLUE}Add casks for brew: ${NOCOLOR}${GREEN}OK${NC}\n" 

printf "${BLUE}Installing MacOS apps${NOCOLOR}\n"
printf "${LIGHTGRAY}brew install --cask ${tools[@]}${NOCOLOR}\n"
brew install --cask "${apps[@]}"
printf "${BLUE}Installing MacOS apps: ${NOCOLOR}${GREEN}OK${NC}\n"

# No brew formulae
# postgres app, magnet app, amphetamine app, notability


# ZSHRC
printf "${BLUE}Setup zshrc plugins${NOCOLOR}\n"
ln -sf ~/.dotfiles/zsh/.zshrc ~/.zshrc
ln -sf ~/.dotfiles/zsh/.p10k.zsh ~/.p10k.zsh
printf "${BLUE}Setup zshrc plugins: ${NOCOLOR}${GREEN}OK${NC}\n"


# NEOVIM
printf "${BLUE}Setup vim / neovim configs${NOCOLOR}\n"
ln -sf ~/.dotfiles/nvim/init.vim ~/.config/nvim/init.vim 
ln -sf ~/.dotfiles/nvim/coc-settings.json ~/.config/nvim/coc-settings.json 
ln -sf ~/.dotfiles/nvim/init.vim ~/.vimrc

if [ ! -f ~/.vim/autoload/plug.vim ]; then
  printf "${BLUE}Installing vim-plug...${NOCOLOR}\n"
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

printf "${BLUE}Setup pynvim for neovim extensions that require python${NOCOLOR}\n"
pip3 install pynvim autopep8 pep8 flake8
printf "${BLUE}Setup vim / neovim configs: ${NOCOLOR}${GREEN}OK${NC}\n"

printf "${BLUE}Installing vim / vimspector plugins${NOCOLOR}\n"
nvim +PlugInstall +VimspectorInstall +qa 
printf "${BLUE}Setup vim / neovim configs: ${NOCOLOR}${GREEN}OK${NC}\n"


# TMUX
printf "${BLUE}Setup tmux${NOCOLOR}\n"
ln -sf ~/.dotfiles/tmux/.tmux.conf ~/.tmux.conf

if [ ! -d ~/.tmux/plugins/tpm ]; then
  printf "${BLUE}Installing tmux plugin manager...${NOCOLOR}\n"
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
printf "${BLUE}Setup tmux: ${NOCOLOR}${GREEN}OK${NC}\n"


# SILVER SEARCHER
printf "${BLUE}Setup Silver Searcher's .ignore file${NOCOLOR}\n"
ln -sf ~/.dotfiles/.ignore ~/.ignore
printf "${BLUE}Setup Silver Searcher's .ignore file: ${NOCOLOR}${GREEN}OK${NC}\n"


# HAMMERSPOON
printf "${BLUE}Setup hammerspoon config${NOCOLOR}\n"
ln -sf ~/.dotfiles/hammerspoon/init.lua ~/.hammerspoon/init.lua

if [ ! -d ~/.hammerspoon/Spoons/PublicIP.spoon ]; then
  printf "${BLUE}Add PublicIP plugin for hammerspoon${NOCOLOR}"
  git clone https://github.com/asibin/hammerspoon-spoon-PublicIP.git ~/.hammerspoon/Spoons/PublicIP.spoon
fi
printf "${BLUE}Setup hammerspoon config: ${NOCOLOR}${GREEN}OK${NC}\n"


# KARABINER
printf "${BLUE}Karabiner setup${NOCOLOR}\n"
ln -sf ~/.dotfiles/karabiner/karabiner.json ~/.config/karabiner/karabiner.json
printf "${BLUE}Karabiner setup: ${NOCOLOR}${GREEN}OK${NC}\n"


# GIT
printf "${BLUE}Setup Git configuration${NOCOLOR}\n"
ln -sf ~/.dotfiles/git/gitconfig ~/.gitconfig
ln -sf ~/.dotfiles/git/gitignore ~/.gitignore

if [ -f ~/.dotfiles/git/gitconfig-private-github ]; then
  ln -sf ~/.dotfiles/git/gitconfig-private-github ~/.gitconfig-private-github
fi

if [ -f ~/.dotfiles/git/gitconfig-uc ]; then
  ln -sf ~/.dotfiles/git/gitconfig-uc ~/.gitconfig-uc
fi
printf "${BLUE}Setup Git configuration: ${NOCOLOR}${GREEN}OK${NC}\n"


printf "\n${GREEN}--- Setup DONE ---${NOCOLOR}\n"
