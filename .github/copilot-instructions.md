## Bluetooth LE Terminal - Flutter App

This is a Flutter implementation of a Bluetooth Low Energy Terminal for UART-style communication.

### Project Details

- **Type**: Flutter Mobile Application (BLE Terminal)
- **Framework**: Flutter 3.41.2
- **Language**: Dart 3.11.0
- **Organization**: com.whalepi
- **Platforms**: Android, iOS, macOS

### Key Dependencies

- `flutter_blue_plus: ^1.35.2` - Cross-platform Bluetooth Low Energy
- `permission_handler: ^11.3.1` - Runtime permissions

### App Structure

```
lib/
├── main.dart                          # App entry point
├── models/message.dart                # Message model
├── screens/devices_screen.dart        # Device list
├── screens/terminal_screen.dart       # Terminal UI
└── services/bluetooth_le_service.dart
```

### Features

- Device discovery and paired device list
- Terminal-style send/receive interface
- HEX mode toggle
- Configurable line endings
- Connection status indicators

### Development Commands

```bash
flutter run              # Run on connected device
flutter build apk        # Build Android APK
flutter analyze          # Check for issues
flutter test             # Run tests
```

### Notes

- Supports Android, iOS, and macOS
- Uses Bluetooth Low Energy (BLE) with UART services (Nordic UART, HM-10, etc.)
- Requires physical device for testing (simulators/emulators don't support BLE)
