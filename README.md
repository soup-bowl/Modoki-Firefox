# Modern Modoki
Bringing back the Modern Modoki theme into the post-theme era.
![Screenshot_20210515_034352](https://user-images.githubusercontent.com/11209477/118346236-d5cdee80-b531-11eb-87ea-98c7d9a0e9cf.png)

This project aims to bring the Modern Modoki (or close in appearance) theme back to Firefox using the amazing Redmond Firefox theme base, via Firefox's remaining UserChrome interface.

If you're using Pale Moon browser, there's a fork of the original extension which is the best way to use Modern Modoki.

## Bugs
* This theme expects the menu to be visible. It should work regardless, but might look strange.
* Removing the titlebar might cause unpredictable side-effects.
* A lot of functionality was made since Netscape and Modoki. I've added icons where relevant, but original icons will show through until I create a new icon pack.
* This theme will look incredibly blurry on screen densities above 1080p.
* Using Firefox 'themes' will cause the theme to go very strange.

## Installation
* Download a zip copy of the theme (preferably from releases).
* In Firefox, navigate to `about:support`.
* Under 'Profile Directory', click on Open Directory.
* In this folder, drop the `chrome` folder from the theme here.
* In Firefox again, navigate to `about:config`.
* Search for `toolkit.legacyUserProfileCustomizations.stylesheets` and set to true.
* Restart Firefox.

If done correctly, you Firefox will now be skinned with Modern Modoki. **Please note this theme will not be included in synchronise**.

## Credits
CSS based on the great [Internet Explorer 6 theme][rf] from Redmond Firefox.
Inspired by [Modern Modoki theme][rf], itself inspired by Netscape Navigator ([still available for Pale Moon][mmm]!).

[rf]:  https://github.com/matthewmx86/Redmond-Firefox
[mm]:  http://lowandsh.web.fc2.com/index.en.html
[mmm]: https://addons.palemoon.org/addon/modoki-moon/
