#!/bin/bash

set -euo pipefail

targetUser=${1:-$(whoami)}

if [ $(which brew) ]; then
  echo "Skipping installation of Homebrew (already installed)"
else
  echo "Installing Homebrew ..."
  ./homebrew-install.sh
  echo "Done installing Homebrew"
fi

./homebrew-setup.sh "${targetUser}"

if [ "${targetUser}" != "$(whoami)" ]; then
  echo "Switch to '${targetUser}' and run setup again."
  exit 0
fi

brew bundle

if [ ! -e ~/.oh-my-zsh ]; then
  echo "Installing Oh-My-Zsh ..."
  ./oh-my-zsh-install.sh || exit
  echo "Done installing Oh-My-Zsh"
else
  echo "Skipping installation of Oh-My-Zsh (already installed)"
fi
if [ ! -e ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k ]; then
  echo "Installing PowerLevel10K theme ..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
  echo "Done installing PowerLevel10K theme"
else
  echo "Skipping installation of PowerLevel10K theme (already installed)"
fi

if [ -e ~/Library/Fonts/"Droid Sans Mono for Powerline Nerd Font Complete.otf" ]; then
  echo "Skipping installation of Powerline font (already installed)"
else
  echo "Installing Powerline font ..."
  curl -fLo ~/Library/Fonts/"Droid Sans Mono for Powerline Nerd Font Complete.otf" https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete%20Mono.otf
  echo "Done installing Powerline font"
fi

echo "Ensuring .my.zsh is loaded in .zshrc ..."
cp .my.zsh ~/
cp .p10k.zsh ~/
(grep "\.my\.zsh" ~/.zshrc > /dev/null) || (echo "\n[[ ! -f ~/.my.zsh ]] || source ~/.my.zsh" >> ~/.zshrc)
echo "Done"

if [ -e ~/Library/Preferences/com.googlecode.iterm2.plist ]; then
  echo "Skipping installation of iTerm preferences since they already exist"
  echo "> To overwrite existing iTerm preferences, run ./iterm-prefs-install.sh"
else
  echo "Installing iTerm preferences ..."
  ./iterm-prefs-install.sh
  echo "Done installing iTerm preferences"
fi

cp .gitconfig ~/.gitconfig

