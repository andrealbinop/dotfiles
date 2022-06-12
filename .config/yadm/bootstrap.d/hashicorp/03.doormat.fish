#!/usr/bin/env fish

set scriptid (basename (status --current-filename))

if type doormat &> /dev/null
    echo "[$scriptid] Updating: 'brew upgrade doormat-cli'"
    brew upgrade doormat-cli
else
    echo "[$scriptid] Brewing: 'doormat-cli'"
    set -gx HOMEBREW_GITHUB_API_TOKEN $GITHUB_TOKEN
    if test -z $HOMEBREW_GITHUB_API_TOKEN
        echo "[$scriptid] Skipping: 'GITHUB_TOKEN' unavailable"
        return
    end
    if test "arm64" = (uname -m)
        # https://docs.prod.secops.hashicorp.services/doormat/cli/#macos-m1-laptops
        echo "[$scriptid] Installing: 'rosetta emulator'"
        softwareupdate --install-rosetta
    end
    brew tap hashicorp/security git@github.com:hashicorp/homebrew-security.git
    brew install hashicorp/security/doormat-cli    
end

doormat login