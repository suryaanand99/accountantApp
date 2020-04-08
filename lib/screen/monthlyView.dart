import 'package:flutter/material.dart';
import 'package:account_app/backend/converthelper.dart';
import 'package:account_app/backend/post.dart';
import 'package:account_app/utils/loading.dart';

class Montly extends StatefulWidget {
  String accessToken;
  String name;

  Montly({this.accessToken,this.name});

  @override
  _MontlyState createState() => _MontlyState();
}

class _MontlyState extends State<Montly> {
  List<MonthlyObjPro> monthlySummary;
  bool isFetched = false;

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  void _fetchData() async {
    Resp resp = await postCreateAccount(widget.accessToken,widget.name);
    if (resp.statusCode == 401) {
      Navigator.of(context).pushNamed('/');
    } else {
      monthlySummary = resp.account.monthlySummary;
      if (this.mounted) {
        setState(() {
          isFetched = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return isFetched == true ? _fetched(context) : Loading();
  }

  Widget _fetched(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _logo(context),
          Expanded(child: _listViewBuilder(context)),
        ],
      ),
    );
  }

  Widget _logo(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.list,
          color: Colors.white,
          size: 50.0,
        ),
        SizedBox(
          width: 10.0,
        ),
        Text(
          "Monthly Summary",
          style: Theme.of(context).textTheme.headline1,
        )
      ],
    );
  }

  Widget _listViewBuilder(BuildContext context) {
    return new ListView.builder(
        itemCount: monthlySummary.length, itemBuilder: _listofAccounts);
  }

  Widget _listofAccounts(BuildContext context, int index) {
    String month = monthlySummary[index].monthlyCreatedAt;
    month = _getMonth(month);
    int income = monthlySummary[index].income;
    int profit = monthlySummary[index].profit;
    int expenditure = monthlySummary[index].expenditure;
    return Card(
      color: Colors.white,
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          height: MediaQuery.of(context).size.height / 7,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Month : " + month.toUpperCase(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    "Income : RS " + income.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black54),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Profit : RS " + profit.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.green),
                  ),
                  Text(
                    "Expenditure : RS " + expenditure.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.red),
                  )
                ],
              ),
            ],
          )),
    );
  }

  String _getMonth(String date) {
    String temp = date.split("-")[1];
    switch (temp) {
      case '01':
        return "January";
        break;
      case '02':
        return "February";
        break;
      case '03':
        return "March";
        break;
      case '04':
        return "April";
        break;
      case '05':
        return "May";
        break;
      case '06':
        return "June";
        break;
      case '07':
        return "July";
        break;
      case '08':
        return "August";
        break;
      case '09':
        return "September";
        break;
      case '10':
        return "October";
        break;
      case '11':
        return "November";
        break;
      case '12':
        return "December";
        break;
    }
  }
}
