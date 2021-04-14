import 'package:flutter/material.dart';

import 'announcements/announcements_screen.dart';
import 'timetable/timetable_screen.dart';
import 'calendar/calendar_screen.dart';
import 'profile/profile_screen.dart';

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
