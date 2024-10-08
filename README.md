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
- Apps that are installed are apps that I use or HAVE to use
 (I am looking at you Skype)
- aliases are my own

## What is included

- Brew installation
- Usefull CLI tools installed from brew
- Applications installed from brew
- .zshrc config with Zgen, ohmyzsh, git completions, ncurses history,
  suggestions, etc.
- .tmux.conf - vim motions compatible, one-dark themed,
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
- Hammerspoon & Karabiner configs with [PublicIP](https://github.com/asibin/hammerspoon-spoon-PublicIP) spoon
- shell script to setup everything
- The Silver Searcher with ignore file

## Neovim COC included language servers

- '@yaegassy/coc-ansible'
- 'coc-angular'
- 'coc-browser'
- 'coc-css'
- 'coc-diagnostic'
- 'coc-docker'
- 'coc-eslint'
- 'coc-git'
- 'coc-go'
- 'coc-html'
- 'coc-html-css-support'
- 'coc-json'
- 'coc-markdownlint'
- 'coc-prettier'
- 'coc-pydocstring'
- 'coc-pyright'
- 'coc-sh'
- 'coc-sql'
- 'coc-svg'
- 'coc-tsserver'
- 'coc-yaml'

## Karabiner setup

- Remap of `non_us_backslash` (§ ±) key to `grave_accent_and_tilde` (\` ~) on
 Mac's built-in keyboard (for German / EU style keyboard)
- Binding `CAPS LOCK` to `COMMAND + CTRL + OPTION + SHIFT` to be used as HYPER
 key for Hammerspoon

## Usage

Clone and run setup.sh

```bash
git clone git@github.com:asibin/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./setup.sh
```

## Known issues

- ~~TAB sometimes throws error in NeoVim when there are no completions
 and you press TAB multiple times, will investigate~~
- Karabiner symlink gets overwritten by Karabiner. Needs more research.
