import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'calendar.dart';

class CalendarScreen extends StatefulWidget {
  CalendarScreen({Key? key}) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen>
    with AutomaticKeepAliveClientMixin<CalendarScreen> {
  @override
  bool get wantKeepAlive => true;

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  List<Event> _getEvents(DateTime? day) {
    if (day == null) {
      return [];
    }
    return [
      Event('SCHOOL DAY'),
      Event('SCHOOL DAY'),
      Event('SCHOOL DAY'),
      Event('SCHOOL DAY')
    ];
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(children: [
      TableCalendar<Event>(
        firstDay: DateTime.utc(2020, 10, 16),
        lastDay: DateTime.utc(2021, 10, 14),
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          if (!isSameDay(_selectedDay, selectedDay)) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          }
        },
      ),
      Column(
          children: _getEvents(_selectedDay)
              .map((event) => Text(event.title))
              .toList())
    ]);
  }
}
