import 'package:flutter/material.dart';

class TimetablePeriod {
  TimetablePeriod(
      {required this.day,
      required this.periodName,
      required this.start,
      required this.end,
      this.roomCode});

  factory TimetablePeriod.clone(TimetablePeriod other) {
    return TimetablePeriod(
      day: other.day,
      periodName: other.periodName,
      start: other.start,
      end: other.end,
      roomCode: other.roomCode,
    );
  }

  factory TimetablePeriod.parse(Map<String, dynamic> json) {
    return TimetablePeriod(
      day: json['day'],
      periodName: json['periodName'],
      start: TimeOfDay.fromDateTime(DateTime.fromMillisecondsSinceEpoch(json['start'])),
      end: TimeOfDay.fromDateTime(DateTime.fromMillisecondsSinceEpoch(json['end'])),
      roomCode: json['roomCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'periodName': periodName,
      'start': DateTime(0, 0, 0, start.hour, start.minute),
      'end': DateTime(0, 0, 0, end.hour, end.minute),
      'roomCode': roomCode,
    };
  }

  int day;
  String periodName;
  TimeOfDay start;
  TimeOfDay end;
  String? roomCode;
}

class TimetableEntry {
  TimetableEntry(
      {required this.courseCode, this.teacher, required this.periods});

  factory TimetableEntry.clone(TimetableEntry other) {
    return TimetableEntry(
      courseCode: other.courseCode,
      teacher: other.teacher,
      periods: other.periods.map((TimetablePeriod p) => TimetablePeriod.clone(p)).toList(),
    );
  }

  factory TimetableEntry.parse(Map<String, dynamic> json) {
    return TimetableEntry(
      courseCode: json['courseCode'],
      teacher: json['teacher'],
      periods: json['periods'].map((period) => TimetablePeriod.parse(period)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'courseCode': courseCode,
      'teacher': teacher,
      'periods': periods.map((period) => period.toJson()).toList(),
    };
  }

  String courseCode;
  String? teacher;
  List<TimetablePeriod> periods;
}

class Timetable {
  Timetable({this.semester, required this.entries});

  factory Timetable.clone(Timetable other) {
    return Timetable(
      semester: other.semester,
      entries: other.entries.map((TimetableEntry e) => TimetableEntry.clone(e)).toList(),
    );
  }

  factory Timetable.parse(Map<String, dynamic> json) {
    return Timetable(
      semester: json['semester'],
      entries: json['entries'].map((entry) => TimetableEntry.parse(entry)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'semester': semester,
      'entries': entries.map((entry) => entry.toJson()).toList(),
    };
  }

  final int? semester;
  List<TimetableEntry> entries;
}
