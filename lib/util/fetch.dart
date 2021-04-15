import 'package:http/http.dart' as http;
import 'dart:convert';

const String AUTHORITY = "toolmac.patricklin.dev";

Future<http.Response> get(String path) {
  return http.get(Uri.https(AUTHORITY, path));
}

Future<http.Response> post(String path, String body) {
  return http.post(Uri.https(AUTHORITY, path), body: body, headers: {'Content-type' : 'application/json'});
}

Future<http.Response> postLogIn(String email, String pw) {
  return post('/user/login', jsonEncode({
    'email': email,
    'password': pw,
  }));
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
