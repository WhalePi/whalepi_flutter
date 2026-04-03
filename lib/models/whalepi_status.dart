/// Represents the status of the WhalePi watchdog and PAMGuard
class WhalePiStatus {
  final String pamguardStatus;
  final int pamguardCode;
  final String watchdogState;
  final int restarts;
  final int uptimeSeconds;
  final String uptimeFormatted;
  final String startTime;
  final bool isXml;

  WhalePiStatus({
    this.pamguardStatus = 'UNKNOWN',
    this.pamguardCode = -1,
    this.watchdogState = 'UNKNOWN',
    this.restarts = 0,
    this.uptimeSeconds = 0,
    this.uptimeFormatted = '',
    this.startTime = '',
    this.isXml = false,
  });

  /// Try to parse XML status response; falls back to plain text for older watchdogs
  static WhalePiStatus parse(String rawData) {
    // Try XML parsing first
    if (rawData.contains('<whalepidogStatus>')) {
      return _parseXml(rawData);
    }
    // Fallback: treat as plain text status
    return _parsePlainText(rawData);
  }

  static WhalePiStatus _parseXml(String data) {
    try {
      final pamStatusMatch = RegExp(
        r'<pamguardStatus\s+code="(\d+)">(.*?)</pamguardStatus>',
        dotAll: true,
      ).firstMatch(data);

      final pamStatus = pamStatusMatch?.group(2)?.trim() ?? 'UNKNOWN';
      final pamCode = int.tryParse(pamStatusMatch?.group(1) ?? '-1') ?? -1;

      final state = _extractTag(data, 'state') ?? 'UNKNOWN';
      final restarts = int.tryParse(_extractTag(data, 'restarts') ?? '0') ?? 0;
      final uptimeSec =
          int.tryParse(_extractTag(data, 'uptimeSeconds') ?? '0') ?? 0;
      final uptimeFmt = _extractTag(data, 'uptimeFormatted') ?? '';
      final startTime = _extractTag(data, 'startTime') ?? '';

      return WhalePiStatus(
        pamguardStatus: pamStatus,
        pamguardCode: pamCode,
        watchdogState: state,
        restarts: restarts,
        uptimeSeconds: uptimeSec,
        uptimeFormatted: uptimeFmt,
        startTime: startTime,
        isXml: true,
      );
    } catch (_) {
      return _parsePlainText(data);
    }
  }

  static WhalePiStatus _parsePlainText(String data) {
    // Best-effort: look for keywords in plain text status
    final lower = data.toLowerCase();
    String pamStatus = 'UNKNOWN';
    if (lower.contains('running')) {
      pamStatus = 'RUNNING';
    } else if (lower.contains('stopped')) {
      pamStatus = 'STOPPED';
    } else if (lower.contains('error')) {
      pamStatus = 'ERROR';
    }
    return WhalePiStatus(
      pamguardStatus: pamStatus,
      isXml: false,
    );
  }

  static String? _extractTag(String data, String tag) {
    final match = RegExp('<$tag>(.*?)</$tag>', dotAll: true).firstMatch(data);
    return match?.group(1)?.trim();
  }
}
