# SnapSet

<p align="center">
  <img src="docs/logo.png" alt="SnapSet logo" width="220"/>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/platform-Windows%2011-0078D4?style=flat-square&logo=windows11" alt="Platform"/>
  <img src="https://img.shields.io/badge/language-Batchfile-green?style=flat-square" alt="Language"/>
  <img src="https://img.shields.io/badge/license-MIT-blue?style=flat-square" alt="License"/>
  <img src="https://img.shields.io/github/v/release/TechnifiedWorld/snapset-cli?include_prereleases&label=version&style=flat-square&color=orange" alt="Version"/>
  <img src="https://img.shields.io/github/issues/TechnifiedWorld/snapset-cli?style=flat-square" alt="Issues"/>
  <img src="https://img.shields.io/github/last-commit/TechnifiedWorld/snapset-cli?style=flat-square" alt="Last Commit"/>
</p>

> A lightweight Windows 11 command-line launcher for fast, direct access to settings, system tools, and control panels.
> One short command. No navigation. No clicks.

A project by [Technified World](https://github.com/TechnifiedWorld).

---

## Contents

- [Why SnapSet?](#why-snapset)
- [Requirements](#requirements)
- [Setup](#setup)
- [Usage](#usage)
- [Commands](#commands)
- [Tips](#tips)
- [Known Limitations](#known-limitations)
- [Compatibility](#compatibility)
- [Roadmap](#roadmap)
- [Contributing](#contributing)
- [Changelog](#changelog)
- [License](#license)

---

## Why SnapSet?

Windows 11 buries frequently used settings behind layers of clicks. Finding VPN settings, changing display scale, opening Services, or reaching adapter properties means opening Settings or Control Panel, picking the right category, and hunting for the correct page every time.

SnapSet removes that friction. One short command opens the exact settings page, system tool, or control panel entry you need, instantly, from Command Prompt, PowerShell, Windows Terminal, the Run dialog (`Win + R`), or a shortcut.

| Without SnapSet | With SnapSet |
|----------------|-------------|
| Settings > Network & Internet > VPN | `snapset vp` |
| Settings > Network & Internet > Mobile Hotspot | `snapset h` |
| Control Panel > Network Connections > Adapter Properties | `snapset ad` |
| System Properties > Environment Variables | `snapset ev` |
| Settings > System > Display | `snapset ds` |
| Settings > System > Power & sleep | `snapset pw` |
| Settings > Windows Update | `snapset wu` |
| Settings > System > Sound | `snapset sn` |
| Windows Defender Firewall with Advanced Security | `snapset fw` |
| Settings > Apps > Installed apps | `snapset ap` |
| Settings > Personalization > Taskbar | `snapset tb` |
| Settings > Time & Language > Date & time | `snapset dt` |
| Settings > System > Notifications | `snapset no` |
| Settings > System > Remote Desktop | `snapset rd` |
| Settings > System > Clipboard | `snapset cb` |
| Settings > Privacy & Security > Find My Device | `snapset fd` |

No installation. No dependencies. A single `.bat` file.

---

## Requirements

| Requirement | Detail |
|-------------|--------|
| Windows version | Windows 11, build 22000 or later. Tested on build 26100, 25H2. |
| Shell | Command Prompt, PowerShell, or Windows Terminal |
| Dependencies | None. No Python, Node.js, or package managers. |
| Privileges | Standard user for Settings launches. Elevation required for Services (`sv`) and Firewall rule changes (`fw`). |

> Some commands require specific hardware or conditions. See [Known Limitations](#known-limitations).

---

## Setup

These steps assume you have already cloned or downloaded the SnapSet repository to your computer.

Inside the repository, the launcher script is located at:

```text
scripts\snapset.bat
```

You will copy that file from your local repository folder into a permanent tools folder such as `C:\wintools`, then add that folder to your `PATH`.

### Step 1, choose a tools folder

Decide where you want to keep `snapset.bat`. A short permanent tools folder is recommended, for example:

- `C:\wintools`
- `C:\tools`
- `%USERPROFILE%\tools`

If the folder does not already exist, create it first.

### Step 2, create the folder if needed

#### Option A, PowerShell

Create `C:\wintools`:

```powershell
New-Item -ItemType Directory -Path C:\wintools -Force
```

#### Option B, Windows Explorer

1. Open File Explorer
2. Go to `C:\`
3. Right-click > New > Folder
4. Name it `wintools`

### Step 3, copy SnapSet from your local repository

Copy `scripts\snapset.bat` from the SnapSet repository folder on your machine into the tools folder you chose.

#### Example

If your local repository folder is:

```text
C:\Users\YourName\Downloads\snapset-cli
```

then the source file is:

```text
C:\Users\YourName\Downloads\snapset-cli\scripts\snapset.bat
```

and a typical destination would be:

```text
C:\wintools\snapset.bat
```

#### Option A, Command Prompt

```cmd
copy <path-to-your-repo>\scripts\snapset.bat C:\wintools\snapset.bat
```

Example:

```cmd
copy C:\Users\YourName\Downloads\snapset-cli\scripts\snapset.bat C:\wintools\snapset.bat
```

#### Option B, PowerShell

```powershell
Copy-Item <path-to-your-repo>\scripts\snapset.bat C:\wintools\snapset.bat -Force
```

Example:

```powershell
Copy-Item C:\Users\YourName\Downloads\snapset-cli\scripts\snapset.bat C:\wintools\snapset.bat -Force
```

#### Option C, Windows Explorer

1. Open your local SnapSet repository folder
2. Open the `scripts` subfolder
3. Copy `snapset.bat`
4. Paste it into your chosen tools folder, for example `C:\wintools`

### Step 4, add the folder to PATH

You must add the folder itself, not the `.bat` file, to your `PATH` environment variable.

#### Option A, PowerShell, current user

This adds the folder to your **user PATH** so `snapset` works in new terminals for your account only.

```powershell
$toolsPath = 'C:\wintools'
$currentPath = [Environment]::GetEnvironmentVariable('Path', 'User')

if ($currentPath -notlike "*$toolsPath*") {
    [Environment]::SetEnvironmentVariable(
        'Path',
        $currentPath + ';' + $toolsPath,
        'User'
    )
}
```

#### Option B, PowerShell, all users

Run PowerShell as Administrator if you want SnapSet available system-wide.

```powershell
$toolsPath = 'C:\wintools'
$currentPath = [Environment]::GetEnvironmentVariable('Path', 'Machine')

if ($currentPath -notlike "*$toolsPath*") {
    [Environment]::SetEnvironmentVariable(
        'Path',
        $currentPath + ';' + $toolsPath,
        'Machine'
    )
}
```

#### Option C, manually through Windows

1. Open Start and search for `environment variables`
2. Select **Edit the system environment variables**
3. Click **Environment Variables**
4. Under **User variables** or **System variables**, select `Path`
5. Click **Edit**
6. Click **New**
7. Add your folder path, for example `C:\wintools`
8. Click **OK** to close all windows

### Step 5, open a new terminal and verify

Close any open terminal windows, then open a new Command Prompt, PowerShell, or Windows Terminal window and run:

```cmd
snapset
```

You can also verify the help and version flags directly:

```cmd
snapset --help
snapset --version
```

If the help screen appears and the version prints correctly, the PATH setup is complete.

### Alternative, run without PATH

If you do not want to add SnapSet to PATH, you can still run it directly by full path:

```cmd
C:\wintools\snapset.bat wifi
```

### Run dialog support

Once the folder is in PATH, you can also press `Win + R` and run:

```text
snapset <command>
```

---

## Usage

```cmd
snapset <command>
```

Run `snapset` with no arguments to display the full command reference.

### Help and version

```cmd
snapset --help
snapset -h
snapset --version
snapset -v
```

### Examples

```cmd
:: Open Network & Internet
snapset n
snapset network

:: Open Mobile Hotspot
snapset h
snapset hotspot

:: Open Wi-Fi settings
snapset wi
snapset wifi

:: Open VPN settings
snapset vp
snapset vpn

:: Open Display settings
snapset ds
snapset display

:: Open classic adapter panel (DNS config)
snapset ad
snapset adapters

:: Open Environment Variables
snapset ev
snapset envars

:: Open startup apps
snapset su
snapset startup
```

> Both the short and long form of every command produce the same result.
> Short forms are optimised for speed. Long forms are readable in scripts and shortcuts.

> In Windows Terminal, the built-in help output can use ANSI colour for clearer section headings when terminal support is detected.

---

## Commands

### Network

| Short | Long | Opens | URI / Tool |
|-------|------|-------|-----------|
| `n` | `network` | Network & Internet | `ms-settings:network-status` |
| `h` | `hotspot` | Mobile Hotspot | `ms-settings:network-mobilehotspot` |
| `wi` | `wifi` | Wi-Fi settings | `ms-settings:network-wifi` |
| `wm` | `wifiman` | Manage known Wi-Fi networks | `ms-settings:network-wifisettings` |
| `vp` | `vpn` | VPN settings | `ms-settings:network-vpn` |
| `px` | `proxy` | Proxy settings | `ms-settings:network-proxy` |
| `am` | `airplane` | Airplane mode | `ms-settings:network-airplanemode` |
| `av` | `advanced` | Advanced network settings | `ms-settings:network-advancedsettings` |
| `et` | `ethernet` | Ethernet, requires active wired adapter | `ms-settings:network-ethernet` |
| `du` | `datausage` | Data usage, via Advanced network settings | `ms-settings:network-advancedsettings` |
| `ad` | `adapters` | Classic adapter panel, DNS and protocol config | `ncpa.cpl` |

### System

| Short | Long | Opens | URI / Tool |
|-------|------|-------|-----------|
| `ds` | `display` | Display, resolution, scale, refresh rate | `ms-settings:display` |
| `pw` | `power` | Power and sleep | `ms-settings:powersleep` |
| `sn` | `sound` | Sound, output, input, volume mixer | `ms-settings:sound` |
| `st` | `storage` | Storage and Storage Sense | `ms-settings:storagesense` |
| `wu` | `update` | Windows Update | `ms-settings:windowsupdate` |
| `bt` | `bluetooth` | Bluetooth devices | `ms-settings:bluetooth` |
| `sv` | `services` | Windows Services, elevation required for changes | `services.msc` |
| `ev` | `envars` | Environment Variables, direct dialog | `rundll32 sysdm.cpl,EditEnvironmentVariables` |
| `no` | `notify` | Notifications | `ms-settings:notifications` |
| `cb` | `clipboard` | Clipboard settings | `ms-settings:clipboard` |
| `rd` | `remote` | Remote Desktop | `ms-settings:remotedesktop` |
| `ab` | `about` | System About, device and Windows info | `ms-settings:about` |
| `nl` | `nightlight` | Night light | `ms-settings:nightlight` |
| `mt` | `multitask` | Multitasking | `ms-settings:multitasking` |

### Personalization

| Short | Long | Opens | URI / Tool |
|-------|------|-------|-----------|
| `tb` | `taskbar` | Taskbar settings | `ms-settings:taskbar` |
| `th` | `themes` | Themes | `ms-settings:themes` |
| `bg` | `background` | Background | `ms-settings:personalization-background` |
| `ls` | `lockscreen` | Lock screen | `ms-settings:lockscreen` |
| `co` | `colors` | Colors, accent, dark and light mode | `ms-settings:colors` |

### Accounts and Time

| Short | Long | Opens | URI / Tool |
|-------|------|-------|-----------|
| `si` | `signin` | Sign-in options, PIN, Hello, password | `ms-settings:signinoptions` |
| `dt` | `datetime` | Date and time | `ms-settings:dateandtime` |
| `lg` | `language` | Language and region | `ms-settings:regionlanguage` |

### Security and Privacy

| Short | Long | Opens | URI / Tool |
|-------|------|-------|-----------|
| `ws` | `winsec` | Windows Security hub | `ms-settings:windowsdefender` |
| `fw` | `firewall` | Defender Firewall with Advanced Security | `wf.msc` |
| `fd` | `finddev` | Find My Device | `ms-settings:findmydevice` |
| `pe` | `encrypt` | Device encryption | `ms-settings:deviceencryption` |
| `pv` | `privacy` | Privacy settings, general hub | `ms-settings:privacy` |
| `de` | `devmode` | Developer settings | `ms-settings:developers` |

### Apps

| Short | Long | Opens | URI / Tool |
|-------|------|-------|-----------|
| `ap` | `apps` | Apps and Features | `ms-settings:appsfeatures` |
| `da` | `defaults` | Default apps | `ms-settings:defaultapps` |
| `su` | `startup` | Startup apps | `ms-settings:startupapps` |
| `of` | `optional` | Optional features | `ms-settings:optionalfeatures` |

### Devices

| Short | Long | Opens | URI / Tool |
|-------|------|-------|-----------|
| `pr` | `printers` | Printers and scanners | `ms-settings:printers` |
| `ms` | `mouse` | Mouse settings | `ms-settings:mousetouchpad` |
| `us` | `usb` | USB settings | `ms-settings:usb` |

---

## Tips

**Help and version flags**  
Use `snapset --help` or `snapset -h` to display the grouped command reference.  
Use `snapset --version` or `snapset -v` to print the current version without opening the full help screen.

**DNS configuration**  
Windows 11 has no dedicated `ms-settings:` URI for DNS.  
Use `snapset ad`, then right-click your adapter > Properties > Internet Protocol Version 4 (TCP/IPv4).

**Manage known Wi-Fi networks**  
Use `snapset wm` to open the known networks page directly.  
From here you can forget a network, change its priority, or inspect saved connections.

**Data usage**  
`ms-settings:datausage` is non-functional on Windows 11 25H2.  
Use `snapset du` to open Advanced network settings, then click the Data usage tab.

**Ethernet**  
`snapset et` only opens successfully when an active wired adapter is detected.  
Windows 11 may redirect to Settings Home when no wired adapter is present.

**Windows Services**  
Use `snapset sv` to open the Services panel.  
Starting, stopping, or changing service startup type requires an elevated terminal or UAC prompt.

**Firewall**  
Use `snapset fw` to open Windows Defender Firewall with Advanced Security.  
This uses the legacy MMC snap-in `wf.msc`, which provides full inbound and outbound rule management.

**Dark mode and accent color**  
Use `snapset co` to open Colors settings and switch between Light and Dark mode or change the accent color.

**Startup app management**  
Use `snapset su` to review and disable unnecessary startup apps for faster sign-in and lower background load.

**Developer mode**  
Use `snapset de` to open Developer settings for Developer Mode, Device Portal, and related features.

---

## Known Limitations

| Command | Limitation |
|---------|------------|
| `du` / `datausage` | No dedicated working URI on Windows 11 25H2. Opens Advanced network settings instead. |
| `et` / `ethernet` | Requires an active wired adapter to open correctly. |
| `sv` / `services` | Elevation required for start, stop, and configuration actions. |
| `ws` / `winsec` | Opens the standalone Windows Security app, not a Settings page. |
| `fw` / `firewall` | Uses `wf.msc`, a legacy snap-in. Elevation required for rule changes. |
| `am` / `airplane` | Opens the Airplane mode settings page, but does not toggle the state directly. |
| `pe` / `encrypt` | Requires compatible hardware and Windows support for Device Encryption or BitLocker. |
| ANSI-coloured help | Colour is only used when terminal support is detected, such as Windows Terminal sessions. |

---

## Compatibility

All commands require Windows 11, build 22000 or later. The table below notes commands with known build-specific behaviour.

| Command | Minimum build | Notes |
|---------|---------------|-------|
| Core network commands | 22000, 21H2 | Standard `ms-settings:network-*` support |
| `ds` / `display` | 22000, 21H2 | `ms-settings:display` |
| `pw` / `power` | 22000, 21H2 | `ms-settings:powersleep` |
| `bt` / `bluetooth` | 22000, 21H2 | `ms-settings:bluetooth` |
| `wu` / `update` | 22000, 21H2 | `ms-settings:windowsupdate` |
| `sv` / `services` | 22000, 21H2 | Legacy `services.msc` |
| `ev` / `envars` | 22000, 21H2 | Legacy `sysdm.cpl` entry point |
| `sn` / `sound` | 22000, 21H2 | `ms-settings:sound` |
| `st` / `storage` | 22000, 21H2 | `ms-settings:storagesense` |
| `ws` / `winsec` | 22000, 21H2 | `ms-settings:windowsdefender` |
| `fw` / `firewall` | 22000, 21H2 | Legacy `wf.msc` |
| `ap` / `apps` | 22000, 21H2 | `ms-settings:appsfeatures` |
| `rd` / `remote` | 22000, 21H2 | `ms-settings:remotedesktop` |
| `nl` / `nightlight` | 22000, 21H2 | `ms-settings:nightlight` |
| `co` / `colors` | 22000, 21H2 | `ms-settings:colors` |
| `su` / `startup` | 22000, 21H2 | `ms-settings:startupapps` |
| `de` / `devmode` | 22000, 21H2 | `ms-settings:developers` |
| `pe` / `encrypt` | 22000, 21H2 | `ms-settings:deviceencryption`, hardware dependent |
| `da` / `defaults` | 22621 with 2023-04 cumulative update | Direct-launch behaviour improved on newer builds |
| `ab` / `about` | 22000, 21H2 | `ms-settings:about` |

---

## Roadmap

| Status | Item |
|--------|------|
| `done` | Core network commands |
| `done` | Display, power, Bluetooth, Windows Update |
| `done` | Windows Services and Environment Variables |
| `done` | Sound, Storage, Windows Security, Firewall, Apps |
| `done` | `--help`, `-h`, `--version`, and `-v` support |
| `done` | Grouped help output with ANSI colour support when available |
| `planned` | Accessibility command group |
| `considering` | Hotspot on/off toggle via PowerShell |
| `considering` | PowerShell companion script, `snapset.ps1` |
| `considering` | Additional validation or self-test mode for command checks |

---

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for full guidelines on reporting issues, suggesting features, and submitting pull requests.

Quick reference:

1. Fork the repository
2. Create a branch from `dev`, not `main`
3. Follow the short and long alias pattern for any new command
4. Add a `rem` comment above each new command group
5. Update the built-in help section for any new command
6. Update README command tables, limitations, and compatibility notes
7. Test manually on Windows 11 before opening a PR
8. Use [Conventional Commits](https://www.conventionalcommits.org) for all commit messages

---

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for a full history of changes.

---

## License

[MIT License](LICENSE), (c) 2026 Technified World