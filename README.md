# Dotfiles

Personal dotfiles and automated setup script for configuring a new macOS development environment.

## Purpose

This repository provides an automated way to set up a complete macOS development environment using:

- **Brewfile** for package management (CLI tools and applications)
- **GNU Stow** for dotfile management and symlink creation
- **Shell script** for automated setup process

## Note

This repo reflects my personal development setup and preferences. It's made public to serve as an example for others creating their own dotfiles repositories.

### Assumptions

- Uses `~/workspace` as primary workspace directory
- Includes tools and applications I actively use in development
- Shell aliases and configurations are personalized
- Git configurations support multiple profiles (personal, work)

## What's Included

### Development Tools & CLI Utilities

- **Language Tools**: Go, Python (pyenv), Node.js tools
- **DevOps**: Docker, Kubernetes (kubectl, helm, k9s), AWS CLI, Vault
- **File Management**: bat, fd, ripgrep, fzf, yazi, superfile, ncdu
- **System Monitoring**: htop, btop, mtr
- **Network Tools**: httpie, nmap, iperf3
- **Version Control**: git-delta, git-lfs, lazygit

### Applications (via Homebrew Cask)

- **Development**: Kitty, IntelliJ IDEA, Sublime Text, Claude Code
- **Productivity**: Raycast, Hammerspoon, HiddenBar, Magnet
- **Communication**: Slack, Telegram
- **Utilities**: Enpass, Dropbox, Joplin

### Configuration Files (managed via Stow)

- **Zsh**: Custom configuration with modern shell enhancements
- **Tmux**: Vim-compatible key bindings, custom status bar, OS clipboard integration
- **Git**: Global configuration with multiple profile support
- **Karabiner**: Keyboard remapping (CAPS → Hyper key, layout fixes)
- **Hammerspoon**: Window management and automation
- **Yazi**: Modern file manager configuration
- **Various**: ideavim, superfile configurations

## Setup Process

The setup script (`setup.sh`) automates the entire installation:

1. **Homebrew Installation**: Installs Homebrew if not present
2. **Package Installation**: Uses `Brewfile` to install all CLI tools and applications via `brew bundle install`
3. **Dotfile Management**: Uses GNU Stow to create symlinks for configuration files
4. **Additional Setup**:
   - Installs Yazi plugins
   - Links Git profile configurations
   - Sets up workspace structure

## Usage

Clone the repository and run the setup script:

```bash
git clone git@github.com:asibin/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./setup.sh
```

The script will:

- Install/update Homebrew
- Install all packages from `Brewfile`
- Apply dotfiles using Stow for: zsh, tmux, karabiner, git, hammerspoon, yazi, ideavim, superfile
- Set up Yazi plugins
- Configure Git profiles (if private config files exist)

## Key Features

### Keyboard Customization (Karabiner)

- Remaps `§/±` key to backtick/tilde (useful for EU keyboards)
- Converts `CAPS LOCK` to Hyper key (⌘+⌃+⌥+⇧) for Hammerspoon shortcuts

### Git Multi-Profile Support

- Main `.gitconfig` with conditional includes
- Separate configs for different work environments
- Private configurations kept outside main dotfiles

## Known Issues

- Karabiner symlink occasionally gets overwritten by Karabiner application updates
- Some applications may require manual first-time setup after installation

## Contributing

This is a personal dotfiles repository, but feel free to fork and adapt it for your own needs. Issues and suggestions are welcome for improving the setup process.
