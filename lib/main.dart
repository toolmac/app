import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

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
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
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
      body: TabBarView(
        controller: _controller,
        children: <Widget>[
          AnnouncementsScreen(),
          TimetableScreen(),
          CalendarScreen(),
          SettingsScreen(),
        ],
      ),
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
                text: 'Settings',
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
  Announcement({required this.title, required this.from, required this.created, required this.content});

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
              Text(
                widget.announcement.created.toString()
              ),
              Text(
                widget.announcement.content
              ),
            ],
          ),
        )
      )
    );
  }
}

class AnnouncementsScreen extends StatefulWidget {
  AnnouncementsScreen ({Key? key}) : super(key: key);

  @override
  _AnnouncementsScreenState createState() => _AnnouncementsScreenState();
}

class _AnnouncementsScreenState extends State<AnnouncementsScreen> with AutomaticKeepAliveClientMixin<AnnouncementsScreen> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Center(
              child: Column(children: <Widget>[
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
                  content: '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas ut sodales quam. Nam sollicitudin, ex id accumsan commodo, nisi tellus facilisis leo, a egestas elit erat at risus. Maecenas tempus id magna ac pulvinar. Nullam vestibulum suscipit venenatis. Quisque ac eros gravida, finibus odio eget, blandit purus. Donec eget arcu vitae libero laoreet egestas eget nec purus. Ut vel nunc lorem. Sed vel commodo dui, ac aliquam dui. Morbi elementum dignissim placerat.

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
          ],
        ),
      ),
    );
  }
}

class TimetableScreen extends StatefulWidget {
  TimetableScreen ({Key? key}) : super(key: key);

  @override
  _TimetableScreenState createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> with AutomaticKeepAliveClientMixin<TimetableScreen> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Center(child: Text('Hello, World!'));
  }
}

class CalendarScreen extends StatefulWidget {
  CalendarScreen ({Key? key}) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

class _CalendarScreenState extends State<CalendarScreen> with AutomaticKeepAliveClientMixin<CalendarScreen> {
  @override
  bool get wantKeepAlive => true;

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  List<Event> _getEvents(DateTime? day) {
    if(day == null) {
      return [];
    }
    return [Event('SCHOOL DAY'), Event('SCHOOL DAY'), Event('SCHOOL DAY'), Event('SCHOOL DAY')];
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        TableCalendar<Event>(
          firstDay: DateTime.utc(2020, 10, 16),
          lastDay: DateTime.utc(2021, 10, 14),
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            if(!isSameDay(_selectedDay, selectedDay)) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            }
          },
        ),
        Column(
          children: _getEvents(_selectedDay).map((event) => Text(event.title)).toList()
        )
      ]
    );
  }
}

class SettingsScreen extends StatefulWidget {
  SettingsScreen ({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with AutomaticKeepAliveClientMixin<SettingsScreen> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Center(child: Text('Hello, World!'));
  }
}
