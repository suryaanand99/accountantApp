import 'package:account_app/backend/post.dart';
import 'package:account_app/backend/converthelper.dart';
import 'package:account_app/utils/inputdecoration.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:account_app/utils/loading.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formkey = GlobalKey<FormState>();

  String email = "";
  String password = "";
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return isloading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  loginLogo(context),
                  SizedBox(
                    height: 20.0,
                  ),
                  _loginform(context)
                ],
              ),
            ),
          );
  }

  Widget loginLogo(BuildContext context) {
    return Icon(
      Icons.person_pin,
      color: Colors.green,
      size: 80.0,
    );
  }

  Widget _loginform(BuildContext context) {
    return Container(
      child: Form(
          key: _formkey,
          child: Column(
            children: <Widget>[
              _loginUsername(context),
              SizedBox(
              height: MediaQuery.of(context).size.height / 40,
              ),
              _loginPassword(context),
              SizedBox(
              height: MediaQuery.of(context).size.height / 40,
              ),
              loginButton(context),
              SizedBox(
              height: MediaQuery.of(context).size.height / 40,
              ),
              _gotoRegister(context)
            ],
          )),
    );
  }

  Widget _gotoRegister(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Not A Existing User !   ",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18.0),
        ),
        RaisedButton(
          child: Text("REGISTER",
              style: TextStyle(color: Colors.white, fontSize: 18.0)),
          onPressed: () {
            Navigator.pushNamed(context, '/register');
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Colors.red,
        )
      ],
    );
  }

  Padding _loginUsername(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50.0),
      child: TextFormField(
        style: TextStyle(color: Colors.black),
        decoration: inputTextDoc.copyWith(labelText: "UserName"),
        validator: (val) => val.isEmpty ? "Enter the username" : null,
        onChanged: (value) {
          setState(() {
            email = value;
          });
        },
      ),
    );
  }

  Padding _loginPassword(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50.0),
      child: TextFormField(
        style: TextStyle(color: Colors.black),
        obscureText: true,
        decoration: inputTextDoc.copyWith(labelText: "Password"),
        validator: (val) => val.isEmpty ? "Enter the password" : null,
        onChanged: (value) {
          setState(() {
            password = value;
          });
        },
      ),
    );
  }

  Widget loginButton(BuildContext context) {
    return SizedBox(
        height: 50.0,
        child: RaisedButton(
          color: Colors.green,
          shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: Colors.white, width: 2, style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(10)),
          disabledColor: Colors.redAccent,
          highlightColor: Colors.redAccent,
          child: Text("LOGIN", style: Theme.of(context).textTheme.subtitle1),
          onPressed: () async {
            if (_formkey.currentState.validate()) {
              setState(() {
                isloading = true;
              });
              loginToAPI(context, email, password);
            }
          },
        ));
  }

  loginToAPI(BuildContext context, String email, String password) async {
    User user = await postLogin(email, password);

    if (user.statusCode == 200) {
      Resp resp = await postCreateAccount(user.accessToken, user.name.name.toString());
      if (resp.statusCode == 500) {
        setState(() {
          isloading = false;
        });
        Fluttertoast.showToast(
            msg: "Server Error",
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.red,
            textColor: Colors.white);
      } else if (resp.statusCode == 200) {
        Navigator.of(context).pushNamed("/index", arguments: resp);
      }
    } else if (user.statusCode == 401) {
      setState(() {
        isloading = false;
      });
      Fluttertoast.showToast(
          msg: "Unauthorized Access",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.red,
          textColor: Colors.white);
    } else if (user.statusCode == 500) {
      setState(() {
        isloading = false;
      });
      Fluttertoast.showToast(
          msg: "Server Error",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.red,
          textColor: Colors.white);
    }
  }
}
