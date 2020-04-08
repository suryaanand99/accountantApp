import 'package:flutter/material.dart';
import 'package:account_app/backend/converthelper.dart';
import 'package:account_app/utils/loading.dart';
import 'package:account_app/backend/post.dart';

class Yearly extends StatefulWidget {
  String accessToken;

  Yearly({this.accessToken});

  @override
  _YearlyState createState() => _YearlyState();
}

class _YearlyState extends State<Yearly> {
  List<YearlyObjPro> yearlySummary;
  bool isFetched = false;

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  void _fetchData() async {
    Resp resp = await postCreateAccount(widget.accessToken);
    if (resp.statusCode == 401) {
      Navigator.of(context).pushNamed('/');
    } else {
      yearlySummary = resp.account.yearlySummary;
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
          Icons.calendar_today,
          color: Colors.white,
          size: 50.0,
        ),
        SizedBox(
          width: 10.0,
        ),
        Text(
          "Yearly Summary",
          style: Theme.of(context).textTheme.headline1,
        )
      ],
    );
  }

  Widget _listViewBuilder(BuildContext context) {
    return new ListView.builder(
        itemCount: yearlySummary.length, itemBuilder: _listofAccounts);
  }

  Widget _listofAccounts(BuildContext context, int index) {
    int year = yearlySummary[index].year;
    int income = yearlySummary[index].income;
    int profit = yearlySummary[index].profit;
    int expenditure = yearlySummary[index].expenditure;
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
                    "Year : " + year.toString(),
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
}
