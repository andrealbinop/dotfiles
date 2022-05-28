#!/usr/bin/env fish

# moves pwd to another dir to avoid clashing with fish scripts in bootstrap.d dir
set current_dir (pwd)
cd /tmp
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
fisher install joehillen/to-fish
fisher install dracula/fish
