#!/bin/bash
################################################################################
##  File:  chrome.sh
##  Desc:  Installs Google Chrome
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list
apt-get update \
apt-get install -y google-chrome-stable \
rm -rf /var/lib/apt/lists/*
echo "CHROME_BIN=/usr/bin/google-chrome" | tee -a /etc/environment


DocumentInstalledItem "chrome"