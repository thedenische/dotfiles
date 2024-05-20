#!/usr/bin/env bash

if [[ $(command -v brew) == "" ]]; then
    echo "Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    Echo "Setuping Homebrew environment"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
    echo "Homebrew has installed successfully"
else
    echo "Updating Homebrew"
    # Make sure we’re using the latest Homebrew.
    brew update
    # Upgrade any already-installed formulae.
    brew upgrade
fi

# Dotfiles manager
brew install stow

# Terminal
brew install --cask iterm2
brew install lsd
brew install ripgrep


brew install tmux
sudo ln -s /usr/local/bin/tmux /usr/bin/tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Messengers
brew install --cask telegram-desktop
brew install --cask whatsapp
brew install --cask slack
brew install --cask zoom

# Browsers
brew install --cask chromium

# Programming languages
brew install openjdk@17
brew install go
brew install node
brew install maven
brew install gradle

# IDE, text editors
brew install neovim
brew install --cask intellij-idea
brew install --cask visual-studio-code

# Virtualization and cloud tools
brew install --cask docker
brew install kubectl
brew install helm
brew install helmfile
brew install awscli
brew install k9s

# Tools
brew install --cask dropbox
brew install --cask keepassxc

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" &
brew install powerlevel10k
echo "source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme" >>~/.zshrc
wait

