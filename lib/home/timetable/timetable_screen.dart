import 'package:flutter/material.dart';

import 'timetable.dart';

class TimetableScreen extends StatefulWidget {
  TimetableScreen({Key? key}) : super(key: key);

  @override
  _TimetableScreenState createState() => _TimetableScreenState(
          // test timetable
          timetable: Timetable(
        semester: 3,
        entries: [
          TimetableEntry(
            courseCode: 'ICS4U0',
            teacher: 'Valentina Krasteva',
            periods: [
              TimetablePeriod(
                day: 1,
                periodName: 'Period 1',
                start: TimeOfDay.now(),
                end: TimeOfDay.now(),
              ),
              TimetablePeriod(
                day: 2,
                periodName: 'Period 1',
                start: TimeOfDay.now(),
                end: TimeOfDay.now(),
                roomCode: 222,
              ),
            ],
          ),
          TimetableEntry(
            courseCode: 'ICS4U0',
            teacher: 'Valentina Krasteva',
            periods: [
              TimetablePeriod(
                day: 1,
                periodName: 'Period 1',
                start: TimeOfDay.now(),
                end: TimeOfDay.now(),
              ),
              TimetablePeriod(
                day: 1,
                periodName: 'Period 1',
                start: TimeOfDay.now(),
                end: TimeOfDay.now(),
                roomCode: 222,
              ),
            ],
          ),
          TimetableEntry(
            courseCode: 'ICS4U0',
            teacher: 'Valentina Krasteva',
            periods: [
              TimetablePeriod(
                day: 1,
                periodName: 'Period 1',
                start: TimeOfDay.now(),
                end: TimeOfDay.now(),
              ),
              TimetablePeriod(
                day: 1,
                periodName: 'Period 1',
                start: TimeOfDay.now(),
                end: TimeOfDay.now(),
                roomCode: 222,
              ),
            ],
          ),
          TimetableEntry(
            courseCode: 'ICS4U0',
            teacher: 'Valentina Krasteva',
            periods: [
              TimetablePeriod(
                day: 1,
                periodName: 'Period 1',
                start: TimeOfDay.now(),
                end: TimeOfDay.now(),
              ),
              TimetablePeriod(
                day: 1,
                periodName: 'Period 1',
                start: TimeOfDay.now(),
                end: TimeOfDay.now(),
                roomCode: 222,
              ),
            ],
          ),
        ],
      ));
}

class _TimetableScreenState extends State<TimetableScreen>
    with AutomaticKeepAliveClientMixin<TimetableScreen> {
  @override
  bool get wantKeepAlive => true;

  _TimetableScreenState({this.timetable = const Timetable()});

  Widget viewTimetable(BuildContext context) {
    var sem = timetable.semester;
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          if (sem != null)
            Text(
              'Semester $sem Timetable',
              style: TextStyle(
                fontSize: 32,
              ),
            ),
          for (TimetableEntry entry in timetable.entries)
            Container(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(children: <Widget>[
                  Text(
                    entry.courseCode +
                        ((entry.teacher == null)
                            ? ''
                            : ': ' + (entry.teacher ?? '')),
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ]),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: entry.periods
                      .map((TimetablePeriod p) => Text(
                            'Day ' +
                                p.day.toString() +
                                ', ' +
                                p.periodName +
                                ', ' +
                                p.start.format(context) +
                                ' to ' +
                                p.end.format(context) +
                                ' - ' +
                                (p.roomCode?.toString() ?? 'AT HOME/NONE'),
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ))
                      .toList(),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            )),
          Padding(
            padding: EdgeInsets.only(top: 25),
            child: ElevatedButton(
              child: Text('Edit Timetable'),
              onPressed: () {
                editing = true;
                setState(() {});
              },
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(180, 50)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget editTimetable(BuildContext context) {
    return Text('NOT YET IMPLEMENTED');
    /*
    return Container(
      margin: EdgeInsets.all(10.0),
      child: 
    );
    */
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (editing) {
      return editTimetable(context);
    } else {
      return viewTimetable(context);
    }
  }

  Timetable timetable;
  bool editing = false;
}
