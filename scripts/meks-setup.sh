#!/bin/sh

echo "Starting system setup"

# mac specific setup
echo "Start: macos-defaults"
"$HOME/.dotfiles/scripts/macos-defaults.sh"

## Brewfile

# Install Homebrew
echo "Intall Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# link Brewfile to home directory
ln -s "$HOME/.dotfiles/.Brewfile" "$HOME/.Brewfile"

# installs everything in $HOME/.Brewfile
echo: "brew bundle install"
/opt/homebrew/bin/brew bundle install --global

echo "meks system setup complete"
