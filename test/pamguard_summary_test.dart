import 'package:flutter_test/flutter_test.dart';
import 'package:whalepi_flutter/models/pamguard_summary.dart';

void main() {
  group('recorder fileName', () {
    test('parses fileName from a current-firmware summary', () {
      const xml =
          '<Sound Recorder>Sound recorder:<RecorderSummary><button>start</button>'
          '<state>recording</state><freeSpaceMB>147108.4</freeSpaceMB>'
          '<fileSizeMB>12.3</fileSizeMB><fileName>PAM_20260225_101028.wav</fileName>'
          '<channelAmplitudesdB><channel index="0">-81.49</channel>'
          '<channel index="1">-77.97</channel></channelAmplitudesdB>'
          '</RecorderSummary><\\Sound Recorder>';
      final s = PamGuardSummary.parse(xml)!;
      expect(s.recorder.fileName, 'PAM_20260225_101028.wav');
      expect(s.recorder.state, 'recording');
      expect(s.recorder.fileSizeMB, 12.3);
      expect(s.recorder.channelAmplitudesdB, [-81.49, -77.97]);
    });

    // Older firmware does not send <fileName>; every other field must still
    // parse, and the name must come back as an empty string, never null.
    test('older firmware without <fileName> still parses fully', () {
      const xml =
          '<Sound Recorder>Sound recorder:<RecorderSummary><button>start</button>'
          '<state>recording</state><freeSpaceMB>147108.4</freeSpaceMB>'
          '<fileSizeMB>12.3</fileSizeMB>'
          '<channelAmplitudesdB><channel index="0">-81.49</channel>'
          '<channel index="1">-77.97</channel></channelAmplitudesdB>'
          '</RecorderSummary><\\Sound Recorder>';
      final s = PamGuardSummary.parse(xml)!;
      expect(s.recorder.fileName, '');
      expect(s.recorder.state, 'recording');
      expect(s.recorder.freeSpaceMB, 147108.4);
      expect(s.recorder.fileSizeMB, 12.3);
      expect(s.recorder.channelAmplitudesdB, [-81.49, -77.97]);
    });

    test('empty, self-closing and whitespace-only fileName read as empty', () {
      for (final tag in ['<fileName></fileName>', '<fileName/>', '<fileName>   </fileName>']) {
        final xml = '<RecorderSummary><state>stopped</state>$tag</RecorderSummary>';
        expect(PamGuardSummary.parse(xml)!.recorder.fileName, '', reason: tag);
      }
    });

    test('fileName is trimmed of surrounding whitespace', () {
      const xml =
          '<RecorderSummary><state>recording</state>\n'
          '  <fileName>  PAM_20260225_101028.wav  </fileName>\n'
          '</RecorderSummary>';
      expect(
        PamGuardSummary.parse(xml)!.recorder.fileName,
        'PAM_20260225_101028.wav',
      );
    });

    test('summary with no RecorderSummary block at all', () {
      const xml = '<PiTemperature>44.2</PiTemperature>';
      final s = PamGuardSummary.parse(xml)!;
      expect(s.recorder.fileName, '');
      expect(s.recorder.state, 'unknown');
    });
  });
}
