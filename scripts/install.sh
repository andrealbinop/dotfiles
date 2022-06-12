#!/usr/bin/env bash

set -e

system_type=$(uname -s)

run_if_unavailable() {
  if ! type "${1}" > /dev/null; then
    eval "${2}"
  fi
}

xcode_unavailable() {
  xcode-select --install
  echo "Please rerun this script after XCode is installed"
  exit 0
}

if [ "$system_type" = "Darwin" ]; then
  run_if_unavailable 'python3' 'xcode_unavailable'
  run_if_unavailable 'brew' '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
  echo -e "if [ -d /home/linuxbrew ]; then\n  eval \$(/opt/homebrew/bin/brew shellenv)\nfi" >> $HOME/.zprofile
elif [ "$system_type" = "Linux" ]; then
  run_if_unavailable 'git' 'sudo apt-get update && sudo apt-get install -y build-essential procps curl file git'
	if [ ! -d '/home/linuxbrew' ]; then
    run_if_unavailable 'brew' '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
		echo -e "if [ -d /home/linuxbrew ]; then\n  eval \$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)\nfi" >> $HOME/.bashrc
  fi
	source $HOME/.bashrc
fi
run_if_unavailable 'yadm' 'brew install yadm'

yadm clone -f --bootstrap https://github.com/andrealbinop/dotfiles.git
