#!/usr/bin/env fish

set scriptid (basename (status --current-filename))

if test "Darwin" = (uname)
    echo "[$scriptid] Changing: increase the window resize speed"
    defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

    echo "[$scriptid] Disabling: smart quotes and dashes"
    defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
    defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

    echo "[$scriptid] Disabling: auto-correct"
    defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

    echo "[$scriptid] Disabling: prompt launch app"
    defaults write com.apple.LaunchServices LSQuarantine -bool false
end