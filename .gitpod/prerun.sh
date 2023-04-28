#! /bin/bash

sudo apt-get remove firefox

# Prioritise Deb Firefox over Snap.
echo '
Package: *
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001
' | sudo tee /etc/apt/preferences.d/mozilla-firefox

sudo add-apt-repository ppa:mozillateam/ppa -y
sudo apt-get update
sudo apt-get install -y firefox firefox-esr
sudo sed -i 's/Name=Firefox Web Browser/Name=Firefox Web Browser (ESR)/' /usr/share/applications/firefox-esr.desktop

sudo wget -O /opt/firefox-nightly.tar.bz2 "https://download.mozilla.org/?product=firefox-nightly-latest&os=linux64&lang=en-US"
sudo tar -xjf /opt/firefox-nightly.tar.bz2 -C /opt
sudo mv /opt/firefox /opt/firefox-nightly
sudo ln -sf /opt/firefox-nightly/firefox /usr/local/bin/firefox-nightly

sudo wget -O /opt/firefox-developer.tar.bz2 "https://download.mozilla.org/?product=firefox-devedition-latest&os=linux64&lang=en-US"
sudo tar -xjf /opt/firefox-developer.tar.bz2 -C /opt
sudo mv /opt/firefox /opt/firefox-developer
sudo ln -sf /opt/firefox-developer/firefox /usr/local/bin/firefox-developer
