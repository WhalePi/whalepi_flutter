# Bluetooth LE Terminal

A cross-platform Flutter application for Bluetooth Low Energy (BLE) UART communication.

## Features

- **Device Discovery**: Scan for nearby BLE devices
- **Paired Devices**: Quick access to already paired devices (Android)
- **Terminal Interface**: Send and receive text-based messages
- **HEX Mode**: Switch between text and hexadecimal display
- **Line Endings**: Configurable line endings (CR, LF, CR+LF, None)
- **Connection Status**: Real-time connection state display
- **Message History**: Scrollable message history with timestamps
- **UART Services**: Supports Nordic UART Service, HM-10, and other BLE UART profiles

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
- A physical device (BLE not available on emulators/simulators)

### Platform Setup

**Android**: Bluetooth permissions configured in `android/app/src/main/AndroidManifest.xml`
- `BLUETOOTH_SCAN` / `BLUETOOTH_CONNECT` (Android 12+)
- `ACCESS_FINE_LOCATION` (for device discovery)

**iOS/macOS**: Bluetooth usage descriptions configured in Info.plist

### Running the App

```bash
flutter run
```

### Building for Release

```bash
flutter build apk --release
```

## Usage

1. **Launch the app** - The device list screen appears
2. **Enable Bluetooth** - If disabled, tap "Enable Bluetooth"
3. **Select a device** - Tap a paired device or discover new ones
4. **Terminal** - Send messages and view responses
5. **Options**:
   - Toggle HEX mode for raw byte display
   - Configure line endings
   - Clear message history

## Project Structure

```
lib/
├── main.dart                          # App entry point
├── models/
│   └── message.dart                   # Message model
├── screens/
│   ├── devices_screen.dart            # Device list UI
│   └── terminal_screen.dart           # Terminal UI
└── services/
    └── bluetooth_serial_service.dart  # Bluetooth communication
```

## Notes

- **Classic Bluetooth only** - This app uses Bluetooth SPP (Serial Port Profile), not BLE
- **Android focused** - iOS requires additional setup for classic Bluetooth
- **Physical device required** - Bluetooth is not available on emulators

## Resources

- [Flutter Bluetooth Serial Package](https://pub.dev/packages/flutter_bluetooth_serial)
- [SimpleBluetoothTerminal (Reference)](https://github.com/kai-morich/SimpleBluetoothTerminal)
- [Flutter Documentation](https://docs.flutter.dev/)
