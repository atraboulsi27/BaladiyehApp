import 'package:flutter/material.dart';
import 'package:baladiyeh/theme.dart';
import 'package:baladiyeh/views/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'All Town App',
      theme: Constants.lightTheme,
      darkTheme: Constants.darkTheme,
      home: MainPage()
    );
  }
}