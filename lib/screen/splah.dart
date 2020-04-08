import 'package:account_app/home.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class Splash extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    startTime();
    super.initState();
  }

  startTime() async {
    var duration = new Duration(seconds: 6);
    return new Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Home()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        child: Column(
          children: <Widget>[_logobuilder(context), _subsBuilder(context)],
        ),
      ),
    );
  }

  Widget _logobuilder(BuildContext context) {
    return Expanded(
        flex: 2,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 40.0,
                  child: Icon(
                    Icons.card_travel,
                    color: Theme.of(context).accentColor,
                    size: 50.0,
                  )),
              SizedBox(
                height: 10.0,
              ),
              Text("ACCOUNTANT", style: Theme.of(context).textTheme.headline1)
            ],
          ),
        ));
  }

  Widget _subsBuilder(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              CircularProgressIndicator(),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Calculation made easy :)",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              SizedBox(
                height: 50.0,
              )
            ],
          ),
        ));
  }
}
