#!/usr/bin/env fish

set scriptid (basename (status --current-filename))
set packer_dir $HOME/.local/share/nvim/site/pack/packer/start/packer.nvim

if not test -d $packer_dir
    echo "[$scriptid] Cloning to: '$packer_dir'"
    git clone --depth 1 https://github.com/wbthomason/packer.nvim $packer_dir
end

abbr -a vim 'nvim'
echo "[$scriptid] Running: 'PackerSync'"
nvim --headless "+PackerSync" "+quit!"