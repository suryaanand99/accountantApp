import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:account_app/backend/converthelper.dart';
import 'addDaily.dart';
import 'monthlyView.dart';
import 'yearlyView.dart';
import 'search.dart';
import 'package:flutter/services.dart';

class Index extends StatefulWidget {
  final List<DayObjPro> dailySummary;
  final List<MonthlyObjPro> monthlySummary;
  final List<YearlyObjPro> yearlySummary;
  final String accessToken;

  Index(
      {this.accessToken,
      this.dailySummary,
      this.monthlySummary,
      this.yearlySummary});

  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  AddDaily _addDaily = AddDaily();
  Montly _monthly = Montly();
  Yearly _yearly = Yearly();
  Search _search = Search();

  int pageIndex = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  Widget _showpage;

  @override
  void initState() {
    initializeObj();
    _showpage = _addDaily;
    super.initState();
  }

  void initializeObj() {
    //addDaily
    _addDaily.accessToken = widget.accessToken;
    //Monthly
    _monthly.accessToken = widget.accessToken;
    //Yearly
    _yearly.accessToken = widget.accessToken;
    //search
    _search.accessToken = widget.accessToken;
  }

  Widget _pageChooser(int page) {
    switch (page) {
      case 0:
        initializeObj();
        return _addDaily;
        break;
      case 1:
        initializeObj();
        return _monthly;
        break;
      case 2:
        initializeObj();
        return _yearly;
        break;
      case 3:
        initializeObj();
        return _search;
        break;
      default:
        return Container(
          child: Text("Page Not Found"),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: pageIndex,
        height: 50.0,
        items: <Widget>[
          Icon(Icons.add, size: 30),
          Icon(Icons.list, size: 30),
          Icon(Icons.calendar_today, size: 30),
          Icon(Icons.search, size: 30),
        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Theme.of(context).backgroundColor,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (int tappedIndex) {
          setState(() {
            _showpage = _pageChooser(tappedIndex);
          });
        },
      ),
      body: _showpage,
    );
  }
}
