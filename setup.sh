#!/usr/bin/env bash

# WARNING: THIS SCRIPT IS WORK IN PROGRESS
# PLEASE DO NOT RUN THIS SCRIPT AS IT IS UNTESTED

PYTHON_VERSION="3.10"
NODEJS_VERSION="16"

set -e

RED='\034[0;31m'
LBL='\033[1;34m'
LGR='\033[1;32m'
NC='\033[0m'


printf "${LBL}Checking if brew is installed...${NC}\n"
if ! command -v brew &> /dev/null
then
  printf "${LBL}Homebrew not found, installing...${NC}\n"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
printf "${LBL}Brew is installed. Continuing...${NC}\n"

tools=(
  "python@${PYTHON_VERSION}"
  "node@${NODEJS_VERSION}"
  "wget"
  "iperf3"
  "git-lfs"
  "jq"
  "sqlite"
  "youtube-dl"
  "k9s"
  "the_silver_searcher"
  "cookiecutter"
  "kubernetes-cli"
  "mtr"
  "ncdu"
  "pwgen"
  "tmux"
  "dive"
  "docker"
  "neovim"
  "helm"
  "htop"
  "nmap"
  "httpie"
  "lima"
  "tldr"
)

printf "${LBL}--- Installing brew tools ---${NC}\n"
printf "${LGR}brew install ${tools[@]}${NC}\n"
brew install ${tools[@]}

apps=(
  "alfred"
  "anydesk"
  "dropbox"
  "enpass"
  "font-hack-nerd-font"
  "google-chrome"
  "hma-pro-vpn"
  "intellij-idea"
  "intune-company-portal"
  "iterm2"
  "joplin"
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
  "teamviewer"
  "telegram"
  "tunnelblick"
  "vlc"
  "webex"
  "wireshark"
)

printf "${LBL}Add casks for brew${NC}\n" 
brew tap homebrew/cask
brew tap homebrew/cask-fonts

printf "${LBL}--- Installing MacOS apps ---${NC}\n"
printf "${LGR}brew install --cask ${tools[@]}${NC}\n"
brew install --cask "${apps[@]}"

# No brew formulae
# postgres app, magnet app, amphetamine app, notability

printf "${LBL}Setup zshrc plugins${NC}\n"
ln -sf --backup ~/.dotfiles/zsh/.zshrc ~/.zshrc
ln -sf --backup ~/.dotfiles/zsh/.p10k.zsh ~/.p10k.zsh

printf "${LBL}Setup vim / neovim configs${NC}\n"
ln -sf --backup ~/.dotfiles/nvim/init.vim ~/.config/nvim/init.vim 
ln -sf --backup ~/.dotfiles/nvim/coc-settings.json ~/.config/nvim/coc-settings.json 
ln -sf --backup ~/.dotfiles/nvim/init.vim ~/.vimrc

if [ ! -f ~/.vim/autoload/plug.vim ]; then
  printf "${LBL}Installing vim-plug...${NC}\n"
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

printf "${LBL}Setup pynvim for neovim extensions that require python${NC}\n"
pip install pynvim
pip3 install pynvim

pip install autopep8 pep8 flake8
pip3 install autopep8 pep8 flake8

printf "${LBL}Setup tmux configs${NC}\n"
ln -sf --backup ~/.dotfiles/tmux/.tmux.conf ~/.tmux.conf

if [ ! -d ~/.tmux/plugins/tpm ]; then
  printf "${LBL}Installing tmux plugin manager...${NC}\n"
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

printf "${LBL}Setup Silver Searcher's .ignore file${NC}\n"
ln -sf --backup ~/.dotfiles/.ignore ~/.ignore || true

printf "${LBL}--- Setup DONE ---${NC}\n\n"
printf "${LGR}
In order to install all neovim plugins run\n\n

nvim -c ':PlugInstall | :VimspectorInstall'\n

and restart vim after.
${NC}"
