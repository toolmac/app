import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../login/login.dart';
import '../util/fetch.dart';

class VerifyPage extends StatefulWidget {
  VerifyPage({Key? key}) : super(key: key);

  @override
  _VerifyPageState createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  void verify(String verificationCode) {
    Future<http.Response> res = postVerify(verificationCode);
    res.then(
      (http.Response response) {
        if (response.statusCode != 200) {
          failedMsg = response.body;
          setState(() {});
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Verification complete! You may now log in.')));
          Navigator.of(context).pushReplacement(new MaterialPageRoute(
              builder: (BuildContext context) => LogInPage()));
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
              child: Center(
                  child: Column(
                children: [
                  Text('Verify Your Email', style: TextStyle(fontSize: 24)),
                  TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Verfication Code',
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Field cannot be empty';
                        }
                        return null;
                      },
                      onSaved: (String? value) {
                        verificationCode = value;
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        child: Text('Submit'),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            _formKey.currentState!.reset();
                            verify(verificationCode!);
                          }
                        },
                        style: ButtonStyle(
                          minimumSize:
                              MaterialStateProperty.all(Size(180, 100)),
                        ),
                      ),
                      ElevatedButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              new MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      LogInPage()));
                        },
                        style: ButtonStyle(
                          minimumSize:
                              MaterialStateProperty.all(Size(180, 100)),
                        ),
                      ),
                    ],
                  ),
                  if (failedMsg != null)
                    Text('Verification failed with the following message: ' +
                        failedMsg)
                ],
              )))),
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? failedMsg;
  String? verificationCode;
}
