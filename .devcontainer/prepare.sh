#! /bin/bash

sudo apt-get update
sudo apt-get install -y software-properties-common

sudo apt-get remove -y firefox

# Prioritise Deb Firefox over Snap.
echo '
Package: *
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001
' | sudo tee /etc/apt/preferences.d/mozilla-firefox

sudo add-apt-repository ppa:mozillateam/ppa -y
sudo apt-get update
sudo apt-get install -y firefox firefox-esr

sudo wget -O /opt/firefox-nightly.tar.bz2 "https://download.mozilla.org/?product=firefox-nightly-latest&os=linux64&lang=en-US"
sudo tar -xjf /opt/firefox-nightly.tar.bz2 -C /opt
sudo mv /opt/firefox /opt/firefox-nightly
sudo ln -sf /opt/firefox-nightly/firefox /usr/local/bin/firefox-nightly

sudo wget -O /opt/firefox-developer.tar.bz2 "https://download.mozilla.org/?product=firefox-devedition-latest&os=linux64&lang=en-US"
sudo tar -xjf /opt/firefox-developer.tar.bz2 -C /opt
sudo mv /opt/firefox /opt/firefox-developer
sudo ln -sf /opt/firefox-developer/firefox /usr/local/bin/firefox-developer

timeout 5 firefox
timeout 5 firefox-esr
timeout 5 firefox-nightly
timeout 5 firefox-developer

MM_FFDIR="$(find ~/.mozilla/firefox -maxdepth 1 -type d -name '*.default-release')"
MM_FFNDIR="$(find ~/.mozilla/firefox -maxdepth 1 -type d -name '*.default-nightly')"
MM_FFADIR="$(find ~/.mozilla/firefox -maxdepth 1 -type d -name '*.dev-edition-default')"
MM_FFEDIR="$(find ~/.mozilla/firefox-esr -maxdepth 1 -type d -name '*.default-esr*')"

for DIR in "${MM_FFDIR}" "${MM_FFNDIR}" "${MM_FFADIR}" "${MM_FFEDIR}"; do
	cp "${CODESPACE_VSCODE_FOLDER}/.devcontainer/user.js" "${DIR}"
	ln -sf "${CODESPACE_VSCODE_FOLDER}/IE6/chrome" "${DIR}/chrome"
done

sed -i '/\[end\]/i [exec] (Firefox) {/usr/bin/firefox}' ~/.fluxbox/menu
sed -i '/\[end\]/i [exec] (Firefox ESR) {/usr/bin/firefox-esr}' ~/.fluxbox/menu
sed -i '/\[end\]/i [exec] (Firefox Developer) {/usr/local/bin/firefox-developer}' ~/.fluxbox/menu
sed -i '/\[end\]/i [exec] (Firefox Nightly) {/usr/local/bin/firefox-nightly}' ~/.fluxbox/menu
