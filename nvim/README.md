# NeoVim notes

My notes to creating vim / tmux configuration that will fit my own needs.

## Notes

### Vimspector

Make sure to disable F11 to show desktop in MacOS and invert F keys to their
 standard roles in case you want to use **HUMAN** bindings for Vimspector.

For MacOS if you want to use F keys to debug (and not have to hold function):
Go to System Preferences -> Keyboard -> Keyboard and check the box to invert
 the function key behavior / to choose standard function key behavior.
Go to System Preferences -> Keyboard -> Shortcuts and uncheck the "Show Desktop
 F11" option inside one of the submenus (Mission Control).

When **HUMAN** keybindings are enabled Vimspector these are the keybinds
[Human keybinds](https://github.com/puremourning/vimspector#human-mode)

Default configurations per filetype are allowed
 ([link](https://puremourning.github.io/vimspector/configuration.html#specifying-a-default-configuration))
 but they can't cover all cases because we need to define app run command
 per project. Repo-local `.vimspector.json` file always takes presedence over
 more global files.

 There is also a great git repo that contains a lot of very useful examples
 for many different programming languages that you can reference:
 ([link](https://github.com/puremourning/vimspector))

**TODO**: auto generate vimspector.json files through cookiecutter maybe?

## Vim unimpared bindings

[Bindings](https://github.com/tpope/vim-unimpaired/blob/master/doc/unimpaired.txt)

\[e and \]e are exchanging lines up and down
\[space and \]space are adding blank lines up and down
