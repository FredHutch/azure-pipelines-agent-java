#!/bin/bash
################################################################################
##  File:  basic.sh
##  Team:  CI-Platform
##  Desc:  Installs basic command line utilities and dev packages
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh
source $HELPER_SCRIPTS/apt.sh

set -e

# Install basic command-line utilities
set -e

echo "Install curl"
apt-get install -y --no-install-recommends curl

echo "Install dnsutils"
apt-get install -y --no-install-recommends dnsutils

echo "Install file"
apt-get install -y --no-install-recommends file

echo "Install iproute2"
apt-get install -y --no-install-recommends iproute2

echo "Install iputils-ping"
apt-get install -y --no-install-recommends iputils-ping

echo "Install jq"
apt-get install -y --no-install-recommends jq

echo "Install libcurl3"
apt-get install -y --no-install-recommends libcurl3

echo "Install locales"
apt-get install -y --no-install-recommends locales

echo "Install openssh-client"
apt-get install -y --no-install-recommends openssh-client

echo "Install rsync"
apt-get install -y --no-install-recommends rsync

echo "Install sudo"
apt-get install -y --no-install-recommends sudo

echo "Install time"
apt-get install -y --no-install-recommends time

echo "Install unzip"
apt-get install -y --no-install-recommends unzip

echo "Install wget"
apt-get install -y --no-install-recommends wget

echo "Install zip"
apt-get install -y --no-install-recommends zip

echo "Install curl"
apt-get install -y --no-install-recommends curl

echo "Install tree"
apt-get install -y --no-install-recommends tree

echo "Install git"
apt-get install -y --no-install-recommends git

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
for cmd in curl file ssh rsync sudo time unzip wget zip tree git; do
    if ! command -v $cmd; then
        echo "$cmd was not installed"
        exit 1
    fi
done

# Document what was added to the image
echo "Lastly, documenting what we added to the metadata file"
DocumentInstalledItem "Basic CLI:"
DocumentInstalledItemIndent "git"
DocumentInstalledItemIndent "curl"
DocumentInstalledItemIndent "dnsutils"
DocumentInstalledItemIndent "file"
DocumentInstalledItemIndent "iproute2"
DocumentInstalledItemIndent "iputils-ping"
DocumentInstalledItemIndent "locales"
DocumentInstalledItemIndent "openssh-client"
DocumentInstalledItemIndent "rsync"
DocumentInstalledItemIndent "sudo"
DocumentInstalledItemIndent "time"
DocumentInstalledItemIndent "unzip"
DocumentInstalledItemIndent "wget"
DocumentInstalledItemIndent "zip"
DocumentInstalledItemIndent "tzdata"
DocumentInstalledItemIndent "tree"
DocumentInstalledItemIndent "git"
