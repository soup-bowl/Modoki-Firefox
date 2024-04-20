<h1 align="center">Modern Modoki</h1>

<p align="center">
 <a href="https://www.codefactor.io/repository/github/soup-bowl/modoki-firefox">
  <img src="https://www.codefactor.io/repository/github/soup-bowl/modoki-firefox/badge" alt="CodeFactor" />
 </a>
 <a href="https://gitpod.io/#https://github.com/soup-bowl/Modoki-Firefox">
  <img src="https://img.shields.io/badge/open%20in-Gitpod-orange?logo=gitpod&logoColor=white" />
 </a>
</p>

<p align="center">
 <img alt="Firefox screenshot running Modern Modoki" src="https://user-images.githubusercontent.com/11209477/192164979-31f7c725-87c4-4513-aaed-d2c52a17a9b6.png" />
</p>

This project aims to bring the Modern Modoki (or close in appearance) theme back to Firefox using the amazing Redmond Firefox theme base, via Firefox's remaining UserChrome interface.

> [!WARNING]  
> **Firefox 126** introduces a breaking change to the menu. I haven't located it yet, so **this theme will be functionally broken**. I recommend disabling it until it is located an fixed. The issue is tracked in [#29](https://github.com/soup-bowl/Modoki-Firefox/issues/29).

If you're using Pale Moon browser, Use **[Modoki Moon][mmm]** instead of this - a full fork of the original.

This theme pairs beautifully with the **[Chicago95 theme for XFCE][c95]**.

 ℹ️ If you want compact density, set `browser.compactmode.show` to `true`.

[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/soup-bowl/Modoki-Firefox)

## 🐞 Bugs & Limitations

* **Firefox 126^ - The URL bar menu will appear over the search bar, causing significant usibility issues** - tracked in [#29](https://github.com/soup-bowl/Modoki-Firefox/issues/29).
* MacOS is **not supported**. **Linux** and **Windows** is supported.
  * This theme is primarily tested on **XFCE**. Other setups may encounter bugs.
* This theme is **not compatible** with Firefox skins/themes, or a combined title bar.
* Dark mode is not currently supported.
  * on a PC set to dark mode, change the theme to light in Firefox Customise setting.
* The menu bar is expected to be visible. The bookmarks bar is optional.
* Due to the current reliance on low-res button images, this theme will look incredibly blurry on screen densities above 1080p.
* Like the original Modern Modoki, not all icons are covered - especially not extensions.

**If you experience graphical oddities please submit a bug report with screenshots + OS version.**

## 🚀 Installation

Note: These theme is **not supported on MacOS**. Also, if you are using Firefox on Linux via **Snap** or **Flatpak**, these instructions may not work.

* (Windows & Linux) In Customize, turn on Title Bar and enable Menu bar under toolbars.
* Download a zip copy of the theme (preferably from releases).
* In Firefox, navigate to `about:support`.
* Under 'Profile Directory' or 'Profile Folder', click on Open Directory/Folder button.
* In this folder, drop the `chrome` folder from the theme here.
* In Firefox again, navigate to `about:config`.
* Search for `toolkit.legacyUserProfileCustomizations.stylesheets` and set to true.
* Restart Firefox.

If done correctly, you Firefox will now be skinned with Modern Modoki. **Please note this theme will not be included in synchronise**.

## 🖌️ Customisation

### Hide menu button

[Contributed idea by **AlexyBot**](https://github.com/soup-bowl/Modoki-Firefox/issues/8#issuecomment-1544206896), while Firefox supports menu bars, most functionality the menu button adds is duplicated. Therefore, you can hide the menu button. This can be achieved by adding this to the end of the **userChrome.css** file.

```css
#PanelUI-button { display: none !important; }
```

And comment out **lines 24 to 37** of **toolbars.css**.

## 🌟 Credits

* Inspired by **[Modern Modoki theme][mm]**, itself inspired by **Netscape Navigator**.
* Built upon the base of **[Internet Explorer 6 theme][rf]** by **matthewmx86** (now a theme collection).
* All functional layouts built upon the amazing foundations of [**Firefox CSS Hacks**][cssh] by **MrOtherGuy**.

[rf]:   https://github.com/matthewmx86/RetroThemesFirefox
[c95]:  https://github.com/grassmunk/Chicago95
[mm]:   http://lowandsh.web.fc2.com/index.en.html
[mmm]:  https://addons.palemoon.org/addon/modoki-moon/
[cssh]: https://github.com/MrOtherGuy/firefox-csshacks
