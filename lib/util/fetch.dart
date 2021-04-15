import 'package:http/http.dart' as http;
import 'dart:convert';

import 'storage.dart';
import '../home/timetable/timetable.dart';

const String AUTHORITY = "toolmac.patricklin.dev";

Future<http.Response> get(String path) {
  return http.get(Uri.https(AUTHORITY, path), headers: {'Content-type' : 'application/json'});
}

Future<http.Response> getAuth(String path) async {
  var res = globalStorage['token'];
  return http.get(Uri.https(AUTHORITY, path), headers: {'Authorization' : 'Bearer ' + res!});
}

Future<http.Response> postAuth(String path, String body) async {
  var res = globalStorage['token'];
  return http.post(Uri.https(AUTHORITY, path), body: body, headers: {'Content-type' : 'application/json', 'Authorization' : 'Bearer ' + res!});
}

Future<http.Response> post(String path, String body) {
  return http.post(Uri.https(AUTHORITY, path), body: body, headers: {'Content-type' : 'application/json'});
}

Future<void> refresh() async {
  var data = await post('/user/tokenrefresh', jsonEncode({
    'token': globalStorage['refresh'],
  }));
  if(data.statusCode != 200) {
    throw Error();
  }
  var json = jsonDecode(data.body);
  globalStorage['token'] = json['accessToken'];
}

Future<http.Response> postLogIn(String email, String pw) {
  return post('/user/login', jsonEncode({
    'email': email,
    'password': pw,
  }));
}

Future<void> postLogOut() async {
  await post('/user/logout', jsonEncode({
    'token': globalStorage['refresh'],
  }));
  globalStorage.remove('token');
  globalStorage.remove('refresh');
}

Future<http.Response> postSignUp(String username, String password, String firstName, String lastName, String email) {
  return post('/user/register', jsonEncode({
    'username': username,
    'password': password,
    'firstname': firstName,
    'lastname': lastName,
    'email': email,
  }));
}

Future<http.Response> postVerify(String code) {
  return post('/user/verify', jsonEncode({
    'code': code,
  }));
}

Future<http.Response> getProfile() async {
  var value = await getAuth('/profile/get');
  print(value.body);
  if(value.statusCode == 403 || value.statusCode == 401) {
    await refresh();
  } else {
    return value;
  }
  return getAuth('/profile/get');
}

Future<http.Response> getAnnouncements(int amt) async {
  var value = await postAuth('/announcements/get', jsonEncode({
    //'amount': amt,
  }));
  print(value.body);
  if(value.statusCode == 403 || value.statusCode == 401) {
    await refresh();
  } else {
    return value;
  }
  return postAuth('/announcements/get', jsonEncode({
    //'amount': amt,
  }));
}

Future<http.Response> getCalendar(DateTime startDate, int amt) async {
  var value = await postAuth('/calendar/get', jsonEncode({
    'days': amt,
    'startdate': {
      'day': startDate.day,
      'month': startDate.month,
      'year': startDate.year,
    },
  }));
  print(value.body);
  if(value.statusCode == 403 || value.statusCode == 401) {
    await refresh();
  } else {
    return value;
  }
  return postAuth('/calendar/get', jsonEncode({
    'days': amt,
    'startdate': {
      'day': startDate.day,
      'month': startDate.month,
      'year': startDate.year,
    },
  }));
}

Future<http.Response> getTimetable() async {
  var value = await getAuth('/timetable/get');
  if(value.statusCode == 403 || value.statusCode == 401) {
    await refresh();
  } else {
    return value;
  }
  return getAuth('/timetable/get');
}

Future<void> postTimetable(Timetable t) async {
  var value = await postAuth('/timetable/post', jsonEncode({
    'timetable': jsonEncode(t.toJson()),
  }));
  if(value.statusCode == 403 || value.statusCode == 401) {
    await refresh();
  } else {
    return;
  }
  await postAuth('/timetable/post', jsonEncode({
    'timetable': jsonEncode(t.toJson()),
  }));
}
