import 'package:flutter/material.dart';

import 'login/login.dart';

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
      home: LogInPage(),
    );
  }
}
