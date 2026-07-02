# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.3.0] - 2026-07-02

### Added
- `am` / `airplane` - Airplane mode settings (`ms-settings:network-airplanemode`)
- `no` / `notify` - Notifications (`ms-settings:notifications`)
- `cb` / `clipboard` - Clipboard settings (`ms-settings:clipboard`)
- `rd` / `remote` - Remote Desktop (`ms-settings:remotedesktop`)
- `ab` / `about` - About this PC (`ms-settings:about`)
- `nl` / `nightlight` - Night light (`ms-settings:nightlight`)
- `mt` / `multitask` - Multitasking (`ms-settings:multitasking`)
- `tb` / `taskbar` - Taskbar settings (`ms-settings:taskbar`)
- `th` / `themes` - Themes (`ms-settings:themes`)
- `bg` / `background` - Background settings (`ms-settings:personalization-background`)
- `ls` / `lockscreen` - Lock screen settings (`ms-settings:lockscreen`)
- `co` / `colors` - Colors settings (`ms-settings:colors`)
- `si` / `signin` - Sign-in options (`ms-settings:signinoptions`)
- `dt` / `datetime` - Date and time (`ms-settings:dateandtime`)
- `lg` / `language` - Language and region (`ms-settings:regionlanguage`)
- `fd` / `finddev` - Find My Device (`ms-settings:findmydevice`)
- `pe` / `encrypt` - Device encryption (`ms-settings:deviceencryption`)
- `pv` / `privacy` - Privacy settings hub (`ms-settings:privacy`)
- `de` / `devmode` - Developer settings (`ms-settings:developers`)
- `da` / `defaults` - Default apps (`ms-settings:defaultapps`)
- `su` / `startup` - Startup apps (`ms-settings:startupapps`)
- `of` / `optional` - Optional features (`ms-settings:optionalfeatures`)
- `pr` / `printers` - Printers and scanners (`ms-settings:printers`)
- `ms` / `mouse` - Mouse settings (`ms-settings:mousetouchpad`)
- `us` / `usb` - USB settings (`ms-settings:usb`)
- `--help` and `-h` aliases for explicit help access
- `--version` and `-v` flags for programmatic version output
- ANSI-aware coloured help headings when terminal support is detected

### Changed
- Expanded SnapSet beyond core network and system pages into personalization, accounts, privacy, apps, and devices
- Restructured the built-in help output into grouped command sections for improved readability
- Updated the script header and project wording to reflect support for settings, system tools, and control panels
- Updated the README with a clearer installation flow, expanded command coverage, help and version flag usage, compatibility notes, and improved project positioning

### Fixed
- Updated repository references from `TechnifiedWorld/snapset` to `TechnifiedWorld/snapset-cli`
- Clarified installation instructions so PATH setup no longer depends on `snapset` already being available
- Added plain-output fallback for help rendering when ANSI colour support is not detected

## [1.2.1] - 2026-06-12

### Fixed
- `fw` / `firewall` - Switched to `wf.msc` (Windows Defender Firewall with Advanced Security) for direct access to full inbound and outbound rule management
- Updated help screen tip and README to reflect correct firewall behaviour

## [1.2.0] - 2026-06-12

### Added
- `sn` / `sound` - Sound settings (`ms-settings:sound`)
- `st` / `storage` - Storage and Storage Sense (`ms-settings:storagesense`)
- `ws` / `winsec` - Windows Security hub (`ms-settings:windowsdefender`)
- `fw` / `firewall` - Firewall and network protection (see v1.2.1 fix)
- `ap` / `apps` - Apps and Features (`ms-settings:appsfeatures`)

## [1.1.0] - 2026-05-06

### Added
- `ds` / `display` - Display settings (`ms-settings:display`)
- `pw` / `power` - Power and sleep settings (`ms-settings:powersleep`)
- `wu` / `update` - Windows Update (`ms-settings:windowsupdate`)
- `bt` / `bluetooth` - Bluetooth devices (`ms-settings:bluetooth`)
- `sv` / `services` - Windows Services (`services.msc`)

## [1.0.0] - 2026-05-06

### Changed
- Replaced `wp/wifiprop` (duplicate of `ad/adapters`) with `wm/wifiman`, which opens Manage known Wi-Fi networks via `ms-settings:network-wifisettings`

## [1.0.0-beta] - 2026-05-05

Initial release.

### Added
- `snapset.bat`: single unified launcher for Windows 11 network and system settings
- Short and long command aliases for all supported pages
- Built-in help output with usage tips
- Commands: `n/network`, `h/hotspot`, `wi/wifi`, `vp/vpn`, `px/proxy`,
  `av/advanced`, `et/ethernet`, `du/datausage`, `ad/adapters`,
  `wp/wifiprop`, `ev/envars`
- Project logo (`docs/logo.png`)
- Social preview image (`docs/social_preview.png`)

[Unreleased]: https://github.com/TechnifiedWorld/snapset-cli/compare/v1.3.0...HEAD
[1.3.0]: https://github.com/TechnifiedWorld/snapset-cli/compare/v1.2.1...v1.3.0
[1.2.1]: https://github.com/TechnifiedWorld/snapset-cli/compare/v1.2.0...v1.2.1
[1.2.0]: https://github.com/TechnifiedWorld/snapset-cli/compare/v1.1.0...v1.2.0
[1.1.0]: https://github.com/TechnifiedWorld/snapset-cli/compare/v1.0.0...v1.1.0
[1.0.0]: https://github.com/TechnifiedWorld/snapset-cli/compare/v1.0.0-beta...v1.0.0
[1.0.0-beta]: https://github.com/TechnifiedWorld/snapset-cli/releases/tag/v1.0.0-beta