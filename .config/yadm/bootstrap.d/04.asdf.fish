#!/usr/bin/env fish

function install_plugin
    set plugin_name $argv[1]
    set plugin_path $argv[2]

    if contains $plugin_name (asdf plugin list)
        asdf plugin update $plugin_name
    else
        asdf plugin add $plugin_name $plugin_path
    end
end

# https://github.com/rbenv/ruby-build/wiki#macos
set -Ux RUBY_CONFIGURE_OPTS "--with-openssl-dir=$(brew --prefix openssl@1.1)"
install_plugin ruby https://github.com/asdf-vm/asdf-ruby.git
install_plugin nodejs https://github.com/asdf-vm/asdf-nodejs.git
install_plugin golang https://github.com/kennyp/asdf-golang.git
install_plugin java https://github.com/halcyon/asdf-java.git
asdf install
