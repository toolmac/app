import 'package:flutter/material.dart';

import '../signup/signup.dart';
import '../home/home.dart';

class LogInPage extends StatefulWidget {
  LogInPage({Key? key}) : super(key: key);

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  void logIn(String username, String password, BuildContext context) {
    // check something here
    if (false) {
      failedMsg = 'Login failed! Please try again later.';
      setState(() {});
    } else {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (BuildContext context) => HomePage()));
    }
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
                    Text('Don\'t have an account? '),
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
