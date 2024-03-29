# Time Machine Progress

[xbar](https://xbarapp.com/) (previously BitBar) / [SwiftBar](https://swiftbar.app/) plugin that shows the progress of Time Machine backups visually.

![Time Machine Progress Showcase](TMP-Showcase.png)

## Requirements

- [xbar](https://xbarapp.com/) (previously BitBar) or [SwiftBar](https://swiftbar.app/)
- [filesize](https://rubygems.org/gems/filesize/)
  `gem install filesize`
- macOS 10.14.6, 10.15.4
  (other versions might work but are untested)
- Full Disk Access (see below)

## Fix `Error Reading File: /Library/Preferences/com.apple.TimeMachine.plist`

Time Machine Progress needs to read the contents of `/Library/Preferences/com.apple.TimeMachine.plist` to display the time of the last backup. Since macOS 10.14 (Mojave), this file is under System Integrity Protection (SIP) and cannot be read unless we grant BitBar Full Disk Access from the **System Preferences → Security & Privacy → Privacy → Full Disk Access** menu.

![Full Disk Access setting](full_disk_access.png)

## Acknowledgments

The plugin is based on the [Show Time machine Progress](https://getbitbar.com/plugins/System/timemachine.2m.rb) plugin by Slamet Kristanto.
