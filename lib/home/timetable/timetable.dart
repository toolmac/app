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

  final int? semester;
  List<TimetableEntry> entries;
}
