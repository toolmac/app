import 'package:flutter/material.dart';

class TimetablePeriod {
  TimetablePeriod(
      {required this.day,
      required this.periodName,
      required this.start,
      required this.end,
      this.roomCode});

  final int day;
  final String periodName;
  final TimeOfDay start;
  final TimeOfDay end;
  final int? roomCode;
}

class TimetableEntry {
  const TimetableEntry(
      {required this.courseCode, this.teacher, this.periods = const []});

  final String courseCode;
  final String? teacher;
  final List<TimetablePeriod> periods;
}

class Timetable {
  const Timetable({this.semester, this.entries = const []});

  final int? semester;
  final List<TimetableEntry> entries;
}
