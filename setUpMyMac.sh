#!/bin/bash

set -euo pipefail

targetUser=${1:-$(whoami)}

if [ $(which brew) ]; then
  echo "Skipping installation of Homebrew (already installed)"
else
  ./homebrew-install.sh
fi

./homebrew-setup.sh "${targetUser}"

if [ "${targetUser}" != "$(whoami)" ]; then
  echo "Switch to '${targetUser}' and run setup again."
  exit 0
fi

brew bundle

if [ ! -e ~/.oh-my-zsh ]; then
  ./oh-my-zsh-install.sh || exit
else
  echo "Skipping installation of Oh-My-Zsh (already installed)"
fi
if [ ! -e ~/.oh-my-zsh/custom/themes/powerlevel9k ]; then
  git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
else
  echo "Skipping installation of PowerLevel9K theme (already installed)"
fi
#Set theme:
#ZSH_THEME="powerlevel9k/powerlevel9k"
if [ -e ~/Library/Fonts/"Droid Sans Mono for Powerline Nerd Font Complete.otf" ]; then
  echo "Skipping installation of Powerline font (already installed)"
else
  curl -fLo ~/Library/Fonts/"Droid Sans Mono for Powerline Nerd Font Complete.otf" https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete%20Mono.otf
fi
cp .zshrc ~/.zshrc
cp -f com.googlecode.iterm2.plist ~/Library/Preferences

cp .gitconfig ~/.gitconfig

