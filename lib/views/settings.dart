import 'package:flutter/material.dart';


class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}
class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style:TextStyle(
            fontSize:24.0,
            color:Colors.white,
          ),
        ),
        centerTitle:true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: ListView(
          children: <Widget>[
            Image.asset(
              'assets/images/profile.jpg',
              width: 200.0,
              height: 130.0,
            ),
            Container(
              color: Colors.blue[50],
              height: 100.0,
              child: Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(150, 25, 160, 0),
                            child: Text(
                              "John Doe",
                              style: TextStyle(
                                  fontSize: 22.0,
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            "Beirut, Lebanon",
                            style: TextStyle(
                                fontSize: 17.0, color: Colors.blue.shade700),
                                textAlign: TextAlign.center,
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 30, 0, 0),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.notifications,
                          color: Colors.blueAccent,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Text(
                            "Notifications",
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.blueAccent,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 5, 0, 0),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.settings,
                          color: Colors.blueAccent,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Text(
                            "App Settings",
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.blueAccent,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 5, 0, 0),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.person,
                          color: Colors.blueAccent,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Text(
                            "Account",
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 5, 0, 0),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.help,
                          color: Colors.blueAccent,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Text(
                            "Help",
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
