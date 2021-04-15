import 'package:flutter/material.dart';
import 'dart:convert';

import 'timetable.dart';
import '../../util/storage.dart';
import '../../util/fetch.dart';

// taken from https://stackoverflow.com/questions/54898767/enumerate-or-map-through-a-list-with-index-and-value-in-dart
extension ExtendedIterable<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(E e, int i) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }

  void forEachIndexed(void Function(E e, int i) f) {
    var i = 0;
    forEach((e) => f(e, i++));
  }
}

class TimetableScreen extends StatefulWidget {
  TimetableScreen({Key? key}) : super(key: key);

  @override
  _TimetableScreenState createState() => _TimetableScreenState(
      timetable: Timetable.parse(globalStorage['timetable']));
}

class _TimetableScreenState extends State<TimetableScreen>
    with AutomaticKeepAliveClientMixin<TimetableScreen> {
  @override
  bool get wantKeepAlive => true;

  _TimetableScreenState({required this.timetable})
      : input = Timetable.clone(timetable);

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

  TimeOfDay? getTime(String val) {
    var parts = val.split(':');
    if (parts.length != 2) {
      return null;
    }
    int? first = int.tryParse(parts[0]);
    if (first == null || first < 0 || first > 23) {
      return null;
    }
    int? second = int.tryParse(parts[1]);
    if (second == null || second < 0 || second > 59) {
      return null;
    }
    return TimeOfDay(hour: first, minute: second);
  }

  String fromTime(TimeOfDay val) {
    return val.hour.toString() + ":" + val.minute.toString();
  }

  Widget editTimetable(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          if (specific != -1)
            // specific course
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ElevatedButton(
                    child: Icon(Icons.remove),
                    onPressed: () {
                      input.entries.removeAt(specific);
                      specific = -1;
                      timetable = Timetable.clone(input);
                      postTimetable(timetable);
                      setState(() {});
                    },
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(180, 50)),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Text('Course Code: '),
                      Expanded(
                        child: TextFormField(
                            initialValue: input.entries[specific].courseCode,
                            decoration: const InputDecoration(
                              hintText: 'Course Code',
                            ),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Field cannot be empty';
                              }
                              return null;
                            },
                            onSaved: (String? value) {
                              input.entries[specific].courseCode = value ?? '';
                            }),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text('Teacher Name: '),
                      Expanded(
                        child: TextFormField(
                            initialValue: input.entries[specific].teacher,
                            decoration: const InputDecoration(
                              hintText: 'Teacher Name',
                            ),
                            onSaved: (String? value) {
                              if (value == null || value.isEmpty) {
                                input.entries[specific].teacher = null;
                              } else {
                                input.entries[specific].teacher = value;
                              }
                            }),
                      )
                    ],
                  ),
                  Column(
                      children: input.entries[specific].periods
                          .mapIndexed(((TimetablePeriod p, int index) =>
                              Container(
                                child: Container(
                                    child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text('Day: '),
                                        Expanded(
                                            child: TextFormField(
                                                initialValue: input
                                                    .entries[specific]
                                                    .periods[index]
                                                    .day
                                                    .toString(),
                                                decoration:
                                                    const InputDecoration(
                                                  hintText: 'Day',
                                                ),
                                                validator: (String? value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Field cannot be empty';
                                                  }
                                                  int? day =
                                                      int.tryParse(value);
                                                  if (day == null || day < 1) {
                                                    return 'Bad day number';
                                                  }
                                                  return null;
                                                },
                                                onSaved: (String? value) {
                                                  input
                                                      .entries[specific]
                                                      .periods[index]
                                                      .day = int.parse(value!);
                                                }))
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text('Period Name: '),
                                        Expanded(
                                            child: TextFormField(
                                                initialValue: input
                                                    .entries[specific]
                                                    .periods[index]
                                                    .periodName,
                                                decoration:
                                                    const InputDecoration(
                                                  hintText: 'Period Name',
                                                ),
                                                validator: (String? value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Field cannot be empty';
                                                  }
                                                  return null;
                                                },
                                                onSaved: (String? value) {
                                                  input
                                                      .entries[specific]
                                                      .periods[index]
                                                      .periodName = value!;
                                                }))
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text('Start Time: '),
                                        Expanded(
                                            child: TextFormField(
                                                initialValue: fromTime(input
                                                    .entries[specific]
                                                    .periods[index]
                                                    .start),
                                                decoration:
                                                    const InputDecoration(
                                                  hintText:
                                                      'Start Time (hour (0-23) : minutes (0-59))',
                                                ),
                                                validator: (String? value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Field cannot be empty';
                                                  }
                                                  if (getTime(value) == null) {
                                                    return 'Bad time value';
                                                  }
                                                  return null;
                                                },
                                                onSaved: (String? value) {
                                                  input
                                                      .entries[specific]
                                                      .periods[index]
                                                      .start = getTime(value!)!;
                                                }))
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text('End Time: '),
                                        Expanded(
                                            child: TextFormField(
                                                initialValue: fromTime(input
                                                    .entries[specific]
                                                    .periods[index]
                                                    .end),
                                                decoration:
                                                    const InputDecoration(
                                                  hintText:
                                                      'End Time (hour (0-23) : minutes (0-59))',
                                                ),
                                                validator: (String? value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Field cannot be empty';
                                                  }
                                                  if (getTime(value) == null) {
                                                    return 'Bad time value';
                                                  }
                                                  return null;
                                                },
                                                onSaved: (String? value) {
                                                  input
                                                      .entries[specific]
                                                      .periods[index]
                                                      .end = getTime(value!)!;
                                                }))
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text('Room Code: '),
                                        Expanded(
                                            child: TextFormField(
                                                initialValue: input
                                                    .entries[specific]
                                                    .periods[index]
                                                    .roomCode,
                                                decoration:
                                                    const InputDecoration(
                                                  hintText: 'Room Code',
                                                ),
                                                onSaved: (String? value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    input
                                                        .entries[specific]
                                                        .periods[index]
                                                        .roomCode = null;
                                                  } else {
                                                    input
                                                        .entries[specific]
                                                        .periods[index]
                                                        .roomCode = value;
                                                  }
                                                }))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    ElevatedButton(
                                      child: Icon(Icons.remove),
                                      onPressed: () {
                                        input.entries[specific].periods
                                            .removeAt(index);
                                        setState(() {});
                                      },
                                      style: ButtonStyle(
                                        minimumSize: MaterialStateProperty.all(
                                            Size(180, 50)),
                                      ),
                                    )
                                  ],
                                )),
                              )))
                          .toList()),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      ElevatedButton(
                        child: Icon(Icons.add),
                        onPressed: () {
                          input.entries[specific].periods.add(TimetablePeriod(
                              day: 1,
                              periodName: '',
                              start: TimeOfDay(hour: 0, minute: 0),
                              end: TimeOfDay(hour: 0, minute: 0)));
                          setState(() {});
                        },
                        style: ButtonStyle(
                          minimumSize:
                              MaterialStateProperty.all(Size(180, 100)),
                        ),
                      ),
                      ElevatedButton(
                        child: Text('Save'),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            _formKey.currentState!.reset();
                            timetable = Timetable.clone(input);
                            postTimetable(timetable);
                            specific = -1;
                            setState(() {});
                          }
                        },
                        style: ButtonStyle(
                          minimumSize:
                              MaterialStateProperty.all(Size(180, 100)),
                        ),
                      ),
                      ElevatedButton(
                        child: Text('Quit'),
                        onPressed: () {
                          _formKey.currentState!.reset();
                          specific = -1;
                          input = Timetable.clone(timetable);
                          setState(() {});
                        },
                        style: ButtonStyle(
                          minimumSize:
                              MaterialStateProperty.all(Size(180, 100)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          else
            Column(
              children: <Widget>[
                // general courses
                Column(
                    children: input.entries
                        .mapIndexed(
                          (TimetableEntry item, int index) => Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: ElevatedButton(
                                child: Text(item.courseCode),
                                onPressed: () {
                                  specific = index;
                                  setState(() {});
                                },
                                style: ButtonStyle(
                                  minimumSize:
                                      MaterialStateProperty.all(Size(180, 80)),
                                ),
                              )),
                        )
                        .toList()),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    ElevatedButton(
                      child: Icon(Icons.add),
                      onPressed: () {
                        input.entries
                            .add(TimetableEntry(courseCode: '', periods: []));
                        timetable = Timetable.clone(input);
                        postTimetable(timetable);
                        setState(() {});
                      },
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size(180, 100)),
                      ),
                    ),
                    ElevatedButton(
                      child: Text('Back'),
                      onPressed: () {
                        specific = -1;
                        editing = false;
                        setState(() {});
                      },
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size(180, 100)),
                      ),
                    )
                  ],
                ),
              ],
            )
          // general courses
        ],
      ),
    );
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
  int specific = -1;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Timetable input;
}
