import 'dart:ui';

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
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 50,),
            Container(
              child: Image.network(user.picture),
              width: 300,
              height: 300,
            ),
            SizedBox(height: 20,),
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
                    Icons.work,
                    color: Colors.black,
                  ),
                  title: Text(
                    user.profession,
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