import 'package:account_app/screen/indexpage.dart';
import 'package:account_app/screen/login.dart';
import 'package:account_app/screen/register.dart';
import 'package:flutter/material.dart';
import 'package:account_app/backend/converthelper.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Resp args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Login());
      case '/register':
        return MaterialPageRoute(builder: (_) => Register());
      case '/index':
        return MaterialPageRoute(
            builder: (_) => Index(
                  accessToken: args.accessToken,
                  dailySummary: args.account.dailySummary,
                  monthlySummary: args.account.monthlySummary,
                  yearlySummary: args.account.yearlySummary,
                  name: args.name,
                ));
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text("ERROR"),
        ),
        body: Text("ERROR"),
      );
    });
  }
}
