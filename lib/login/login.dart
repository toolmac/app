import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../signup/signup.dart';
import '../verify/verify.dart';
import '../home/home.dart';
import '../util/fetch.dart';
import '../util/storage.dart';

class LogInPage extends StatefulWidget {
  LogInPage({Key? key}) : super(key: key);

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  void logIn(String email, String password, BuildContext context) {
    Future<http.Response> res = postLogIn(email, password);
    res.then(
      (http.Response response) {
        if(response.statusCode != 200) {
          if(response.body == '\"Verification required\"') {
            Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (BuildContext context) => VerifyPage()));
          } else {
            failedMsg = response.body;
            setState(() {});
          }
        } else {
          Map<String, dynamic> data = jsonDecode(response.body);
          String token = data["accessToken"];
          String refresh = data["refreshToken"];
          globalStorage['token'] = token;
          globalStorage['refresh'] = refresh;
          init();
          Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (BuildContext context) => HomePage()));
        }
      },
    ).catchError((error) {
      failedMsg = error;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    String? failedMsg = this.failedMsg;
    this.failedMsg = null;
    return Scaffold(
      appBar: AppBar(
        title: Text('ToolMac'),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Log In',
                style: TextStyle(
                  fontSize: 36,
                ),
              ),
              TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Your Email',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Field cannot be empty';
                    }
                    return null;
                  },
                  onSaved: (String? value) {
                    email = value;
                  }),
              TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Field cannot be empty';
                    }
                    return null;
                  },
                  onSaved: (String? value) {
                    password = value;
                  }),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Row(
                  children: <Widget>[
                    Text('Don\'t have an account? ', style: TextStyle(fontSize: 18)),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                            new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    SignUpPage()));
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Validate will return true if the form is valid, or false if
                    // the form is invalid.
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      _formKey.currentState!.reset();
                      logIn(email!, password!, context);
                    }
                  },
                  child: const Text('Submit'),
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size(140, 50)),
                  ),
                ),
              ),
              if (failedMsg != null)
                Text('Authentication failed with the following message: ' +
                    failedMsg)
            ],
          ),
        ),
      ),
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? failedMsg;
  String? email;
  String? password;
}
