import 'package:flutter/material.dart';

Widget buttonCard(String title, IconData shape, ) {
  return Card(
    color: Colors.white,
    child: Center(child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(shape, size:90.0),
        Text(title, style: TextStyle(fontSize: 16)),
        ]
      ),
    )
  );
}