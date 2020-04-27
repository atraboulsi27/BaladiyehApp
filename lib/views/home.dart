import 'package:flutter/material.dart';
import 'package:baladiyeh/views/generalnews.dart';
import 'package:baladiyeh/views/calendar.dart';
import 'package:baladiyeh/views/forms.dart';
import 'package:baladiyeh/views/businessDirectory.dart';
import 'package:baladiyeh/views/complaints.dart';
import 'package:baladiyeh/views/settings.dart';
import 'package:baladiyeh/widgets/buttonMenu.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}
class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Zgharta Municipality"),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body:Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(10, 100, 30, 30)
            ),
            Row(children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onTap:() {
                    Navigator.push(context, 
                      new MaterialPageRoute(
                        builder: (context) => News("General")
                      )
                    );
                  },
                  child: buttonCard("News", Icons.library_books),
                )
              ),
              Expanded(
                child: GestureDetector(
                  onTap:() {
                    Navigator.push(context, 
                      new MaterialPageRoute(
                        builder: (context) => Calendar()
                      )
                    );
                  },
                  child: buttonCard("Calendar", Icons.calendar_today),
                )
              ),
              Expanded(
                child: GestureDetector(
                  onTap:() {
                    // Navigator.push(context, 
                    //   new MaterialPageRoute(
                    //     builder: (context) => Forms()
                    //   )
                    // );
                  },
                  child: buttonCard("Taxes", Icons.monetization_on),
                )
              ),
              ],
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(10, 40, 30, 30)
            ),
            Row(children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onTap:() {
                    Navigator.push(context, 
                      new MaterialPageRoute(
                        builder: (context) => Forms()
                      )
                    );
                  },
                  child: buttonCard("Forms", Icons.description),
                )
              ),
              Expanded(
                child: GestureDetector(
                  onTap:() {
                    // Navigator.push(context, 
                    //   new MaterialPageRoute(
                    //     builder: (context) => News()
                    //   )
                    // );
                  },
                  child: buttonCard("Municipal Board", Icons.account_balance),
                )
              ),
              Expanded(
                child: GestureDetector(
                  onTap:() {
                    Navigator.push(context, 
                      new MaterialPageRoute(
                        builder: (context) => BusinessDirectory()
                      )
                    );
                  },
                  child: buttonCard("Business Directory", Icons.business_center),
                )
              ),
            ],
          ),
            Padding(
                padding: EdgeInsets.fromLTRB(10, 40, 30, 30)
            ),
            Row(children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onTap:() {
                    // Navigator.push(context, 
                    //   new MaterialPageRoute(
                    //     builder: (context) => News()
                    //   )
                    // );
                  },
                  child: buttonCard("Town", Icons.location_city),
                )
              ),
              Expanded(
                child: GestureDetector(
                  onTap:() {
                    Navigator.push(context, 
                      new MaterialPageRoute(
                        builder: (context) => Complaints()
                      )
                    );
                  },
                  child: buttonCard("Complaints", Icons.assignment),
                )
              ),
              Expanded(
                child: GestureDetector(
                  onTap:() {
                    Navigator.push(context, 
                      new MaterialPageRoute(
                        builder: (context) => Settings()
                      )
                    );
                  },
                  child: buttonCard("Settings", Icons.settings),
                )
              ),
            ],
          ),
        ],
      )
    );
  }
}

