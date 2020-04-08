import 'package:account_app/utils/inputdecoration.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:account_app/backend/dailyAddBackend.dart';

class AddDaily extends StatefulWidget {
  String accessToken;

  AddDaily({this.accessToken});

  @override
  _AddDailyState createState() => _AddDailyState();
}

class _AddDailyState extends State<AddDaily> {
  final _formkey = GlobalKey<FormState>();
  int profit;
  int income;
  int expenditure;
  bool enable = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[_formDaily(context)],
        ),
      ),
    );
  }

  Widget _welcome(BuildContext context){
    
  }

  Widget _formDaily(BuildContext context) {
    return Form(
        key: _formkey,
        child: Column(
          children: <Widget>[
            _getIncome(context),
            SizedBox(
              height: 10.0,
            ),
            _getProfit(context),
            SizedBox(
              height: 10.0,
            ),
            _getExpenditure(context),
            SizedBox(
              height: 10.0,
            ),
            button(context)
          ],
        ));
  }

  TextFormField _getIncome(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      decoration: dailyTextDoc,
      validator: (val) => val.isEmpty ? "Enter the Income" : null,
      onChanged: (value) {
        setState(() {
          income = int.parse(value);
        });
      },
    );
  }

  TextFormField _getProfit(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      decoration: dailyTextDoc.copyWith(labelText: "Profit"),
      validator: (val) => val.isEmpty ? "Enter the Profit" : null,
      onChanged: (value) {
        setState(() {
          profit = int.parse(value);
        });
      },
    );
  }

  TextFormField _getExpenditure(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      decoration: dailyTextDoc.copyWith(labelText: "Expenditure"),
      validator: (val) => val.isEmpty ? "Enter the Expenditure" : null,
      onChanged: (value) {
        setState(() {
          expenditure = int.parse(value);
        });
      },
    );
  }

  Color _getColor(BuildContext context){
    if(enable == false){
      return Colors.white;
    }
    else if(enable == true)
    {
      return Colors.grey[700];
    }
  }

  Widget button(BuildContext context) {
    return SizedBox(
        height: 50.0,
        child: RaisedButton.icon(
          color: _getColor(context),
          icon: Icon(
            Icons.add_circle,
            color: Theme.of(context).backgroundColor,
            size: 35,
          ),
          shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: _getColor(context), width: 1.5, style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(10)),
          disabledColor: Colors.redAccent,
          highlightColor: Colors.redAccent,
          label: Text(
            "ADD",
            style: TextStyle(
                color: Theme.of(context).backgroundColor, fontSize: 20),
          ),
          onPressed: () async {
            if (_formkey.currentState.validate()) {
              setState(() {
                enable = true;
              });
              _addToDataBase(context, income, profit, expenditure);
            }
          },
        ));
  }

  _addToDataBase(
      BuildContext context, int income, int profit, int expenditure) async {
    var status =
        await patchAddDaily(income, profit, expenditure, widget.accessToken);
    setState(() {
      enable = false;
    });   
    if (status == 202) {
      Fluttertoast.showToast(
          msg: "Successfully Added",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.green,
          textColor: Colors.white);
    } else if (status == 401) {
      Navigator.of(context).pushNamed('/');
    } else if (status == 500) {
      Fluttertoast.showToast(
          msg: "Server Error",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.grey[600],
          textColor: Colors.white);
    } else if (status == 401) {
      Navigator.of(context).pushNamed('/');
    }
  }
}
