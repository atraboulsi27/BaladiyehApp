import 'package:flutter/material.dart';

class Taxes extends StatefulWidget{

  @override
  _TaxesState createState() => _TaxesState();
}

class _TaxesState extends State<Taxes>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Taxes"),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Coming Soon in Future Releases...",
                  style: TextStyle(
                    fontSize: 26
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}