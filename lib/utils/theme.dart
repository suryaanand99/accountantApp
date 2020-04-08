import 'package:flutter/material.dart';

ThemeData mytheme = ThemeData(
  brightness: Brightness.light,
  backgroundColor: Colors.redAccent,
  primaryColor: Colors.white,
  accentColor: Colors.greenAccent[700],
  textTheme: TextTheme(
    headline1: TextStyle(color: Colors.white, fontSize: 30.0,fontWeight: FontWeight.bold),
    subtitle1: TextStyle(color: Colors.white, fontSize: 18.0,fontWeight: FontWeight.bold),
  ),
);
