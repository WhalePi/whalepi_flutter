// Drives the app through the screens used for App Store screenshots.
//
// This test does not assert much. Its job is to walk the UI into each state
// worth photographing, print a marker, and hold still long enough for the
// host to capture the simulator screen with `xcrun simctl io ... screenshot`.
// See tool/capture_screenshots.py, which reads the markers from this test's
// output and does the capturing.
//
// Run it through that script rather than directly.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:whalepi_flutter/main.dart';

/// How long to sit on a screen so the host can grab it.
const _hold = Duration(seconds: 3);

Future<void> _capture(WidgetTester tester, String name) async {
  await tester.pumpAndSettle();
  // The host watches for this line.
  debugPrint('SCREENSHOT_READY:$name');
  final done = DateTime.now().add(_hold);
  while (DateTime.now().isBefore(done)) {
    await tester.pump(const Duration(milliseconds: 100));
    await Future<void>.delayed(const Duration(milliseconds: 100));
  }
}

Future<void> _sendCommand(WidgetTester tester, String command) async {
  // Tap first: a previous call may have dropped focus to hide the keyboard,
  // and entering text into an unfocused field goes nowhere.
  final field = find.byType(TextField).last;
  await tester.tap(field);
  await tester.pumpAndSettle();
  await tester.enterText(field, command);
  await tester.pumpAndSettle();
  await tester.tap(find.text('SEND').first);
  await tester.pumpAndSettle();
  // Let the mock service stream its reply back.
  await Future<void>.delayed(const Duration(seconds: 3));
  await tester.pumpAndSettle();
  // Drop focus so the software keyboard is not covering the screen when the
  // host captures it.
  FocusManager.instance.primaryFocus?.unfocus();
  await tester.pumpAndSettle();
  await Future<void>.delayed(const Duration(seconds: 1));
  await tester.pumpAndSettle();
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('walk the screens worth photographing', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Test mode puts a simulated WhalePi in the device list, so none of this
    // needs real hardware or even Bluetooth switched on.
    // Several widgets use this icon; the app bar action is the toggle.
    await tester.tap(find.descendant(
      of: find.byType(AppBar),
      matching: find.byIcon(Icons.science),
    ).first);
    await tester.pumpAndSettle();
    await Future<void>.delayed(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    await _capture(tester, '3-device-list');

    await tester.tap(find.text('WhalePi Simulator').first);
    await tester.pumpAndSettle();
    await Future<void>.delayed(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    // Start recording first so the summary shows an active recorder rather
    // than an idle one.
    await tester.tap(find.text('TERMINAL').first);
    await tester.pumpAndSettle();
    await _sendCommand(tester, 'start');
    await _sendCommand(tester, 'summary');

    await _capture(tester, '2-terminal-summary');

    await tester.tap(find.byIcon(Icons.hexagon_outlined).first);
    await tester.pumpAndSettle();
    await _capture(tester, '4-terminal-hex');

    // Back out of hex so the log is readable again.
    await tester.tap(find.byIcon(Icons.text_fields).first);
    await tester.pumpAndSettle();

    await tester.tap(find.text('SUMMARY').first);
    await tester.pumpAndSettle();
    await Future<void>.delayed(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    await _capture(tester, '1-summary-dashboard');

    // Scroll down for the GPS and temperature detail.
    await tester.dragFrom(
      tester.getCenter(find.byType(Scaffold).first),
      const Offset(0, -420),
    );
    await tester.pumpAndSettle();

    await _capture(tester, '5-summary-detail');
  });
}
