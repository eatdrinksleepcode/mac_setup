# This file is copied from the setup repo and sourced by .zshrc
# Installers will sometimes write to .zshrc, so we don't want to overwrite that during setup

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# ZSH wants the group owner for completions to only have read access; but I want all brew users to be able to manage brew
ZSH_DISABLE_COMPFIX="true"

ZSH_THEME="powerlevel10k/powerlevel10k"

DEFAULT_USER="$(whoami)"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

MONO_DIR=/Library/Frameworks/Mono.framework/Versions

mvm() {
  if [ -z "$1" ]
  then
    ls -H $MONO_DIR
  elif [ ! -e $MONO_DIR/$1 ]
  then
    echo "Version $1 does not exist"
    ls -H $MONO_DIR
    return
  else
    sudo rm -f $MONO_DIR/Current
    sudo ln -s $MONO_DIR/$1 $MONO_DIR/Current
  fi
  mono --version
}

clean_dotnet() {
  (find . -name bin -type d | xargs -I {} rm -r {}) && (find . -name obj -type d | xargs -I {} rm -r {})
}
