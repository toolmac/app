import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'announcement.dart';

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
