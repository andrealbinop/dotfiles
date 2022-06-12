#!/usr/bin/env fish

set scriptid (basename (status --current-filename))
set tpm_dir $HOME/.config/tmux/plugins/tpm

if ! type -q tmux
    echo "[$scriptid] Skipping: 'tmux' unavailable"
    return    
end

if not test -d $tpm_dir
    echo "[$scriptid] Cloning to: '$tpm_dir'"
    git clone https://github.com/tmux-plugins/tpm $tpm_dir
end