#!/usr/bin/env fish

set scriptid (basename (status --current-filename))

if type tfcdev &> /dev/null
    echo "[$scriptid] Updating: 'brew upgrade tfcdev'"
    brew upgrade tfcdev
else
    echo "[$scriptid] Brewing: 'tfcdev'"
    set -gx HOMEBREW_GITHUB_API_TOKEN $GITHUB_TOKEN
    if test -z $HOMEBREW_GITHUB_API_TOKEN
        echo "[$scriptid] Skipping: 'GITHUB_TOKEN' unavailable"
        return
    end
    brew tap hashicorp/internal git@github.com:hashicorp/homebrew-internal.git
    brew install hashicorp/internal/tfcdev
    echo "eval (tfcdev rc)" > $HOME/.config/fish/conf.d/tfcdev.fish
end

if test -n $QUAY_USERNAME -a $QUAY_PASSWORD
    echo "[$scriptid] Signing-in with: '\$QUAY_USERNAME:\$QUAY_PASSWORD'"
    echo "$QUAY_PASSWORD" | docker login quay.io/hashicorp -u "$QUAY_USERNAME" --password-stdin
end

tfcdev init