# WhalePi BLE Terminal

A Flutter mobile application for communicating with [WhalePi](https://github.com/WhalePi/install_whalepi) passive acoustic recording devices via Bluetooth Low Energy (BLE).

<p align="center">
  <img width="300" src="assets/Screenshot_20260309-212042.png">
</p>


## Features

- **Device Discovery**: Scan for and connect to nearby BLE devices
- **Summary Tab**: GUI dashboard for PAMGuard status — audio levels, GPS, recorder state, current file and temperature
- **Terminal Tab**: Raw command/response interface with terminal styling
- **Copy & Clear**: Copy the whole terminal log to the clipboard, or clear the on-screen history
- **Data Management**: Copy recordings to a USB drive, or wipe recordings and the database, from the terminal
- **HEX Mode**: Switch between text and hexadecimal display
- **Line Endings**: Configurable line endings (CR, LF, CR+LF, None)
- **Connection Status**: Real-time BLE connection state display
- **Message History**: Scrollable, selectable, timestamped message log
- **Test Mode**: Built-in simulator so the app can be used without hardware
- **UART Services**: Supports Nordic UART Service, HM-10, and other BLE UART profiles

## Screens

The app has three screens: a **device list**, and a **device view** with two
tabs — **Summary** and **Terminal** — switched from the bottom navigation bar.

### Device list

Scans for nearby BLE devices. Tap a discovered WhalePi to connect. The flask
icon in the app bar toggles Test Mode (see below).

### Summary tab

Parses the XML the device returns and renders it as a dashboard: PAMGuard
run state, per-channel audio levels, GPS position and fix status, recorder
state, current recording file name and size, free disk space, database write
counts, and Raspberry Pi core temperature. Each time a summary is parsed the
app automatically follows it with a `status` request to refresh the watchdog
state and uptime shown in the status bar.

### Terminal tab

The raw connection. Type a command, tap **SEND** (or press enter), and the
device's reply is appended to the log.

#### Commands

Commands are interpreted by the [whalepidog](https://github.com/WhalePi/install_whalepi)
watchdog running on the Pi, not by the app — the terminal sends whatever you
type. Matching is case-insensitive.

**PAMGuard / watchdog commands** — forwarded to PAMGuard over UDP:

| Command       | Effect                                                                          |
|---------------|---------------------------------------------------------------------------------|
| `ping`        | Connectivity check; PAMGuard echoes `ping` back                                   |
| `status`      | Over Bluetooth this is answered by whalepidog itself with `<whalepidogStatus>` XML — watchdog state, restart count and uptime, plus the PAMGuard status code |
| `summary`     | Full PAMGuard summary as `<WhalePiSummary>` XML — this is what the Summary tab parses |
| `diagnostics` | Extended diagnostics report                                                       |
| `start`       | Start recording. Also sets `deploy` to true in settings, so PAMGuard auto-starts after a reboot |
| `stop`        | Stop recording. Also sets `deploy` to false, so PAMGuard will not auto-start after a reboot |
| `exit`        | Ask PAMGuard to shut down                                                         |
| `kill`        | Forwarded kill command                                                            |

**Data management commands** — handled locally by whalepidog and never sent to
PAMGuard. **PAMGuard must be stopped first** (send `stop`); each of these
returns `ERROR: PAMGuard is currently processing data...` while it is running.

| Command              | Effect                                                                     |
|----------------------|-----------------------------------------------------------------------------|
| `copydata`           | Lists attached USB/external volumes, numbered, with label, device path, and free/total space |
| `copydata <N>`       | Copies recordings to volume `N` (1-based, from the listing above)             |
| `deletewav`          | Returns a confirmation prompt naming the folder that would be erased          |
| `deletewav yes`      | Permanently deletes everything in the configured `wavFolder`                   |
| `deletedatabase`     | Returns a confirmation prompt naming the database that would be erased        |
| `deletedatabase yes` | Deletes the database (plus `-wal`, `-shm`, `-journal` files) and recreates a blank one via `sqlite3 <db> "VACUUM;"` |

Confirmation accepts `yes`, `y`, `confirm`, `ok`, `sure`, or `true`. Anything
else replies `Delete cancelled.`

Unknown commands are **rejected, not passed through**. The watchdog replies
`Unknown command "<text>" - not sent. Known: ping, Status, summary,
diagnostics, start, stop, Exit, kill`.

##### Copying data to a USB drive

`copydata` is split into list-then-select because BLE clients cannot handle
multi-step prompts:

```
$ stop
$ copydata
> ACK: copydata
> RPLY: Available volumes:
> RPLY:   1  MYUSB  [/dev/sda1]  57.2 GB free / 64.0 GB total  (/media/pi/MYUSB)
> RPLY: Send 'copydata <N>' to copy data to that volume.
$ copydata 1
> ACK: copydata 1
> COPY: Starting copy to /media/pi/MYUSB ...
> COPY:    42%  1.2 GB / 2.9 GB  (318 files)  18.4 MB/s
> COPY: Copying database whalepi_database.sqlite3 -> /media/pi/MYUSB/whalepi_database.sqlite3
> RPLY: Copy completed successfully to /media/pi/MYUSB
```

The recordings folder is copied to a sub-folder of the same name on the target
volume, and the database file is copied to the volume root. Before starting,
whalepidog validates that the source folder exists and that the target has
enough free space.

Progress lines stream back during the copy, prefixed `COPY:` — percentage,
bytes copied, file count, and transfer rate, roughly every two seconds. They
appear in the terminal log like any other received line, so a long copy can be
watched from the app. Failures on individual files are reported as `WARNING:`
and do not abort the copy.

#### Response format

whalepidog frames every reply, so the log shows more than the bare response:

| Prefix  | Meaning                                                            |
|---------|--------------------------------------------------------------------|
| `ACK:`  | Command received, echoed back                                       |
| `RPLY:` | Response data, one line per BLE notification (multi-line replies like `summary` arrive as many `RPLY:` lines) |
| `COPY:` | Progress update from a running `copydata`, `deletewav` or `deletedatabase` |

#### Copying and clearing the log

Both live in the Terminal tab's app bar:

| Action        | Icon           | What it does                                                                 |
|---------------|----------------|------------------------------------------------------------------------------|
| **Copy All**  | copy icon      | Copies the entire message log to the system clipboard as plain text, one message per line, formatted `HH:MM:SS <prefix>text`. Disabled while the log is empty. A "Terminal output copied to clipboard" confirmation appears. |
| **Clear**     | trash icon     | Deletes the on-screen message history and leaves a single `# Cleared` status line. |

**Clear only affects the app's own display.** It does not delete recordings,
logs, or any other data on the WhalePi — nothing is sent to the device. To
remove data from the recorder itself, use the `deletewav` and `deletedatabase`
commands above.

Copied output uses the same prefixes shown on screen:

| Prefix | Meaning                        |
|--------|--------------------------------|
| `<`    | Sent by you                    |
| `>`    | Received from the device       |
| `#`    | App status (connect, cleared)  |
| `!`    | Error                          |

Message text on screen is also selectable, so a single line can be copied
without taking the whole log.

#### Other terminal options

- **Line Ending** (wrap icon) — append CR, LF, CR+LF, or nothing to each command. Default is CR+LF.
- **HEX mode** (hexagon icon) — send input as hex bytes (`48 65 6C 6C 6F`) and display responses as hex.
- **Reconnect / Disconnect** — in the overflow menu.

## Test Mode

Tap the flask icon on the device list to enable Test Mode, then connect to the
`WhalePi Simulator` entry. The simulator answers `ping`, `status`, `summary`,
`start` and `stop` with realistic generated data — growing file sizes,
PAMGuard-style file names, drifting temperature, moving GPS — so the whole
interface can be used with no hardware and no Bluetooth permission. Bluetooth
can be switched off entirely.

The simulator covers that subset only. It does not implement `diagnostics`,
`exit`, `kill`, or the `copydata` / `deletewav` / `deletedatabase` data
commands, and it replies with the bare response rather than whalepidog's
`ACK:` / `RPLY:` framing. Anything it does not recognise comes back as
`Unknown command: <text>`.

## Project Information

- **Framework**: Flutter 3.41.2
- **Dart**: 3.11.0
- **Organization**: com.whalepi
- **Platforms**: Android, iOS, macOS

## Dependencies

- `flutter_blue_plus` - Cross-platform BLE support
- `permission_handler` - Runtime permission handling

## Getting Started

### Prerequisites

- Flutter SDK 3.41.2 or higher
- Android SDK (for Android development)
- Xcode (for iOS/macOS development)
- A physical device for real hardware (BLE is not available on emulators/simulators — but Test Mode is)

### Platform Setup

**Android**: Bluetooth permissions configured in `android/app/src/main/AndroidManifest.xml`
- `BLUETOOTH_SCAN` / `BLUETOOTH_CONNECT` (Android 12+)
- `ACCESS_FINE_LOCATION` (for device discovery)

**iOS/macOS**: Bluetooth usage descriptions configured in `Info.plist`

### Running the App

```bash
flutter run
```

### Running the Tests

```bash
flutter test
```

### Building for Release

```bash
flutter build apk --release        # Android APK
flutter build appbundle --release  # Android App Bundle
flutter build ipa --release        # iOS archive for App Store Connect
```

## Usage

1. **Launch the app** — The device list screen appears
2. **Enable Bluetooth** — If disabled, tap "Enable Bluetooth" (or use Test Mode)
3. **Select a device** — Tap a discovered WhalePi device to connect
4. **Summary tab** — View real-time PAMGuard status (audio, GPS, recorder, file, temperature)
5. **Terminal tab** — Send raw commands and view responses
6. **Options**:
   - Copy the full log to the clipboard, or clear the on-screen history
   - Toggle HEX mode for raw byte display
   - Configure line endings

## Project Structure

```
lib/
├── main.dart                          # App entry point, theme, TerminalColors
├── models/
│   ├── message.dart                   # Terminal message model
│   ├── pamguard_summary.dart          # <WhalePiSummary> parsing
│   └── whalepi_status.dart            # <whalepidogStatus> parsing
├── screens/
│   ├── devices_screen.dart            # BLE device list, Test Mode toggle
│   ├── device_screen.dart             # Main device view — Summary + Terminal tabs
│   ├── summary_screen.dart            # PAMGuard summary dashboard
│   └── terminal_screen.dart           # Standalone terminal (superseded by device_screen)
└── services/
    ├── bluetooth_le_service.dart      # BLE UART service
    └── mock_bluetooth_service.dart    # Simulator used by Test Mode

test/
├── pamguard_summary_test.dart         # Summary XML parsing
└── widget_test.dart

ble_server.py                          # BLE peripheral bridge that runs on the WhalePi
APP_STORE_LISTING.md                   # App Store Connect copy and review notes
```

## Notes

- **Bluetooth Low Energy (BLE)** — Uses UART-over-BLE (Nordic UART Service and compatible profiles)
- **Physical device required** — BLE is not available on emulators or simulators; use Test Mode there instead
- **WhalePi devices** — Parses XML data from the WhalePi watchdog process (PAMGuard summaries)
- **Device-side counterpart** — Commands are implemented by the `whalepidog` watchdog on the Pi (`BluetoothBLE`, `CopyDataHandler`, `DeleteDataHandler`); this app is a thin client and adding a command there needs no app change
- **Destructive commands** — `deletewav yes` and `deletedatabase yes` permanently erase data on the recorder with no undo. Copy the data off first with `copydata`
- **Backwards compatible parsing** — Fields missing from older firmware (for example `<fileName>`) fall back to empty values rather than failing the parse
- **No network component** — Everything runs locally over Bluetooth; nothing is collected or transmitted

## Resources

- [flutter_blue_plus](https://pub.dev/packages/flutter_blue_plus)
- [Flutter Documentation](https://docs.flutter.dev/)
- [WhalePi install guide](https://github.com/WhalePi/install_whalepi)

## WhalePi Privacy Policy

WhalePi does not collect, store, or transmit any personal data.

The app communicates only with WhalePi recording hardware over a direct
Bluetooth Low Energy connection. It has no account system, no analytics,
no advertising, and no network or server component. Data read from a
connected device stays on your phone and is not saved after the app is
closed.

Bluetooth access is used solely to discover and connect to WhalePi
devices.

Contact: macster110-at-gmail.com
Last updated: 27/08/2026
