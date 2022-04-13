# NeoVim notes

My notes to creating vim / tmux configuration that will fit my own needs.
Ideally this file will be empty by the time i finish my dotfiles setup.sh script.

## TODO

1. add rules to ignore for markdownlint
2. finish setting up setup.sh
3. Fix images that were migrated from Joplin

## Steps

Install neovim

```bash
brew install neovim
```

Install vim-plug: <https://github.com/junegunn/vim-plug>

```bash
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

Clone init.vim file to ~/.config/nvim/init.vim

Install <https://github.com/neovim/pynvim>

```bash
pip3 install pynvim pep8 autopep8 flake8
pip install pynvim pep8 autopep8 flake8
```

in order to have python "compiled" vim to support Vimspector. Note: no need to
 install for both python 2 and 3 if you are not using some version.

## Install vim plugins

Start vim and install all plugins

```vim
:PlugInstall
```

reload vim and

## Install language servers for coc

```vim
:CocInstall coc-prettier coc-html-css-support coc-html coc-eslint 
 coc-diagnostics coc-browser coc-yaml coc-tsserver coc-svg coc-sql
 coc-sh coc-pyright coc-pydocstring coc-markdownlint coc-json coc-go
 coc-docker coc-css coc-angular coc-ansible
```

\#TODO: move these to init.vim and make them autoinstall

## BETA: Install gadgets for Vimspector ([debugger](https://github.com/puremourning/vimspector))

```vim
:VimspectorInstall
```

Make sure to disable F11 to show desktop in MacOS and invert F keys to their
 standard roles in case you want to use **HUMAN** bindings.
![a19babd7499cf5d77d0960434b05e4af.png](:/2e45431ee0d64ea094d3be7bf4925155)

When **HUMAN** keybindings are enabled Vimspector these are the keybinds
![2ab9014dedca5aaa4aa37763c9ffe410.png](:/fe47e331e3e64892abd567e6f26bf012)

Default configurations per filetype are allowed
 ([link](https://puremourning.github.io/vimspector/configuration.html#specifying-a-default-configuration))
 but they can't cover all cases because we need to define program run command
 per project. Repo-local `.vimspector.json` file always takes presedence over
  more global files.
**TODO**: auto generate vimspector.json files through cookiecutter maybe?

## Vim unimpared bindings

[Bindings](https://github.com/tpope/vim-unimpaired/blob/master/doc/unimpaired.txt)

\[e and \]e are exchanging lines up and down
\[space and \]space are adding blank lines up and down
