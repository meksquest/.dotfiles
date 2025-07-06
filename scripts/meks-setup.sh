#!/bin/sh

echo "Starting system setup"

## Prep system setup script
_log 🐙 "Start: clone meksquest/.dotfiles"
git clone https://github.com/meksquest/.dotfiles.git "$HOME/.dotfiles/"
_log 🐙 "End: clone meksquest/.dotfiles"

## mac specific setup

_log 🍏 "Start: macos-defaults"
"$HOME/.dotfiles/scripts/macos-defaults.sh"
_log 🍏 "End: macos-defaults"

## Brew

# Install Homebrew
_log 🍺 "Start: install Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
_log 🍺 "End: install Homebrew"

# installs everything in $HOME/.dotfiles/.Brewfile
_log 🍻 "Start: brew bundle install"
/opt/homebrew/bin/brew bundle install --file "$HOME/.dotfiles/.Brewfile"
_log 🍻 "End: brew bundle install"

## Stow .dotfiles

_log  🎁 "Start: stow .dotfiles"
/opt/homebrew/bin/stow --dir "$HOME/.dotfiles/" --target "$HOME" .
_log  🎁 "End: stow .dotfiles"

## Make fish default shell
_log 🐟 "Start: fish default shell"
echo "/opt/homebrew/bin/fish" | sudo tee -a /etc/shells
cat /etc/shells
chsh -s /opt/homebrew/bin/fish
_log 🐟 "End: fish default shell"

glow <<EOF

## Next Steps

1. \`<Cmd>n\` to open new shell, verify default is 🐟 \`fish\`
2. Manually install wisprflow

_Good luck, intrepid hero!_
EOF

## helpers

_log() {
  echo -e "\e[35m\e[1m\e[100m  [MEKS]  $1  $2  "
}
