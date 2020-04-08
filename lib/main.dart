import 'package:flutter/material.dart';
import 'utils/theme.dart';
import 'screen/splah.dart';

// API = https://accountantapi.herokuapp.com

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: mytheme,
    home: Splash(),
  ));
}
