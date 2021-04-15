import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'announcement.dart';
import '../../util/storage.dart';

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
            Column(
              children: [
                /*
                for (var announcement in globalStorage['announcements'])
                  AnnouncementWidget(announcement as Announcement),
                */
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
