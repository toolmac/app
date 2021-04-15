import 'package:flutter/material.dart';

import '../../login/login.dart';
import '../../util/fetch.dart';
import '../../util/storage.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with AutomaticKeepAliveClientMixin<ProfileScreen> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      child: Center(
        child: Column(
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Text(
                'Username: ',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                globalStorage['profile']['username'],
                maxLines: 1,
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Text(
                'Email: ',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                globalStorage['profile']['email'],
                maxLines: 1,
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Text(
                'First Name: ',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                globalStorage['profile']['firstname'],
                maxLines: 1,
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Text(
                'Last Name: ',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                globalStorage['profile']['lastname'],
                maxLines: 1,
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ]),
            /*
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: ElevatedButton(
                child: Text('Reset Password'),
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  minimumSize: MaterialStateProperty.all(Size(180, 50)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: ElevatedButton(
                child: Text('Change Username'),
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  minimumSize: MaterialStateProperty.all(Size(180, 50)),
                ),
              ),
            ),
            */
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: ElevatedButton(
                child: Text('Log Out'),
                onPressed: () {
                  postLogOut().then((res) {
                    Navigator.of(context).pushReplacement(new MaterialPageRoute(
                      builder: (BuildContext context) => LogInPage()));
                  });
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  minimumSize: MaterialStateProperty.all(Size(180, 50)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
