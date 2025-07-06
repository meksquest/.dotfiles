#!/bin/sh

## helpers

_log() {
  printf "\e[96m\e[1m\e[100m  [MEKS]  $1  $2  \e[0m\n"
}

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
mkdir -p "$HOME/.config/"
/opt/homebrew/bin/stow --dir "$HOME/.dotfiles/" --target "$HOME" .
_log  🎁 "End: stow .dotfiles"

## Make fish default shell
_log 🐟 "Start: fish default shell"
echo "/opt/homebrew/bin/fish" | sudo tee -a /etc/shells
cat /etc/shells
chsh -s /opt/homebrew/bin/fish
_log 🐟 "End: fish default shell"

## Update .dotfiles remote repository to ssh
_log 🐙 "Start: switch .dotfiles remote repository to ssh"
git remote -v
git remote remove origin
git remote add origin git@github.com:meksquest/.dotfiles.git
git remote -v
git push --set-upstream origin main
_log 🐙 "End: switch .dotfiles remote repository to ssh"

/opt/homebrew/bin/glow <<EOF

## Next Steps

1. \`<Cmd>n\` to open new shell, verify default is 🐟 \`fish\`
2. GitHub conveniences
    - Create an ssh key on the new machine, add it to github
    \`\`\`shell
    # generate key
    ssh-keygen
    # look for the public key (see above output)
    ls -la ~/.ssh
    # copy the public key
    cat ~/.ssh/id_ed25519.pub | pbcopy
    \`\`\`
    - Navigate to https://github.com/settings/keys, add New SSH Key.
3. Manually install wisprflow

_Good luck, intrepid hero!_
EOF
