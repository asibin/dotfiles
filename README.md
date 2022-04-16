# Dotfiles

.dotfiles and script for setting up new MacOS machine. 

## NOTE

Note that this repo is probably not usable out-of-the-box
 for everyone because it has my personal preferences.
 This repo is public in order to provide examples for
 others that are creating their own dotfiles repos
 as I have created these by combining multiple sources
 (other people's dotfiles, multiple blogs, 
 documentation, etc.) and tuning them to my needs.

### Assumptions
- ~/workspace as workspace folder
- neovim's startify workspace MRU folders function is hardcoded to ~/workspace
- Apps that are installed are apps that is use or HAVE to use (i am looking at you Skype)
- aliases are my own

## What is included

- Brew installation
- Usefull CLI tools installed from brew
- Applications installed from brew
- .zshrc config with Zgen, ohmyzsh, git completions, ncurses history,
  suggestions, etc.
- .tmux.conf - vim motions compatible, one-dark themed, tmux-continuum,
  OS clipboard compatible, custom status bar with battery status
- Neovim / vim config with vim-plug plugin manager
  - Themed
  - vim-polyglot
  - nerdtree with support for devicons and git icons
  - vim-fugitive
  - vim-airline
  - coc.nvim
  - vimspector
  - vim-unimpared
  - vim-surround
  - vim-gitgutter
  - fzf & fzf.vim
  - nerdcommenter
  - vim-startify
  - vitality.vim
  - vim-tmux-navigator
  - custom keybinds
  - custom starify MRU list for workspace folders
- Git config with global .gitignore
- iterm2 customized one-dark theme
- Hammerspoon & Karabiner configs with PublicIP spoon
- shell script to setup everything
- The Silver Searcher with ignore file

## Usage

Clone and run setup.sh

```bash
git clone git@github.com:asibin/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./setup.sh
```
