import 'fetch.dart';
import 'dart:convert';

import '../home/announcements/announcement.dart';
import '../home/timetable/timetable.dart';

final Map<String, dynamic> globalStorage = {};

// make API calls to get information
Future<void> init() async {
  // profile
  var res = await getProfile();
  print(res.body);
  globalStorage['profile'] = jsonDecode(res.body);
  // announcements
  /*
  var res2 = await getAnnouncements(100);
  print(res2.body);
  print(globalStorage);
  */
  /*
  globalStorage['announcements'] = <Announcement>[];
  print(globalStorage);
  var res3 = jsonDecode(res2.body);
  globalStorage['announcements'] = <Announcement>[];
  for (var entry in res3) {
    globalStorage['announcements'].add(Announcement(
        title: entry['title'],
        from: entry['origin'],
        created: DateTime.fromMillisecondsSinceEpoch(entry['timestamp']),
        content: entry['content']));
  }
  */
  // calendar
  var res4 = await getCalendar(DateTime.now(), 31);
  globalStorage['calendar'] = jsonDecode(res4.body);
  // timetable
  var res5 = await getTimetable();
  if(res5.statusCode != 200) {
    globalStorage['timetable'] = Timetable(semester: 3, entries: []).toJson();
  } else {
    globalStorage['timetable'] = jsonDecode(res5.body);
  }
}
