#!/usr/bin/env fish

set scriptid (basename (status --current-filename))
set hc_dir $HOME/code/github.com/hashicorp
set atlas_dir $hc_dir/atlas
set atlas_frontend_dir $atlas_dir/frontend/atlas
set postgres_dir /opt/homebrew/opt/postgresql@12
set local_ejson_file $atlas_dir/tmp/1309dd9c7d6af21c747e615cb192ae9eaef8092c79bd3ddf8c59b89141baef08

if not test -d $hc_dir
    mkdir -p $hc_dir
end

if not test -d $atlas_dir
    echo "[$scriptid] Cloning: '$atlas_dir'"
    git clone git@github.com:hashicorp/atlas.git $atlas_dir
    if test $status
        echo "[$scriptid] Failed, skipping:  'git clone git@github.com:hashicorp/atlas.git'"
        return        
    end
end

set TMP_BREWFILE /tmp/Brewfile
cp $atlas_dir/Brewfile $TMP_BREWFILE
for exclude in yarn nvm chromium
    sed "/$exclude/d" $TMP_BREWFILE > $TMP_BREWFILE
end
echo "[$scriptid] Running: 'brew bundle'"
brew bundle --file=$TMP_BREWFILE
rm $TMP_BREWFILE

if not type psql &> /dev/null
    echo "[$scriptid] Adding to fish_user_path: '$postgres_dir/bin'"
    fish_add_path $postgres_dir/bin    
end

cd $atlas_dir
echo "[$scriptid] Installing: 'bundler'"
gem install bundler:(awk '/BUNDLED WITH/{ getline; print }' Gemfile.lock | tr -d ' ')
asdf reshim ruby

if not test -f $local_ejson_file
    echo "[$scriptid] Loading: '$local_ejson_file'"
    # FIXME: decouple OP
    op document get 'TFE LOCAL EJSON' --output $local_ejson_file
    echo "[$scriptid] Loading: 'TFE sidekiq-pro license'"
    bundle config gems.contribsys.com (op read 'op://Terraform Enterprise/TFE sidekiq-pro license/license')
end

echo "[$scriptid] Running: 'bundle'"
set -gx LDFLAGS "-L$postgres_dir/lib"
set -gx CPPFLAGS "-I$postgres_dir/include"
bundle

psql -lqt | cut -d \| -f 1 | grep -qw $USER
if test $status -ne 0
    echo "[$scriptid] Running: 'create db'"
    createdb $USER
    psql -c 'CREATE ROLE hashicorp WITH SUPERUSER LOGIN;'
    echo "[$scriptid] Running: 'bundle exec rake db:setup'"
    bundle exec rake db:setup
end

if not test -d $hc_dir/ember-mixed-tag-input
    echo "[$scriptid] Caching: 'github credentials'"
    # FIXME: decouple OP
    set gh_user (op read "op://Developer/GitHub/username")
    set gh_token (op read "op://Developer/GitHub/GITHUB_TOKEN")
    git clone https://$gh_user:$gh_token@github.com/hashicorp/ember-mixed-tag-input
end


echo "[$scriptid] Running: 'yarn install'"
cd $atlas_frontend_dir
npx yarn install

cd $atlas_dir
tfcdev stack build

abbr -a toa "cd $atlas_dir"
abbr -a toab "cd $atlas_frontend_dir; npx yarn build"
abbr -a toaf "cd $atlas_frontend_dir"
abbr -a ts "cd $atlas_dir; and tfcdev stack"
abbr -a tsc "cd $atlas_dir; and tfcdev stack console"
abbr -a trc "cd $atlas_dir; and tfcdev stack console bundle exec rails console"
abbr -a tbb "cd $atlas_dir; and tfcdev stack console bundle exec byebug -R 9001"