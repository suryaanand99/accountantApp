import 'package:account_app/utils/inputdecoration.dart';
import 'package:flutter/material.dart';
import 'package:account_app/backend/converthelper.dart';
import 'package:account_app/utils/loading.dart';
import 'package:account_app/backend/post.dart';

class Search extends StatefulWidget {
  String accessToken;
  String name;

  Search({this.accessToken, this.name});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<DayObjPro> dailySummary;
  List<DayObjPro> res;
  bool isFetched = false;
  String date;

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  void _fetchData() async {
    Resp resp = await postCreateAccount(widget.accessToken, widget.name);
    if (resp.statusCode == 401) {
      Navigator.of(context).pushNamed('/');
    } else {
      dailySummary = resp.account.dailySummary;
      if (this.mounted) {
        setState(() {
          isFetched = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return isFetched == false ? Loading() : _fetched(context);
  }

  Widget _fetched(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 40),
      child: Column(
        children: <Widget>[
          _searchTop(context),
          Expanded(child: _listViewBuilder(context))
        ],
      ),
    );
  }

  Widget _searchTop(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: <Widget>[
          _searchFeild(context),
          SizedBox(
            height: MediaQuery.of(context).size.height / 40,
          ),
          button(context)
        ],
      ),
    );
  }

  Widget button(BuildContext context) {
    return SizedBox(
        height: 50.0,
        child: RaisedButton.icon(
          color: Colors.white,
          icon: Icon(
            Icons.search,
            color: Theme.of(context).backgroundColor,
            size: 35,
          ),
          shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: Colors.white, width: 1.5, style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(10)),
          disabledColor: Colors.redAccent,
          highlightColor: Colors.redAccent,
          label: Text(
            "Search",
            style: TextStyle(
                color: Theme.of(context).backgroundColor, fontSize: 20),
          ),
          onPressed: () {
            setState(() {
              _results();
            });
          },
        ));
  }

  TextFormField _searchFeild(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      decoration: dailyTextDoc.copyWith(labelText: "Date"),
      validator: (val) => val.isEmpty ? "Enter the date" : null,
      onChanged: (val) {
        setState(() {
          date = val;
        });
      },
    );
  }

  _results() {
    if (date != null) {
      res = [];
      for (int index = 0; index < dailySummary.length; index++) {
        String summaryDate = dailySummary[index].dailyCreatedAt;
        if (summaryDate.contains(date)) {
          res.add(dailySummary[index]);
        }
      }
    }
  }

  Widget _listViewBuilder(BuildContext context) {
    if (res == null) {
      return Container();
    } else if (res.length == 0 && res != null) {
      return Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height / 40,
          ),
          child: Text(
            "* No Results Found *",
            style: Theme.of(context).textTheme.subtitle1,
          ));
    } else if (res != null) {
      return new ListView.builder(
          itemCount: res.length, itemBuilder: _listofAccounts);
    }
  }

  Widget _listofAccounts(BuildContext context, int index) {
    String dailyDate = res[index].dailyCreatedAt;
    int income = res[index].income;
    int profit = res[index].profit;
    int expenditure = res[index].expenditure;
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
                    "Date : " + dailyDate,
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
