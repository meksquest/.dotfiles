#!/bin/sh

echo "Starting system setup"

## mac specific setup

log 🍏 "Start: macos-defaults"
"$HOME/.dotfiles/scripts/macos-defaults.sh"
log 🍏 "End: macos-defaults"

## Brew

# Install Homebrew
log 🍺 "Start: install Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
log 🍺 "End: install Homebrew"

# installs everything in $HOME/.dotfiles/.Brewfile
log 🍻 "Start: brew bundle install"
/opt/homebrew/bin/brew bundle install --file "$HOME/.dotfiles/.Brewfile"
log 🍻 "End: brew bundle install"

## Stow .dotfiles

log  🎁 "Start: stow .dotfiles"
/opt/homebrew/bin/stow --dir "$HOME/.dotfiles/" --target "$HOME" .
log  🎁 "End: stow .dotfiles"

## Make fish default shell
log 🐟 "Start: fish default shell"
echo "/opt/homebrew/bin/fish" | sudo tee -a /etc/shells
cat /etc/shells
chsh -s /opt/homebrew/bin/fish
log 🐟 "End: fish default shell"

glow <<EOF

## Next Steps

1. \`<Cmd>n\` to open new shell, verify default is 🐟 \`fish\`
2. Manually install wisprflow

_Good luck, intrepid hero!_
EOF

## helpers

log() {
  echo -e "\e[35m\e[1m\e[100m  [MEKS]  $1  $2  "
}
