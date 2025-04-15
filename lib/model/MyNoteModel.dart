import 'package:intl/intl.dart';

class NotesImpNames {
  static final String id = "id";
  static final String pin = "pin";
  static final String title = "title";
  static final String content = "content";
  static final String isArchieve = "isArchieve";
  static final String createdTime = "createdTime";
  static final String TableName = "Notes";
  static final List<String> value = [
    id,
    pin,
    isArchieve,
    title,
    content,
    createdTime
  ];
}

class Note {
  final int? id;
  final bool pin;
  final bool isArchieve;
  final String title;
  final String content;
  final DateTime createdTime;

  const Note(
      {this.id,
      required this.pin,
      required this.isArchieve,
      required this.title,
      required this.content,
      required this.createdTime});

  Note copy({
    int? id,
    bool? pin,
    bool? isArchieve,
    String? title,
    String? content,
    DateTime? createdTime,
  }) {
    return Note(
        id: id ?? this.id,
        pin: pin ?? this.pin,
        isArchieve: isArchieve ?? this.isArchieve,
        title: title ?? this.title,
        content: content ?? this.content,
        createdTime: createdTime ?? this.createdTime);
  }

  static Note fromJson(Map<String, Object?> json) {
    return Note(
        id: json[NotesImpNames.id] as int?,
        pin: json[NotesImpNames.pin] == 1,
        isArchieve: json[NotesImpNames.isArchieve] == 1,
        title: json[NotesImpNames.title] as String,
        content: json[NotesImpNames.content] as String,
        createdTime: _parseDate(json[NotesImpNames.createdTime] as String));
  }

  Map<String, Object?> toJson() {
    return {
      NotesImpNames.id: id,
      NotesImpNames.pin: pin ? 1 : 0,
      NotesImpNames.isArchieve: isArchieve ? 1 : 0,
      NotesImpNames.title: title,
      NotesImpNames.content: content,
      NotesImpNames.createdTime: createdTime.toIso8601String()
    };
  }

  static DateTime _parseDate(String dateStr) {
    try {
      return DateTime.parse(dateStr); // Try default parsing
    } catch (e) {
      return DateFormat("dd MMM yyyy").parse(dateStr); // Parse "26 Jan 2018"
    }
  }
}
