# 🛠️ Meks Dotfiles

Personal configuration files for macOS development environment, managed with
GNU Stow for easy deployment and maintenance.

## Table of Contents

- [Dependencies](#dependencies)
- [Setup](#setup)
- [How Stow Works](#how-stow-works)
- [Linking Dotfiles with Stow](#linking-dotfiles-with-stow)
  - [The Evolution: From Individual to Unified Approach](#the-evolution-from-individual-to-unified-approach)
  - [Current Approach (Recommended)](#current-approach-recommended)
  - [Legacy Approach](#legacy-approach)
- [Configurations Included](#configurations-included)

## Dependencies

- **[Homebrew](https://brew.sh/)** - Package manager for macOS
- **[GNU Stow](https://www.gnu.org/software/stow/)** - Symlink farm manager for organizing dotfiles

## Setup

**Install Homebrew** (if not already installed):

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

**Install Stow**:

```bash
brew install stow
```

**Clone the repository and Setup Symlink**:

```bash
cd ~
git clone https://github.com/MMcClure11/.dotfiles
cd .dotfiles
stow -t ~/.config .config
```

## How Stow Works

**GNU Stow** is a symlink farm manager that creates symbolic links from a
source directory to a target directory, maintaining the directory structure.
Here's how the magic happens:

### The Linking Process

When you run ```stow -t ~/.config .config```, Stow:

1. **Analyzes the source structure** in ```.dotfiles/.config/```
2. **Creates symbolic links** in the target directory ```~/.config/```
3. **Preserves directory hierarchy** exactly as it exists in the source
4. **Manages conflicts** by checking for existing files/directories

**Example transformation:**
```
Before:
~/.dotfiles/.config/nvim/init.lua

After stow:
~/.config/nvim/init.lua → ~/.dotfiles/.config/nvim/init.lua
```

For more advanced usage and options like ```--ignore=regexp```, see the [GNU Stow manual](https://www.gnu.org/software/stow/manual/html_node/Invoking-Stow.html). 

### Configuration Discovery: The XDG Standard

**Most modern applications follow the XDG Base Directory Specification**, which
defines standard locations for user-specific files:

- **```~/.config/```** - User configuration files
- **```~/.local/share/```** - User data files  
- **```~/.cache/```** - User cache files

### How Applications Find Your Configs

When you launch an application like **Neovim**, here's what happens:

1. **Neovim starts up** and needs to find its configuration
2. **Checks XDG_CONFIG_HOME** environment variable (defaults to ```~/.config```)
3. **Looks for ```~/.config/nvim/```** directory
4. **Loads configuration files** from that directory (like ```init.lua```)

**The symlink is transparent** - Neovim doesn't know or care that
```~/.config/nvim/``` is actually a symbolic link pointing to
```~/.dotfiles/.config/nvim/```. It just follows the link and loads the
configuration.

### Why This Works So Well

- **Centralized management**: All your configs live in one git repository
- **Transparent to applications**: Programs find configs exactly where they expect them
- **Easy updates**: Edit files in your dotfiles repo, changes appear immediately
- **Version control**: Track configuration changes with git
- **Portability**: Clone and stow on any new machine

## Linking Dotfiles with Stow

### The Evolution: From Individual to Unified Approach

This dotfiles repository has evolved in its organization and deployment
strategy. Understanding both approaches helps explain the current structure and
why we made the change.

### Current Approach (Recommended)

**The unified ```.config``` approach** simplifies management by organizing all
configurations under a single directory structure that mirrors the standard
```~/.config``` layout.

```bash
stow -t ~/.config .config
```

**How it works:**
- All application configs are organized under ```.dotfiles/.config/```
- A single stow command links the entire ```.config``` directory
- Creates symlinks like: ```~/.config/nvim``` → ```~/.dotfiles/.config/nvim```
- Maintains clean separation while reducing command complexity

**Directory structure:**
```
~/.dotfiles/
└── .config/
    ├── bat/
    ├── fish/
    ├── git/
    ├── kitty/
    ├── nvim/
    ├── meks_nvim/
    └── starship/
```

### Legacy Approach

**The individual stow approach** required separate stow commands for each application:

```bash
stow nvim
stow fish
stow bat
# ... and so on for each config
```

**Why we switched:**
- **Reduced complexity**: One command instead of multiple
- **Better organization**: Follows XDG Base Directory specification
- **Easier maintenance**: Adding new configs doesn't require additional stow commands
- **Cleaner structure**: All configs live under the standard ```~/.config``` path

The old approach worked by having individual directories at the root level
(like ```nvim/```, ```fish/```) that would be stowed directly to the home
directory, but the new approach provides better organization and follows modern
configuration standards.

## Configurations Included

- **bat** - Cat clone with syntax highlighting 
- **fish** - Friendly interactive shell 
- **git** - Version control configuration 
- **kitty** - GPU-accelerated terminal emulator 
- **starship** - Cross-shell prompt 
- **nvim** - Neovim configuration 
- **meks_nvim** - Custom Neovim setup 

---

*Happy configuring! 🚀*

## Managing the`.Brewfile` with `glow` as an example

```shell
brew bundle add --global glow
cat ~/.Brewfile | rg glow
brew bundle install --global
```

## Quickstart on a new machine

Required to be able to use git commands. Takes ~10 minutes.

```shell
xcode-select --install
```

Do this. You got it.
```shell
/bin/sh -c "$(curl https://raw.githubusercontent.com/meksquest/.dotfiles/refs/heads/main/scripts/meks-setup.sh)"
```
