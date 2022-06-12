#!/usr/bin/env fish

set scriptid (basename (status --current-filename))
set alacritty_dir "$HOME/.config/alacritty"

if not test -f $alacritty_dir/dracula.yml
	echo "[$scriptid] Downloading to: '$alacritty_dir/dracula.yml'"
	curl -sL https://raw.githubusercontent.com/dracula/alacritty/master/dracula.yml -o $alacritty_dir/dracula.yml
end