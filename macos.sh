#!/usr/bin/env bash

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

# Keqboard: Use F1, F2, etc. keys as standart funnction keys
defaults write -g com.apple.keyboard.fnState -bool true

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Finder: show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# Dock: set the icon size of items to 40 pixels
defaults write com.apple.dock tilesize -int 50

# Dock: Do not display recent apps in the Dock
defaults write com.apple.dock show-recents -bool false

# Dock: Change minimize/maximize window effect
defaults write com.apple.dock mineffect -string "scale"

# Dock: Wipe all (default) app icons from the Dock
# This is only really useful when setting up a new Mac, or if you don’t use
# the Dock to launch apps.
defaults write com.apple.dock persistent-apps -array

# Dock: Remove the auto-hiding Dock delay
defaults write com.apple.dock autohide-delay -float 0
# Dock: Remove the animation when hiding/showing the Dock
defaults write com.apple.dock autohide-time-modifier -float 0

# Dock: Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Menu bar: Don't automatically hide and show menu bar
defaults write NSGlobalDomain _HIHideMenuBar -bool false
# Menu bar: Don't automatically hide and show menu bar in full screen
defaults write NSGlobalDomain AppleMenuBarVisibleInFullscreen -int 1

# Screenshots: path to save screenshots
defaults write com.apple.screencapture location ~/Pictures/screenshotes

# Kill affected applications
for app in "Dock" \
	"ControlStrip" \
	"Finder"; do
	killall "${app}" &> /dev/null
done
