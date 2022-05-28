#!/usr/bin/env fish

set system_type (uname -s)
set starship (which starship)
if ! test $starship
  if test "$system_type" = "Darwin"
    brew install starship
    set starship (which starship)
  end
end

echo "$starship init fish | source" > "$HOME/.config/fish/conf.d/starship.fish" 
