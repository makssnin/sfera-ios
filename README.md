# Sfera iOS

Sfera iOS is a fork of [Element Classic iOS](https://github.com/element-hq/element-ios), a previous-generation [Matrix](https://matrix.org/) client. It is based on [MatrixSDK](https://github.com/matrix-org/matrix-ios-sdk). This fork includes visual rebranding, modified default servers, push gateway changes, disabled analytics, bug fixes, and other improvements.

<p align="center">  
  <a href="https://apps.apple.com/us/app/sfera-chat/id6755233874">
    <img alt="Download on the App Store" src="https://www.apple.com/lae/itunes/link/images/link_badge_appstore_large_2x.png" width=160>
  </a>
</p>

## Build instructions

If you have everything installed, opening the project workspace in Xcode should be as easy as:

$ xcodegen                  # Generate the Xcode project with all source files  
$ pod install               # Install dependencies and create xcworkspace  
$ open Sfera.xcworkspace    # Open Xcode

For more detailed instructions and advanced usage (e.g., using the development version of [MatrixSDK](https://github.com/matrix-org/matrix-ios-sdk)), see the [INSTALL.md](./INSTALL.md) guide.

## Modifications

All changes and fixes are documented in the [CHANGELOG.md](./CHANGELOG.md) file.

## Authors & Copyright

Original authors from the Element iOS project:

Copyright (c) 2014-2017 OpenMarket Ltd.  
Copyright (c) 2017 Vector Creations Ltd.  
Copyright (c) 2017-2025 New Vector Ltd.  
Copyright (c) 2025 Element Creations Ltd.

Fork modifications by:

Copyright (c) 2025 makssnin  
* Sfera iOS fork maintainer

## License

This software is dual licensed:

1. For the original Element iOS code:  
   - Either under the [GNU Affero General Public License v3](https://www.gnu.org/licenses/agpl-3.0.html)  
   - Or under the commercial Element license, if agreed with Element.  

2. For modifications by the Sfera team:  
   - Licensed under [Apache License 2.0](https://www.apache.org/licenses/LICENSE-2.0) for forked code and branding changes.  

Unless required by law or agreed in writing, software distributed under the licenses is provided “AS IS”, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND.
