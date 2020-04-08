import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:account_app/backend/converthelper.dart';

postRegister(String name, String email, String password) async {
  var url = 'https://accountantapi.herokuapp.com/register';

  Map data = {'name': name, 'email': email, 'password': password};
  //encode Map to JSON
  var body = json.encode(data);

  var response = await http.post(url,
      headers: {"Content-Type": "application/json"}, body: body);

  User user;
  if (response.statusCode == 201) {
    final jsonResponse = json.decode(response.body);
    user = new User.fromJson(jsonResponse);
  } else if (response.statusCode == 400 || response.statusCode == 500) {
    user = new User(accessToken: null, statusCode: response.statusCode);
  }
  return user;
}

postLogin(String email, String password) async {
  var url = 'https://accountantapi.herokuapp.com/login';

  Map data = {'email': email, 'password': password};
  //encode Map to JSON
  var body = json.encode(data);

  var response = await http.post(url,
      headers: {"Content-Type": "application/json"}, body: body);

  User user;
  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    user = new User.fromJson(jsonResponse);
  } else if (response.statusCode == 401 || response.statusCode == 500) {
    user = new User(accessToken: null, statusCode: response.statusCode);
  }
  return user;
}

postCreateAccount(String accessToken) async {
  var url = 'https://accountantapi.herokuapp.com/accounts/';

  var response = await http.post(url, headers: {"Authorization": accessToken});
  final jsonResponse = json.decode(response.body);
  //do with Resp
  Resp resp;
  if (response.statusCode == 200) {
    resp = new Resp.fromJson(jsonResponse, response.statusCode, accessToken);
  } else if (response.statusCode == 500 || response.statusCode == 401) {
    resp = new Resp(
        account: null, statusCode: response.statusCode, accessToken: null);
  }
  return resp;
}
