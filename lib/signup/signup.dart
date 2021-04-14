import 'package:flutter/material.dart';

import '../login/login.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  void register(String username, String password, String email,
      String firstName, String lastName) {
    // check something here
    if (false) {
      failedMsg = 'Registeration failed! Please try again later.';
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Registeration complete! Please verify your email before logging in')));
      Navigator.of(context).pushReplacement(new MaterialPageRoute(
          builder: (BuildContext context) => LogInPage()));
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
                'Sign Up',
                style: TextStyle(
                  fontSize: 36,
                ),
              ),
              TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Your Username',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Field cannot be empty';
                    }
                    return null;
                  },
                  onSaved: (String? value) {
                    username = value;
                  }),
              TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Your First Name',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Field cannot be empty';
                    }
                    return null;
                  },
                  onSaved: (String? value) {
                    firstName = value;
                  }),
              TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Your Last Name',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Field cannot be empty';
                    }
                    return null;
                  },
                  onSaved: (String? value) {
                    lastName = value;
                  }),
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
              TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Confirm Password',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Field cannot be empty';
                    }
                    return null;
                  },
                  onSaved: (String? value) {
                    confirmPassword = value;
                  }),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Row(
                  children: <Widget>[
                    Text('Already have an account? '),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                            new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    LogInPage()));
                      },
                      child: Text(
                        'Log In',
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
                      if (password != confirmPassword) {
                        this.failedMsg =
                            'Your password must match the confirmed password';
                        setState(() {});
                      } else {
                        _formKey.currentState!.reset();
                        register(username!, password!, email!, firstName!,
                            lastName!);
                      }
                    }
                  },
                  child: const Text('Submit'),
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size(140, 50)),
                  ),
                ),
              ),
              if (failedMsg != null)
                Text('Registeration failed with the following message: ' +
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
  String? confirmPassword;
  String? username;
  String? firstName;
  String? lastName;
}
