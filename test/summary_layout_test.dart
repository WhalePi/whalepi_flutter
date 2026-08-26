import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:whalepi_flutter/models/pamguard_summary.dart';
import 'package:whalepi_flutter/screens/summary_screen.dart';

/// A summary carrying every optional section, shaped like the mock service's
/// output, so the layout test sees the full set of module panes.
const _summaryXml = '''<?xml version="1.0" encoding="UTF-8"?>
<WhalePiSummary>
  <RawDataSummary>
    <channel index="0"><mean>0.000100</mean><peakdB>-35.4</peakdB><rmsdB>-46.7</rmsdB></channel>
    <channel index="1"><mean>0.000100</mean><peakdB>-45.7</peakdB><rmsdB>-52.2</rmsdB></channel>
  </RawDataSummary>
  <GPSSummary>
    <status>ok</status>
    <timestamp>2026-08-26T19:31:47</timestamp>
    <latitude>34.002308</latitude>
    <longitude>-118.994487</longitude>
    <headingDeg>312.5</headingDeg>
  </GPSSummary>
  <RecorderSummary>
    <button>OFF</button><state>Idle</state>
    <freeSpaceMB>128000.0</freeSpaceMB><fileSizeMB>0.0</fileSizeMB>
    <fileName>PAM_20260826_193147.wav</fileName>
    <channel index="0">-46.7</channel><channel index="1">-52.2</channel>
  </RecorderSummary>
  <AnalogSensorsSummary>
    <Depth><calVal>58.1273</calVal><voltage>2.5231</voltage></Depth>
  </AnalogSensorsSummary>
  <NMEA Data>GPS:\$GPRMC,19:31:47,A,34.0023,N,118.9945,W,0.0,312.5,260826,,,A*00<\\NMEA Data>
  <PAMGUARD><SYSTIME>2026-08-26 18:31:47<\\SYSTIME><STATUS>0<\\STATUS><STATE>0<\\STATE><\\PAMGUARD>
  <Pamguard Database>Database:<DBNAME>whalepi_database.sqlite3</DBNAME><AUTOCOMMIT>0</AUTOCOMMIT><WRITES>0</WRITES><FAILS>0</FAILS><\\Pamguard Database>
  <PiTemperature>45.0</PiTemperature>
</WhalePiSummary>''';

Future<void> _pumpSummary(WidgetTester tester, Size size) async {
  tester.view.devicePixelRatio = 1.0;
  tester.view.physicalSize = size;
  addTearDown(tester.view.reset);

  final summary = PamGuardSummary.parse(_summaryXml)!;
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: SummaryScreen(
          summaryStream: const Stream<PamGuardSummary>.empty(),
          initialSummary: summary,
        ),
      ),
    ),
  );
  await tester.pump();
}

void main() {
  group('summary pane layout', () {
    testWidgets('stacks in one column just below the breakpoint', (
      tester,
    ) async {
      await _pumpSummary(tester, const Size(899, 1200));

      final acquisition = tester.getTopLeft(find.text('Sound Acquisition'));
      final recorder = tester.getTopLeft(find.text('Sound Recorder'));
      expect(acquisition.dx, recorder.dx);
      expect(acquisition.dy, lessThan(recorder.dy));
    });

    testWidgets('splits into two columns at the breakpoint', (tester) async {
      await _pumpSummary(tester, const Size(900, 1200));

      expect(
        tester.getTopLeft(find.text('Sound Acquisition')).dy,
        tester.getTopLeft(find.text('Sound Recorder')).dy,
      );
    });

    testWidgets('stacks in one column on a portrait 11" iPad', (tester) async {
      await _pumpSummary(tester, const Size(834, 1210));

      final acquisition = tester.getTopLeft(find.text('Sound Acquisition'));
      final recorder = tester.getTopLeft(find.text('Sound Recorder'));
      expect(acquisition.dx, recorder.dx);
      expect(acquisition.dy, lessThan(recorder.dy));
    });

    testWidgets('splits into two columns on a landscape iPad', (tester) async {
      await _pumpSummary(tester, const Size(1210, 834));

      final acquisition = tester.getTopLeft(find.text('Sound Acquisition'));
      final recorder = tester.getTopLeft(find.text('Sound Recorder'));
      // Adjacent panes sit side by side, sharing a top edge.
      expect(acquisition.dy, recorder.dy);
      expect(acquisition.dx, lessThan(recorder.dx));
      // Neither column spans the full width.
      expect(recorder.dx, greaterThan(1210 / 2 - 24));
    });

    testWidgets('splits into two columns on a portrait 13" iPad', (
      tester,
    ) async {
      await _pumpSummary(tester, const Size(1024, 1366));

      expect(
        tester.getTopLeft(find.text('Sound Acquisition')).dy,
        tester.getTopLeft(find.text('Sound Recorder')).dy,
      );
    });

    testWidgets('keeps the two columns a similar length', (tester) async {
      await _pumpSummary(tester, const Size(1210, 834));

      // Group the pane titles by which column they landed in, then compare how
      // far down each column runs. A naive alternating split puts every tall
      // pane on the left and leaves the right column stranded.
      const titles = [
        'Sound Acquisition',
        'Sound Recorder',
        'GPS',
        'NMEA',
        'Analog Sensors',
        'Pi Temperature',
        'PAMGuard Database',
      ];
      final bottomByColumn = <double, double>{};
      for (final title in titles) {
        final rect = tester.getRect(find.text(title));
        bottomByColumn.update(
          rect.left,
          (bottom) => bottom > rect.bottom ? bottom : rect.bottom,
          ifAbsent: () => rect.bottom,
        );
      }
      expect(bottomByColumn.length, 2, reason: 'expected exactly two columns');

      final extents = bottomByColumn.values.toList()..sort();
      expect(
        extents.first,
        greaterThan(extents.last * 0.85),
        reason: 'columns differ in length by more than 15%',
      );
    });

    testWidgets('PAMGuard time banner spans both columns', (tester) async {
      await _pumpSummary(tester, const Size(1210, 834));

      final banner = tester.getRect(
        find
            .ancestor(
              of: find.textContaining('PAMGuard Time:'),
              matching: find.byType(Container),
            )
            .first,
      );
      expect(banner.width, greaterThan(1210 * 0.9));
    });
  });
}
