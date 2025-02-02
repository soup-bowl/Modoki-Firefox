#! /bin/bash

create_desktop_entry() {
	local version="$1"
	local path="$2"

	cat << EOF > "${path}/${version}.desktop"
[Desktop Entry]
Version=1.0
Name=${version}
GenericName=Web Browser
Exec=/opt/${version}/firefox -P ${version} %u
Icon=/opt/${version}/browser/chrome/icons/default/default128.png
Terminal=false
Type=Application
MimeType=text/html;text/xml;application/xhtml+xml;application/vnd.mozilla.xul+xml;text/mml;x-scheme-handler/http;x-scheme-handler/https;
StartupNotify=true
Categories=Network;WebBrowser;
Keywords=web;browser;internet;
EOF
}

create_user_settings() {
	local path="$1"

	cat << EOF > "${path}/user.js"
// Used by Gitpod or a dev env to setup Firefox for UserStyle debugging.
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
user_pref("browser.compactmode.show", true);
user_pref("browser.toolbars.bookmarks.visibility", "always");
user_pref("devtools.debugger.remote-enabled", true);
user_pref("devtools.chrome.enabled", true);
user_pref("browser.uidensity", 1);
user_pref("browser.tabs.inTitlebar", 0);
EOF
}

OP_PATH="${1:-$PWD}"

mkdir -p $HOME/.local/share/applications
mkdir -p $HOME/Desktop

# For Fluxbox
FLUXBOX_MENU="$HOME/.fluxbox/menu"
if [[ -f "$FLUXBOX_MENU" ]]; then
	echo "Fluxbox detected - prepping menu edits."
	TMPFLUXMENU="/tmp/ff_fluxmenu"
	> "$TMPFLUXMENU"
	echo "    [submenu] (Firefox Variants) {}" >> "$TMPFLUXMENU"
fi

# In case a prior installation has failed.
sudo rm -rf /opt/firefox

declare -A firefox_versions=(
	["firefox-regular"]="firefox-latest"
	["firefox-esr"]="firefox-esr-latest"
	["firefox-nightly"]="firefox-nightly-latest"
	["firefox-developer"]="firefox-devedition-latest"
)

for version in "${!firefox_versions[@]}"; do
	product=${firefox_versions[$version]}
	existed=0

	echo ""
	echo "🦊 Installing: ${version}"
	echo "---------------------------------------"

	if [ -d "/opt/${version}" ]; then
		existed=1
		echo "ℹ️  Detected existing install, reinstalling..."
		echo "> sudo rm -r \"/opt/${version}\""
		sudo rm -r "/opt/${version}"
	fi

	if [ ! -f "/opt/${version}.tar.bz2" ]; then
		echo "> wget -q -O \"/opt/${version}.tar.bz2\" \"https://download.mozilla.org/?product=${product}&os=linux64&lang=en-US\""
		sudo wget -q -O "/opt/${version}.tar.bz2" "https://download.mozilla.org/?product=${product}&os=linux64&lang=en-US"
	else
		echo "ℹ️  ${version} has already been downloaded. Skipping..."
	fi

	echo "> sudo tar -xjf \"/opt/${version}.tar.bz2\" -C /opt"
	sudo tar -xjf "/opt/${version}.tar.bz2" -C /opt

	echo "> sudo mv /opt/firefox \"/opt/${version}\""
	sudo mv /opt/firefox "/opt/${version}"

	if [ $existed -eq 0 ]; then
		echo "> ln -sf \"/opt/${version}/firefox\" \"/usr/local/bin/${version}\""
		sudo ln -sf "/opt/${version}/firefox" "/usr/local/bin/${version}"

	
		echo "> /opt/${version}/firefox -CreateProfile $version"
		/opt/${version}/firefox -CreateProfile $version
		exit_status=$?

		if [ $exit_status -eq 0 ]; then
			DIR="$(find $HOME/.mozilla/firefox -maxdepth 1 -type d -name "*.${version}")"

			create_user_settings $DIR

			echo "> ln -sf \"${OP_PATH}/IE6/chrome\" \"${DIR}/chrome\""
			ln -sf "${OP_PATH}/IE6/chrome" "${DIR}/chrome"

			# For Fluxbox
			if [[ -f "$FLUXBOX_MENU" ]]; then
				echo "        [exec] ($version) {/opt/${version}/firefox -P ${version}}" >> "$TMPFLUXMENU"
			fi

			create_desktop_entry $version $HOME/Desktop
			sudo chmod +x $HOME/Desktop/${version}.desktop
			cp $HOME/Desktop/${version}.desktop $HOME/.local/share/applications/${version}.desktop
		else
			echo "❌ A problem occurred during profile creation. Skipping ${version}..."
		fi
	else
		echo "ℹ️  Since ${version} was already installed, let's skip the gubbins."
	fi
done

if [[ -f "$FLUXBOX_MENU" ]]; then
	echo "Editing fluxbox menu."
	echo "    [end]" >> "$TMPFLUXMENU"
	sed -i "/^\[begin\] (\s*Application Menu\s*)/r $TMPFLUXMENU" "$FLUXBOX_MENU"
	rm "$TMPFLUXMENU"
fi

echo ""
echo "🚀 Script has concluded - Firefox (of various variants) installed!"

