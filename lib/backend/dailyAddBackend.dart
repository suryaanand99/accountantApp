import 'package:http/http.dart' as http;
import 'dart:convert';

patchAddDaily(
    int income, int profit, int expenditure, String accessToken) async {
  var url = 'https://accountantapi.herokuapp.com/accounts/today';

  Map data = {'income': income, 'profit': profit, 'expenditure': expenditure};
  //encode Map to JSON
  var body = json.encode(data);

  var response = await http.patch(url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": accessToken
      },
      body: body);

  return response.statusCode;
}
