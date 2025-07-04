#!/bin/sh

echo "Starting system setup"

# mac specific setup
"$HOME/.dotfiles/scripts/macos-defaults.sh"

## Brewfile

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# link Brewfile to home directory
ln -s "$HOME/.dotfiles/.Brewfile" "$HOME/.Brewfile"
# installs everything in $HOME/.Brewfile
brew bundle install --global

echo "meks system setup complete"
