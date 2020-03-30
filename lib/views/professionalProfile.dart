import 'package:flutter/material.dart';
import 'package:baladiyeh/classes/professional.dart';

class DetailPage extends StatelessWidget{
  final Professional user;
  DetailPage(this.user);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
        backgroundColor: Colors.blueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 50.0,
              backgroundImage: NetworkImage(user.picture),
            ),
            Text(
              user.name,
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
            Card(
              color: Colors.white,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: Padding(
                padding: EdgeInsets.all(1.0),
                child: Padding(
                  padding: EdgeInsets.all(1.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.phone,
                      color: Colors.black,
                    ),
                    title: Text(
                      user.phone.toString(),
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    )
                  ),
                ),
              )
            ),
            Card(
              color: Colors.white,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: Padding(
                padding: EdgeInsets.all(1.0),
                child: ListTile(
                  leading: Icon(
                    Icons.email,
                    color: Colors.black,
                  ),
                  title: Text(
                    user.email,
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  )
                ),
              ),
            ),
            Card(
              color: Colors.white,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: Padding(
                padding: EdgeInsets.all(1.0),
                child: ListTile(
                  leading: Icon(
                    Icons.location_city,
                    color: Colors.black,
                  ),
                  title: Text(
                    user.address,
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}