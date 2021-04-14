import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'ToolMac',
        /*
      theme: ThemeData(
        // put more theme data here later
        primarySwatch: Colors.blue,
      ),
      */
        home: LogInPage() //HomePage(),
        );
  }
}

class LogInPage extends StatefulWidget {
  LogInPage({Key? key}) : super(key: key);

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  void logIn(String username, String password, BuildContext context) {
    // check something here
    if (false) {
      failedMsg = 'Login failed! Please try again later.';
      setState(() {});
    } else {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (BuildContext context) => HomePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    String? failedMsg = this.failedMsg;
    this.failedMsg = null;
    return Scaffold(
      appBar: AppBar(
        title: Text('ToolMac'),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Log In',
                style: TextStyle(
                  fontSize: 36,
                ),
              ),
              TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Your Email',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Field cannot be empty';
                    }
                    return null;
                  },
                  onSaved: (String? value) {
                    email = value;
                  }),
              TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Field cannot be empty';
                    }
                    return null;
                  },
                  onSaved: (String? value) {
                    password = value;
                  }),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Row(
                  children: <Widget>[
                    Text('Don\'t have an account? '),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                            new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    SignUpPage()));
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Validate will return true if the form is valid, or false if
                    // the form is invalid.
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      _formKey.currentState!.reset();
                      logIn(email!, password!, context);
                    }
                  },
                  child: const Text('Submit'),
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size(140, 50)),
                  ),
                ),
              ),
              if (failedMsg != null)
                Text('Authentication failed with the following message: ' +
                    failedMsg)
            ],
          ),
        ),
      ),
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? failedMsg;
  String? email;
  String? password;
}

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  void register(String username, String password, String email,
      String firstName, String lastName) {
    // check something here
    if (false) {
      failedMsg = 'Registeration failed! Please try again later.';
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Registeration complete! Please verify your email before logging in')));
      Navigator.of(context).pushReplacement(new MaterialPageRoute(
          builder: (BuildContext context) => LogInPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    String? failedMsg = this.failedMsg;
    this.failedMsg = null;
    return Scaffold(
      appBar: AppBar(
        title: Text('ToolMac'),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 36,
                ),
              ),
              TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Your Username',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Field cannot be empty';
                    }
                    return null;
                  },
                  onSaved: (String? value) {
                    username = value;
                  }),
              TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Your First Name',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Field cannot be empty';
                    }
                    return null;
                  },
                  onSaved: (String? value) {
                    firstName = value;
                  }),
              TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Your Last Name',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Field cannot be empty';
                    }
                    return null;
                  },
                  onSaved: (String? value) {
                    lastName = value;
                  }),
              TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Your Email',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Field cannot be empty';
                    }
                    return null;
                  },
                  onSaved: (String? value) {
                    email = value;
                  }),
              TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Field cannot be empty';
                    }
                    return null;
                  },
                  onSaved: (String? value) {
                    password = value;
                  }),
              TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Confirm Password',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Field cannot be empty';
                    }
                    return null;
                  },
                  onSaved: (String? value) {
                    confirmPassword = value;
                  }),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Row(
                  children: <Widget>[
                    Text('Already have an account? '),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                            new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    LogInPage()));
                      },
                      child: Text(
                        'Log In',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Validate will return true if the form is valid, or false if
                    // the form is invalid.
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      if (password != confirmPassword) {
                        this.failedMsg =
                            'Your password must match the confirmed password';
                        setState(() {});
                      } else {
                        _formKey.currentState!.reset();
                        register(username!, password!, email!, firstName!,
                            lastName!);
                      }
                    }
                  },
                  child: const Text('Submit'),
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size(140, 50)),
                  ),
                ),
              ),
              if (failedMsg != null)
                Text('Registeration failed with the following message: ' +
                    failedMsg)
            ],
          ),
        ),
      ),
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? failedMsg;
  String? email;
  String? password;
  String? confirmPassword;
  String? username;
  String? firstName;
  String? lastName;
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToolMac'),
      ),
      body: new GestureDetector(
          onTap: () => {FocusScope.of(context).requestFocus(new FocusNode())},
          child: TabBarView(
            controller: _controller,
            children: <Widget>[
              AnnouncementsScreen(),
              TimetableScreen(),
              CalendarScreen(),
              ProfileScreen(),
            ],
          )),
      bottomNavigationBar: Container(
        child: Material(
          color: Colors.indigo,
          child: TabBar(
            controller: _controller,
            tabs: <Tab>[
              Tab(
                text: 'Home',
                icon: Icon(Icons.home),
              ),
              Tab(
                text: 'Timetable',
                icon: Icon(Icons.lock_clock),
              ),
              Tab(
                text: 'Calendar',
                icon: Icon(Icons.calendar_today),
              ),
              Tab(
                text: 'Profile',
                icon: Icon(Icons.settings),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Announcement {
  Announcement(
      {required this.title,
      required this.from,
      required this.created,
      required this.content});

  final String title;
  final String from;
  final DateTime created;
  final String content;
}

class AnnouncementWidget extends StatefulWidget {
  AnnouncementWidget(this.announcement, {Key? key}) : super(key: key);

  @override
  _AnnouncementWidgetState createState() => _AnnouncementWidgetState();

  final Announcement announcement;
}

class _AnnouncementWidgetState extends State<AnnouncementWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: EdgeInsets.all(10),
        child: Card(
            child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              // title
              Text(
                widget.announcement.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
              // from
              Text(
                widget.announcement.from,
              ),
              Text(widget.announcement.created.toString()),
              Text(widget.announcement.content),
            ],
          ),
        )));
  }
}

class AnnouncementsScreen extends StatefulWidget {
  AnnouncementsScreen({Key? key}) : super(key: key);

  @override
  _AnnouncementsScreenState createState() => _AnnouncementsScreenState();
}

class _AnnouncementsScreenState extends State<AnnouncementsScreen>
    with AutomaticKeepAliveClientMixin<AnnouncementsScreen> {
  @override
  bool get wantKeepAlive => true;

  String dateToVerbose(DateTime d) {
    final DateFormat formatter = DateFormat('EEEE, MMMM d, y');
    return formatter.format(d);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var now = DateTime.now();
    return Container(
      child: SingleChildScrollView(
        child: Center(
          child: Column(children: <Widget>[
            Container(
                width: double.infinity,
                margin: EdgeInsets.all(10),
                child: Card(
                    child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: <Widget>[
                      Text(dateToVerbose(now),
                          style: TextStyle(
                            fontSize: 28,
                          )),
                      Text('Day 4',
                          style: TextStyle(
                            fontSize: 28,
                          )),
                    ],
                  ),
                ))),
            AnnouncementWidget(Announcement(
              title: 'THIS IS AN ANNOUNCEMENT',
              from: 'TOOLMAC ADMINS',
              created: DateTime.now(),
              content: 'This is a test.',
            )),
            AnnouncementWidget(Announcement(
              title: 'THIS IS AN ANNOUNCEMENT',
              from: 'TOOLMAC ADMINS',
              created: DateTime.now(),
              content:
                  '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas ut sodales quam. Nam sollicitudin, ex id accumsan commodo, nisi tellus facilisis leo, a egestas elit erat at risus. Maecenas tempus id magna ac pulvinar. Nullam vestibulum suscipit venenatis. Quisque ac eros gravida, finibus odio eget, blandit purus. Donec eget arcu vitae libero laoreet egestas eget nec purus. Ut vel nunc lorem. Sed vel commodo dui, ac aliquam dui. Morbi elementum dignissim placerat.

  Suspendisse a nunc quis sapien auctor tincidunt. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Proin maximus quam sed ligula facilisis efficitur. Mauris viverra libero at tristique mattis. Suspendisse eget lobortis est. Quisque a vestibulum velit. In odio lacus, pellentesque ac risus id, consequat fringilla lorem.

  Etiam sollicitudin porta ligula eu pretium. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus suscipit pharetra turpis, quis pellentesque leo volutpat id. Morbi sed cursus dui. Vestibulum feugiat velit id arcu venenatis, et sodales diam facilisis. Suspendisse tristique maximus vehicula. In ac blandit sem. Aliquam erat volutpat. Vestibulum risus dolor, volutpat sit amet est a, euismod consectetur ante. Nam congue lobortis risus ac auctor. Nunc bibendum maximus laoreet. Donec commodo fringilla purus, eget aliquam enim convallis at. Phasellus vehicula ac est sed interdum.''',
            )),
            AnnouncementWidget(Announcement(
              title: 'THIS IS AN ANNOUNCEMENT',
              from: 'TOOLMAC ADMINS',
              created: DateTime.now(),
              content: 'This is a test.',
            )),
            AnnouncementWidget(Announcement(
              title: 'THIS IS AN ANNOUNCEMENT',
              from: 'TOOLMAC ADMINS',
              created: DateTime.now(),
              content: 'This is a test.',
            )),
            AnnouncementWidget(Announcement(
              title: 'THIS IS AN ANNOUNCEMENT',
              from: 'TOOLMAC ADMINS',
              created: DateTime.now(),
              content: 'This is a test.',
            )),
            AnnouncementWidget(Announcement(
              title: 'THIS IS AN ANNOUNCEMENT',
              from: 'TOOLMAC ADMINS',
              created: DateTime.now(),
              content: 'This is a test.',
            )),
          ]),
        ),
      ),
    );
  }
}

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

class CalendarScreen extends StatefulWidget {
  CalendarScreen({Key? key}) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
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

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with AutomaticKeepAliveClientMixin<ProfileScreen> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      child: Center(
        child: Column(
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Text(
                'Username: ',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'BattleMage0231',
                maxLines: 1,
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Text(
                'Email: ',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'leyang.zou@student.tdsb.on.ca',
                maxLines: 1,
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Text(
                'First Name: ',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Leyang',
                maxLines: 1,
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Text(
                'Last Name: ',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Zou',
                maxLines: 1,
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ]),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: ElevatedButton(
                child: Text('Reset Password'),
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  minimumSize: MaterialStateProperty.all(Size(180, 50)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: ElevatedButton(
                child: Text('Change Username'),
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  minimumSize: MaterialStateProperty.all(Size(180, 50)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: ElevatedButton(
                child: Text('Log Out'),
                onPressed: () {
                  Navigator.of(context).pushReplacement(new MaterialPageRoute(
                      builder: (BuildContext context) => LogInPage()));
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  minimumSize: MaterialStateProperty.all(Size(180, 50)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
