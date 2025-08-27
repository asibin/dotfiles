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
if ! command -v brew &>/dev/null; then
  printf "${GREEN}Homebrew not found, installing...${NOCOLOR}\n"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
printf "${BLUE}Checking if homebrew is installed: ${NOCOLOR}${GREEN}OK${NC}\n"

printf "${BLUE}Installing brew tools and apps${NOCOLOR}\n"
printf "${LIGHTGRAY}brew bundle install${NOCOLOR}\n"
brew bundle install
printf "${BLUE}Installing brew tools and apps: ${NOCOLOR}${GREEN}OK${NC}\n"

printf "${BLUE}Applying dotfiles${NOCOLOR}\n"
stow --dir ~/.dotfiles --adopt zsh tmux karabiner git hammerspoon yazi ideavim superfile
printf "${BLUE}Applying dotfiles: ${NOCOLOR}${GREEN}OK${NC}\n"

printf "${BLUE}Add Yazi plugins{NOCOLOR}\n"
ya pkg install
printf "${BLUE}Add Yazi plugins: ${NOCOLOR}${GREEN}OK${NC}\n"

# GIT
printf "${BLUE}Setup Git secret configurations${NOCOLOR}\n"
if [ -f ~/.dotfiles/git/gitconfig-private-github ]; then
  ln -sf ~/.dotfiles/git/gitconfig-private-github ~/.gitconfig-private-github
fi

if [ -f ~/.dotfiles/git/gitconfig-uc ]; then
  ln -sf ~/.dotfiles/git/gitconfig-uc ~/.gitconfig-uc
fi

if [ -f ~/.dotfiles/git/gitconfig-netronix ]; then
  ln -sf ~/.dotfiles/git/gitconfig-netronix ~/.gitconfig-netronix
fi
printf "${BLUE}Setup Git configuration: ${NOCOLOR}${GREEN}OK${NC}\n"

printf "\n${GREEN}--- Setup DONE ---${NOCOLOR}\n"
