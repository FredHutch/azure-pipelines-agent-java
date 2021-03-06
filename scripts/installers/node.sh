#!/bin/bash
################################################################################
##  File:  nodejs.sh
##  Team:  CI-Platform
##  Desc:  Installs Node.js LTS and related tooling (Gulp)
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

# Install LTS Node.js and related build tools
curl -sL https://git.io/n-install | bash -s -- -ny -
~/n/bin/n lts
npm install -g n typescript
npm install -g npm
rm -rf ~/n

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
for cmd in node; do
    if ! command -v $cmd; then
        echo "$cmd was not installed"
        exit 1
    fi
done

# Document what was added to the image
echo "Lastly, documenting what we added to the metadata file"
DocumentInstalledItem "Node.js ($(node --version))"
DocumentInstalledItem "n ($(n --version))"
DocumentInstalledItem "TypeScript ($(tsc --version))"
