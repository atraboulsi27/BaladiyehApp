import 'package:flutter/material.dart';
import 'package:baladiyeh/theme.dart';
import 'package:baladiyeh/views/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Municipality App',
      theme: Constants.lightTheme,
      home: MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}