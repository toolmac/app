import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

import 'calendar.dart';
import '../../util/storage.dart';

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
    var inputFormat = DateFormat("dd-MM-yyyy");
    int diff = day.day - inputFormat.parse(globalStorage['calendar'][0]['date']).day;
    List<Event> list = [Event('Day ' + globalStorage['calendar'][diff]['day'].toString())];
    var d = ((globalStorage['calendar'][diff]['events'] as List<dynamic>).map((dynamic e) => Event(e['name'])).toList());
    list.addAll(d);
    return list;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print(globalStorage['calendar']);
    print(globalStorage['calendar'][0]);
    print(globalStorage['calendar'][0]['date']);
    var inputFormat = DateFormat("dd-MM-yyyy");
    return Column(children: [
      TableCalendar<Event>(
        firstDay: inputFormat.parse(globalStorage['calendar'][0]['date']),
        lastDay: inputFormat.parse(globalStorage['calendar'][globalStorage['calendar'].length - 1]['date']),
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
