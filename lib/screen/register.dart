import 'package:account_app/backend/converthelper.dart';
import 'package:account_app/backend/post.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:account_app/utils/inputdecoration.dart';
import 'package:account_app/utils/loading.dart';
import 'package:flutter/services.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formkey = GlobalKey<FormState>();

  String name = "";
  String email = "";
  String password = "";
  String confirmPassword = "";
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return isloading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _registerLogo(context),
                    SizedBox(
                      height: 20.0,
                    ),
                    _registerform(context)
                  ],
                ),
              ),
            ),
          );
  }

  Widget _registerLogo(BuildContext context) {
    return Column(
      children: <Widget>[
        Icon(
          Icons.person_pin,
          color: Colors.green,
          size: 80.0,
        ),
        Text(
          "Register Your Account",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20.0),
        )
      ],
    );
  }

  Widget _registerform(BuildContext context) {
    return Container(
      child: Form(
          key: _formkey,
          child: Column(
            children: <Widget>[
              _registerName(context),
              SizedBox(
                height: MediaQuery.of(context).size.height / 40,
              ),
              _registerUsername(context),
              SizedBox(
                height: MediaQuery.of(context).size.height / 40,
              ),
              _registerPassword(context),
              SizedBox(
                height: MediaQuery.of(context).size.height / 40,
              ),
              _registerConfirmPassword(context),
              SizedBox(
                height: MediaQuery.of(context).size.height / 40,
              ),
              _registerButton(context),
            ],
          )),
    );
  }

  Padding _registerName(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50.0),
      child: TextFormField(
        style: TextStyle(color: Colors.black),
        decoration: inputTextDoc.copyWith(labelText: "NickName"),
        validator: (val) => val.isEmpty ? "Enter your Name" : null,
        onChanged: (value) {
          setState(() {
            name = value;
          });
        },
      ),
    );
  }

  Padding _registerUsername(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50.0),
      child: TextFormField(
        style: TextStyle(color: Colors.black),
        decoration: inputTextDoc.copyWith(labelText: "UserName"),
        validator: (val) => val.isEmpty ? "Enter your email" : null,
        onChanged: (value) {
          setState(() {
            email = value;
          });
        },
      ),
    );
  }

  Padding _registerPassword(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50.0),
      child: TextFormField(
        style: TextStyle(color: Colors.black),
        obscureText: true,
        decoration: inputTextDoc.copyWith(labelText: "Password"),
        validator: (val) => val.isEmpty ? "Enter your password" : null,
        onChanged: (value) {
          setState(() {
            password = value;
          });
        },
      ),
    );
  }

  Padding _registerConfirmPassword(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50.0),
      child: TextFormField(
        style: TextStyle(color: Colors.black),
        obscureText: true,
        decoration: inputTextDoc.copyWith(labelText: "Confirm Password"),
        validator: (val) =>
            val != password ? "Enter the correct password" : null,
        onChanged: (value) {
          setState(() {
            confirmPassword = value;
          });
        },
      ),
    );
  }

  Widget _registerButton(BuildContext context) {
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
          child: Text("REGISTER", style: Theme.of(context).textTheme.subtitle1),
          onPressed: () async {
            if (_formkey.currentState.validate()) {
              setState(() {
                isloading = true;
              });
              registerToAPI(context, name, email, password);
            }
          },
        ));
  }

  registerToAPI(
      BuildContext context, String name, String email, String password) async {
    User user = await postRegister(name, email, password);
    if (user.statusCode == 201) {
      Resp resp =
          await postCreateAccount(user.accessToken, user.name.name.toString());
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
    } else if (user.statusCode == 400) {
      setState(() {
        isloading = false;
      });
      Fluttertoast.showToast(
          msg: "User already exists",
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
