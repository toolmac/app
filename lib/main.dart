import 'package:flutter/material.dart';

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

class Destination {
  const Destination(this.title, this.icon);
  final String title;
  final IconData icon;

  Widget toWidget() {
    switch(title) {
      case 'Home':
        return Text('HOME SCREEN');
      case 'Timetable':
        return Text('TIMETABLE SCREEN');
      case 'Calendar':
        return Text('CALENDAR SCREEN');
      case 'Profile':
        return Text('PROFILE SCREEN');
    }
    throw Exception('Unexpected destination title');
  }
}

const List<Destination> allDestinations = <Destination>[
  Destination('Home', Icons.home),
  Destination('Timetable', Icons.lock_clock),
  Destination('Calendar', Icons.calendar_today),
  Destination('Profile', Icons.settings),
];

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin<HomePage> {
  List<Widget> screens;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToolMac'),
      ),
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          children: allDestinations.map<Widget>((Destination destination) => destination.toWidget()).toList(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.amber[800],
        backgroundColor: Colors.red,
        type: BottomNavigationBarType.fixed,
        items: allDestinations.map((Destination destination) {
          return BottomNavigationBarItem(
            icon: Icon(destination.icon),
            label: destination.title,
          );
        }).toList(),
      ),
    );
  }
}
