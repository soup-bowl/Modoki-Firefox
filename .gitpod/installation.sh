#! /bin/bash

timeout 5 firefox
timeout 5 firefox-esr
timeout 5 firefox-nightly
timeout 5 firefox-developer

MM_FFDIR="$(find ~/.mozilla/firefox -maxdepth 1 -type d -name '*.default-release')"
MM_FFNDIR="$(find ~/.mozilla/firefox -maxdepth 1 -type d -name '*.default-nightly')"
MM_FFADIR="$(find ~/.mozilla/firefox -maxdepth 1 -type d -name '*.dev-edition-default')"
MM_FFEDIR="$(find ~/.mozilla/firefox-esr -maxdepth 1 -type d -name '*.default-esr*')"

for DIR in "${MM_FFDIR}" "${MM_FFNDIR}" "${MM_FFADIR}" "${MM_FFEDIR}"; do
	cp .gitpod/user.js "${DIR}"
	ln -sf "${GITPOD_REPO_ROOTS}/IE6/chrome" "${DIR}/chrome"
done

mkdir -p ~/.local/share/applications
cp .gitpod/firefox-nightly.desktop ~/.local/share/applications/firefox-nightly.desktop
cp .gitpod/firefox-aurora.desktop ~/.local/share/applications/firefox-aurora.desktop

echo ""
echo "You can now run all versions of Firefox with the installed theme available, and developer options enabled."
