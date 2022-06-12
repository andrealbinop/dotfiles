#!/usr/bin/env fish

set scriptid (basename (status --current-filename))
set system_type (uname -s)
set starship (which starship)
if ! test $starship
    echo "[$scriptid] Installing: 'starship'"
    brew install starship
    set starship (which starship)
end

echo "$starship init fish | source" > "$HOME/.config/fish/conf.d/starship.fish" 
