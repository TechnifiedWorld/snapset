@echo off
rem ============================================================
rem  SnapSet by Technified World
rem  Version : v1.3.0
rem  Purpose : Lightweight Windows 11 command-line launcher for
rem            fast, direct access to settings, system tools,
rem            and control panels
rem  Usage   : snapset <command>
rem            Run snapset with no arguments to display help
rem  Repo    : https://github.com/TechnifiedWorld/snapset-cli
rem ============================================================

rem version -- single source of truth for version string
set "ver=v1.3.0"

rem setlocal restricts variable scope to this script only
setlocal EnableExtensions EnableDelayedExpansion

rem %~1 expands the first argument, stripping surrounding quotes
set "x=%~1"

rem ============================================================
rem  ANSI COLOUR SUPPORT
rem  Enabled only in Windows Terminal to avoid garbled output
rem  in plain Command Prompt sessions that do not support VT
rem ============================================================
set "ESC="
set "C_TITLE="
set "C_HEAD="
set "C_TIP="
set "C_ERR="
set "C_RESET="

if defined WT_SESSION (
    for /f %%e in ('echo prompt $E^| cmd') do set "ESC=%%e"
    if defined ESC (
        set "C_TITLE=!ESC![1;36m"
        set "C_HEAD=!ESC![36m"
        set "C_TIP=!ESC![33m"
        set "C_ERR=!ESC![31m"
        set "C_RESET=!ESC![0m"
    )
)

rem ============================================================
rem  META FLAGS
rem ============================================================
if /i "%x%"=="--version" echo snapset %ver% & endlocal & exit /b 0
if /i "%x%"=="-v"        echo snapset %ver% & endlocal & exit /b 0
if /i "%x%"=="--help"    goto :help
if /i "%x%"=="-h"        goto :help

rem ============================================================
rem  NETWORK AND INTERNET
rem ============================================================

rem Network & Internet -- main landing page
if /i "%x%"=="n"         start "" ms-settings:network-status            & goto :end
if /i "%x%"=="network"   start "" ms-settings:network-status            & goto :end

rem Mobile Hotspot -- toggle and configure the Windows hotspot
if /i "%x%"=="h"         start "" ms-settings:network-mobilehotspot     & goto :end
if /i "%x%"=="hotspot"   start "" ms-settings:network-mobilehotspot     & goto :end

rem Wi-Fi -- manage wireless networks and adapter settings
if /i "%x%"=="wi"        start "" ms-settings:network-wifi              & goto :end
if /i "%x%"=="wifi"      start "" ms-settings:network-wifi              & goto :end

rem Manage known networks -- view, forget, and reorder saved Wi-Fi networks
if /i "%x%"=="wm"        start "" ms-settings:network-wifisettings      & goto :end
if /i "%x%"=="wifiman"   start "" ms-settings:network-wifisettings      & goto :end

rem VPN -- add or manage VPN connections
if /i "%x%"=="vp"        start "" ms-settings:network-vpn               & goto :end
if /i "%x%"=="vpn"       start "" ms-settings:network-vpn               & goto :end

rem Proxy -- configure manual or automatic proxy settings
if /i "%x%"=="px"        start "" ms-settings:network-proxy             & goto :end
if /i "%x%"=="proxy"     start "" ms-settings:network-proxy             & goto :end

rem Airplane mode -- open airplane mode settings page
if /i "%x%"=="am"        start "" ms-settings:network-airplanemode      & goto :end
if /i "%x%"=="airplane"  start "" ms-settings:network-airplanemode      & goto :end

rem ============================================================
rem  ADVANCED AND DIAGNOSTICS
rem ============================================================

rem Advanced network settings -- hardware properties, adapter list
if /i "%x%"=="av"        start "" ms-settings:network-advancedsettings  & goto :end
if /i "%x%"=="advanced"  start "" ms-settings:network-advancedsettings  & goto :end

rem Ethernet -- wired adapter settings (requires active wired adapter)
if /i "%x%"=="et"        start "" ms-settings:network-ethernet          & goto :end
if /i "%x%"=="ethernet"  start "" ms-settings:network-ethernet          & goto :end

rem Data usage -- broken on Windows 11 25H2; routes to Advanced network settings
if /i "%x%"=="du"        start "" ms-settings:network-advancedsettings  & goto :end
if /i "%x%"=="datausage" start "" ms-settings:network-advancedsettings  & goto :end

rem ============================================================
rem  ADAPTER PANEL (ncpa.cpl)
rem  Use for: DNS config, Wi-Fi properties, protocol bindings
rem  DNS tip: right-click adapter > Properties > IPv4 > DNS fields
rem ============================================================

if /i "%x%"=="ad"        start "" ncpa.cpl                              & goto :end
if /i "%x%"=="adapters"  start "" ncpa.cpl                              & goto :end

rem ============================================================
rem  SYSTEM SETTINGS
rem ============================================================

rem Display -- resolution, scale, refresh rate, multi-monitor layout
if /i "%x%"=="ds"        start "" ms-settings:display                   & goto :end
if /i "%x%"=="display"   start "" ms-settings:display                   & goto :end

rem Power and sleep -- sleep timers, battery saver, power plan selection
if /i "%x%"=="pw"        start "" ms-settings:powersleep                & goto :end
if /i "%x%"=="power"     start "" ms-settings:powersleep                & goto :end

rem Sound -- output device, input device, volume mixer, spatial audio
if /i "%x%"=="sn"        start "" ms-settings:sound                     & goto :end
if /i "%x%"=="sound"     start "" ms-settings:sound                     & goto :end

rem Storage -- disk usage overview and Storage Sense configuration
if /i "%x%"=="st"        start "" ms-settings:storagesense              & goto :end
if /i "%x%"=="storage"   start "" ms-settings:storagesense              & goto :end

rem Windows Update -- check, pause, or configure updates
if /i "%x%"=="wu"        start "" ms-settings:windowsupdate             & goto :end
if /i "%x%"=="update"    start "" ms-settings:windowsupdate             & goto :end

rem Bluetooth -- pair and manage Bluetooth devices
if /i "%x%"=="bt"        start "" ms-settings:bluetooth                 & goto :end
if /i "%x%"=="bluetooth" start "" ms-settings:bluetooth                 & goto :end

rem Services -- start, stop, configure Windows services (elevation required)
if /i "%x%"=="sv"        start "" services.msc                          & goto :end
if /i "%x%"=="services"  start "" services.msc                          & goto :end

rem Environment Variables -- opens dialog directly, skips System Properties
if /i "%x%"=="ev"        start "" rundll32.exe sysdm.cpl,EditEnvironmentVariables & goto :end
if /i "%x%"=="envars"    start "" rundll32.exe sysdm.cpl,EditEnvironmentVariables & goto :end

rem Notifications -- manage app and system notification settings
if /i "%x%"=="no"        start "" ms-settings:notifications             & goto :end
if /i "%x%"=="notify"    start "" ms-settings:notifications             & goto :end

rem Clipboard -- enable clipboard history, sync, and cloud clipboard
if /i "%x%"=="cb"        start "" ms-settings:clipboard                 & goto :end
if /i "%x%"=="clipboard" start "" ms-settings:clipboard                 & goto :end

rem Remote Desktop -- enable or configure remote desktop access
if /i "%x%"=="rd"        start "" ms-settings:remotedesktop             & goto :end
if /i "%x%"=="remote"    start "" ms-settings:remotedesktop             & goto :end

rem About -- device name, Windows build, processor, RAM, activation status
if /i "%x%"=="ab"        start "" ms-settings:about                     & goto :end
if /i "%x%"=="about"     start "" ms-settings:about                     & goto :end

rem Night light -- enable warm colour tone to reduce blue light at night
if /i "%x%"=="nl"        start "" ms-settings:nightlight                & goto :end
if /i "%x%"=="nightlight" start "" ms-settings:nightlight               & goto :end

rem Multitasking -- snap layouts, desktops, alt-tab behaviour
if /i "%x%"=="mt"        start "" ms-settings:multitasking              & goto :end
if /i "%x%"=="multitask" start "" ms-settings:multitasking              & goto :end

rem ============================================================
rem  PERSONALIZATION
rem ============================================================

rem Taskbar -- pin apps, system tray icons, taskbar settings
if /i "%x%"=="tb"        start "" ms-settings:taskbar                   & goto :end
if /i "%x%"=="taskbar"   start "" ms-settings:taskbar                   & goto :end

rem Themes -- apply or create Windows themes
if /i "%x%"=="th"        start "" ms-settings:themes                    & goto :end
if /i "%x%"=="themes"    start "" ms-settings:themes                    & goto :end

rem Background -- change desktop wallpaper or background color
if /i "%x%"=="bg"        start "" ms-settings:personalization-background & goto :end
if /i "%x%"=="background" start "" ms-settings:personalization-background & goto :end

rem Lock screen -- set lock screen image, widgets, and timeout
if /i "%x%"=="ls"        start "" ms-settings:lockscreen                & goto :end
if /i "%x%"=="lockscreen" start "" ms-settings:lockscreen               & goto :end

rem Colors -- accent color, dark or light mode, transparency effects
if /i "%x%"=="co"        start "" ms-settings:colors                    & goto :end
if /i "%x%"=="colors"    start "" ms-settings:colors                    & goto :end

rem ============================================================
rem  ACCOUNTS AND TIME
rem ============================================================

rem Sign-in options -- PIN, Windows Hello, password, and Dynamic Lock
if /i "%x%"=="si"        start "" ms-settings:signinoptions             & goto :end
if /i "%x%"=="signin"    start "" ms-settings:signinoptions             & goto :end

rem Date and time -- manual or automatic time zone and clock settings
if /i "%x%"=="dt"        start "" ms-settings:dateandtime               & goto :end
if /i "%x%"=="datetime"  start "" ms-settings:dateandtime               & goto :end

rem Language and region -- display language, input methods, region format
if /i "%x%"=="lg"        start "" ms-settings:regionlanguage            & goto :end
if /i "%x%"=="language"  start "" ms-settings:regionlanguage            & goto :end

rem ============================================================
rem  SECURITY AND PRIVACY
rem ============================================================

rem Windows Security -- antivirus, device health, security alerts hub
if /i "%x%"=="ws"        start "" ms-settings:windowsdefender           & goto :end
if /i "%x%"=="winsec"    start "" ms-settings:windowsdefender           & goto :end

rem Firewall -- Windows Defender Firewall with Advanced Security (elevation required)
if /i "%x%"=="fw"        start "" wf.msc                                & goto :end
if /i "%x%"=="firewall"  start "" wf.msc                                & goto :end

rem Find My Device -- enable or disable remote device location
if /i "%x%"=="fd"        start "" ms-settings:findmydevice              & goto :end
if /i "%x%"=="finddev"   start "" ms-settings:findmydevice              & goto :end

rem Device encryption -- BitLocker or Device Encryption (hardware required)
if /i "%x%"=="pe"        start "" ms-settings:deviceencryption          & goto :end
if /i "%x%"=="encrypt"   start "" ms-settings:deviceencryption          & goto :end

rem Privacy (general) -- advertising ID, activity history, diagnostics
if /i "%x%"=="pv"        start "" ms-settings:privacy                   & goto :end
if /i "%x%"=="privacy"   start "" ms-settings:privacy                   & goto :end

rem Developer settings -- Developer Mode, Device Portal, SSH server
if /i "%x%"=="de"        start "" ms-settings:developers                & goto :end
if /i "%x%"=="devmode"   start "" ms-settings:developers                & goto :end

rem ============================================================
rem  APPS
rem ============================================================

rem Apps and Features -- uninstall, move, or repair installed apps
if /i "%x%"=="ap"        start "" ms-settings:appsfeatures              & goto :end
if /i "%x%"=="apps"      start "" ms-settings:appsfeatures              & goto :end

rem Default apps -- set default browser, mail client, and other associations
if /i "%x%"=="da"        start "" ms-settings:defaultapps               & goto :end
if /i "%x%"=="defaults"  start "" ms-settings:defaultapps               & goto :end

rem Startup apps -- enable or disable apps that launch at sign-in
if /i "%x%"=="su"        start "" ms-settings:startupapps               & goto :end
if /i "%x%"=="startup"   start "" ms-settings:startupapps               & goto :end

rem Optional features -- add or remove Windows capabilities
if /i "%x%"=="of"        start "" ms-settings:optionalfeatures          & goto :end
if /i "%x%"=="optional"  start "" ms-settings:optionalfeatures          & goto :end

rem ============================================================
rem  DEVICES
rem ============================================================

rem Printers and scanners -- add, remove, and configure print devices
if /i "%x%"=="pr"        start "" ms-settings:printers                  & goto :end
if /i "%x%"=="printers"  start "" ms-settings:printers                  & goto :end

rem Mouse -- pointer speed, scroll direction, button configuration
if /i "%x%"=="ms"        start "" ms-settings:mousetouchpad             & goto :end
if /i "%x%"=="mouse"     start "" ms-settings:mousetouchpad             & goto :end

rem USB -- USB settings and notifications
if /i "%x%"=="us"        start "" ms-settings:usb                       & goto :end
if /i "%x%"=="usb"       start "" ms-settings:usb                       & goto :end

rem ============================================================
rem  UNRECOGNISED COMMAND
rem ============================================================
if not "%x%"=="" (
    echo.
    if defined C_ERR (
        echo !C_ERR!Error: "%x%" is not a recognised snapset command.!C_RESET!
    ) else (
        echo Error: "%x%" is not a recognised snapset command.
    )
    echo Run snapset with no arguments, or use snapset --help, to see the full command list.
    echo.
    pause
    endlocal
    exit /b 1
)

:help
echo.
if defined C_TITLE (
    echo !C_TITLE!snapset %ver% ^| Technified World!C_RESET!
    echo !C_HEAD!========================================================!C_RESET!
) else (
    echo snapset %ver% ^| Technified World
    echo ========================================================
)
echo Usage: snapset ^<command^>
echo        snapset --help
echo        snapset --version
echo.

if defined C_HEAD (echo !C_HEAD!NETWORK!C_RESET!) else echo NETWORK
echo Short    Long         Opens
echo -------  -----------  ----------------------------------------
echo n        network      Network ^& Internet
echo h        hotspot      Mobile Hotspot
echo wi       wifi         Wi-Fi settings
echo wm       wifiman      Manage known Wi-Fi networks
echo vp       vpn          VPN settings
echo px       proxy        Proxy settings
echo am       airplane     Airplane mode
echo av       advanced     Advanced network settings
echo et       ethernet     Ethernet ^(requires active wired adapter^)
echo du       datausage    Data usage ^(via Advanced network settings^)
echo ad       adapters     Adapter panel ^(DNS / protocol config^)
echo.

if defined C_HEAD (echo !C_HEAD!SYSTEM!C_RESET!) else echo SYSTEM
echo Short    Long         Opens
echo -------  -----------  ----------------------------------------
echo ds       display      Display settings ^(resolution, scale, refresh^)
echo pw       power        Power and sleep
echo sn       sound        Sound ^(output, input, volume mixer^)
echo st       storage      Storage and Storage Sense
echo wu       update       Windows Update
echo bt       bluetooth    Bluetooth devices
echo sv       services     Windows Services ^(elevation required^)
echo ev       envars       Environment Variables ^(direct dialog^)
echo no       notify       Notifications
echo cb       clipboard    Clipboard settings
echo rd       remote       Remote Desktop
echo ab       about        About this PC
echo nl       nightlight   Night light
echo mt       multitask    Multitasking
echo.

if defined C_HEAD (echo !C_HEAD!PERSONALIZATION!C_RESET!) else echo PERSONALIZATION
echo Short    Long         Opens
echo -------  -----------  ----------------------------------------
echo tb       taskbar      Taskbar
echo th       themes       Themes
echo bg       background   Desktop background
echo ls       lockscreen   Lock screen
echo co       colors       Colors and dark / light mode
echo.

if defined C_HEAD (echo !C_HEAD!ACCOUNTS + TIME!C_RESET!) else echo ACCOUNTS + TIME
echo Short    Long         Opens
echo -------  -----------  ----------------------------------------
echo si       signin       Sign-in options ^(PIN, Hello, password^)
echo dt       datetime     Date and time
echo lg       language     Language and region
echo.

if defined C_HEAD (echo !C_HEAD!SECURITY + PRIVACY!C_RESET!) else echo SECURITY + PRIVACY
echo Short    Long         Opens
echo -------  -----------  ----------------------------------------
echo ws       winsec       Windows Security hub
echo fw       firewall     Firewall with Advanced Security ^(elevation^)
echo fd       finddev      Find My Device
echo pe       encrypt      Device encryption
echo pv       privacy      Privacy settings
echo de       devmode      Developer settings
echo.

if defined C_HEAD (echo !C_HEAD!APPS!C_RESET!) else echo APPS
echo Short    Long         Opens
echo -------  -----------  ----------------------------------------
echo ap       apps         Apps and Features
echo da       defaults     Default apps
echo su       startup      Startup apps
echo of       optional     Optional features
echo.

if defined C_HEAD (echo !C_HEAD!DEVICES!C_RESET!) else echo DEVICES
echo Short    Long         Opens
echo -------  -----------  ----------------------------------------
echo pr       printers     Printers and scanners
echo ms       mouse        Mouse settings
echo us       usb          USB settings
echo.

if defined C_TIP (
    echo !C_TIP!Tips:!C_RESET!
) else (
    echo Tips:
)
echo - DNS config:    snapset ad ^> right-click adapter ^> Properties ^> IPv4
echo - Wi-Fi props:   snapset ad ^> right-click ^> Properties ^> Configure ^> Advanced
echo - Data usage:    snapset du ^> click Data usage tab
echo - Services:      snapset sv ^> run as Administrator for start/stop
echo - Firewall:      snapset fw ^> opens Defender Firewall with Advanced Security
echo - Startup perf:  snapset su ^> disable unnecessary startup apps
echo - Dark mode:     snapset co ^> toggle Light / Dark mode
echo - Dev features:  snapset de ^> enable Developer Mode or SSH server
echo.
pause
endlocal
exit /b 0

rem ============================================================
rem  :end -- common exit point for all successful command launches
rem ============================================================
:end
endlocal
exit /b 0