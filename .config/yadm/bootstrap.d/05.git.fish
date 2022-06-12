#!/usr/bin/env fish

function setup_git_config
	set config_name $argv[1]
	if test -z (git config --global $config_name)
		set config_value (read -P "Want to set '$config_name' (leave blank to skip)? ")
		if test -n $config_value
			git config --global $config_name config_value
		end
	end
end

switch (uname)
case Darwin
	git config --global credential.helper osxkeychain
case '*'
	git config --global credential.helper cache
end

if type nvim --version &> /dev/null
	git config --global core.editor nvim
end

git config --global url.ssh://git@github.com/.insteadOf https://github.com/
git config --global init.defaultBranch main
git config --global gpg.program gpg
git config --global commit.gpgsign true

setup_git_config 'user.name'
setup_git_config 'user.email'

abbr -a ga 'git add'
abbr -a gc 'git commit'
abbr -a gca 'git commit --amend'
abbr -a gd 'tig HEAD (git_main_branch)'
abbr -a gco 'git checkout'
abbr -a gl 'git pull --prune'
abbr -a grc 'git rebase --continue'
abbr -a gp 'git push'
abbr -a gs 'git status -sb'
