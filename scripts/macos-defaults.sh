#!/bin/sh

# https://macos-defaults.com
# you can see your settings via `defaults read com.apple.dock "autohide"`

defaults write com.apple.dock "autohide" -bool "true"
defaults write com.apple.dock "tilesize" -int "49"
defaults write com.apple.dock "autohide-time-modifier" -float "0.2"
defaults write com.apple.dock "mineffect" -string "scale"
defaults write com.apple.dock "static-only" -bool "true"
# TODO: Not sure if this is working, came from amethyst docs
defaults write com.apple.dock "workspaces-auto-swoosh" -bool "false"
defaults write NSGlobalDomain "InitialKeyRepeat" -float "15"
defaults write NSGlobalDomain "KeyRepeat" -float "2"

killall Dock
