import 'dart:typed_data';

enum MessageType {
  sent,
  received,
  status,
  error,
}

class Message {
  final String text;
  final MessageType type;
  final DateTime timestamp;
  final Uint8List? rawData;

  Message({
    required this.text,
    required this.type,
    DateTime? timestamp,
    this.rawData,
  }) : timestamp = timestamp ?? DateTime.now();

  /// Create a sent message
  factory Message.sent(String text) {
    return Message(text: text, type: MessageType.sent);
  }

  /// Create a received message
  factory Message.received(String text, {Uint8List? rawData}) {
    return Message(text: text, type: MessageType.received, rawData: rawData);
  }

  /// Create a status message
  factory Message.status(String text) {
    return Message(text: text, type: MessageType.status);
  }

  /// Create an error message
  factory Message.error(String text) {
    return Message(text: text, type: MessageType.error);
  }

  String get formattedTime {
    final hour = timestamp.hour.toString().padLeft(2, '0');
    final minute = timestamp.minute.toString().padLeft(2, '0');
    final second = timestamp.second.toString().padLeft(2, '0');
    return '$hour:$minute:$second';
  }
}
