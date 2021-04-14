import 'package:flutter/material.dart';

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
