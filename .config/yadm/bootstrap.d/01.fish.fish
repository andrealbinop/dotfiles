#!/usr/bin/env fish

set system_type (uname -s)
set fish (which fish)

if not grep -q "$fish" /etc/shells
  echo "Adding fish to /etc/shells"
  sudo $fish -c "echo \"$fish\" >> /etc/shells"
end

if test "$SHELL" != "$fish"
  set -U fish_greeting
  sudo chsh -s $fish $(whoami) 
end

# add brew to path if coming from /home/linuxbrew
if test -d /home/linuxbrew
  echo -e "if test -d /home/linuxbrew\n  eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)\nend" > $HOME/.config/fish/conf.d/brew.fish
end
