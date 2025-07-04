#!/bin/sh

echo "Updating macos config"
defaults write com.apple.dock "autohide" -bool "true"
defaults write com.apple.dock "tilesize" -int "49"
defaults write com.apple.dock "autohide-time-modifier" -float "0.2"
defaults write com.apple.dock "mineffect" -string "scale"
defaults write com.apple.dock "static-only" -bool "true"
# TODO: Not sure if this is working, came from amethyst docs
defaults write com.apple.dock "workspaces-auto-swoosh" -bool "false"

killall Dock
echo "Done updating macos config"
