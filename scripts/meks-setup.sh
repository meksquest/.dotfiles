#!/bin/sh

echo "Starting system setup"

# mac specific setup
echo "Start: macos-defaults"
"$HOME/.dotfiles/scripts/macos-defaults.sh"

## Brewfile

# Install Homebrew
echo "Intall Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# installs everything in $HOME/.dotfiles/.Brewfile
echo "brew bundle install"
/opt/homebrew/bin/brew bundle install --global --file "$HOME/.dotfiles/.Brewfile"

echo "Stow the .dotfiles"
/opt/homebrew/bin/stow --dir "$HOME/.dotfiles/" --target "$HOME" .

echo "meks system setup complete"
