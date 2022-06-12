#!/usr/bin/env fish

set scriptid (basename (status --current-filename))

# determine brew home
if test -d /home/linuxbrew
  set brew_home /home/linuxbrew
else if test -d /opt/homebrew
  set brew_home /opt/homebrew
end

eval ($brew_home/bin/brew shellenv)

set fish (which fish)

if not grep -q "$fish" /etc/shells
  echo "[$scriptid] Adding to '/etc/shells': '$fish'"
  sudo $fish -c "echo \"$fish\" >> /etc/shells"
end

if test "$SHELL" != "$fish"
  echo "[$scriptid] Changing default shell to: '$fish'"
  set -U fish_greeting
  sudo chsh -s $fish $(whoami) 
end

set conf_d $HOME/.config/fish/conf.d

if ! test -d $conf_d
  mkdir -p $conf_d
end

set brew_init $conf_d/brew.fish
if ! test -f $brew_init
  echo "[$scriptid] Creating: '$brew_init'"
  echo -e "if test -d $brew_home\n  eval ($brew_home/bin/brew shellenv)\nend" > $brew_init
end

if type -q fisher
  echo "[$scriptid] Updating: fisher"
  fish -c 'fisher update'
else
  echo "[$scriptid] Installing: fisher"
  curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
  fisher install dracula/fish
  fisher install joehillen/to-fish
  fisher install rstacruz/fish-asdf
  fisher install budimanjojo/tmux.fish
  fisher install jorgebucaran/fishtape
end

set gpg_init $conf_d/gpg.fish
if ! test -f $gpg_init
  echo "[$scriptid] Creating: '$gpg_init'"
  echo 'set -x GPG_TTY (tty)' > $gpg_init
end