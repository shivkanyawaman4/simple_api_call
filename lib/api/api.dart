import 'dart:convert';

import 'package:http/http.dart';

class ApiServices {
  static String baseURL = 'https://reqres.in/api/users';

  static Future<Map> getPosts() async {
    Response response = await get(Uri.parse(baseURL));

    if (response.statusCode == 200) {
      Map body = jsonDecode(response.body);

      return body;
    } else {
      throw "Failed to load data";
    }
  }
}
