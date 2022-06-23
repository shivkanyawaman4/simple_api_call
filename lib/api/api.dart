import 'dart:convert';

import 'package:http/http.dart';

class ApiServices {
  final String postsURL = "https://jsonplaceholder.typicode.com/posts";

  static Future<Map> getPosts() async {
    Response response = await get(Uri.parse('https://reqres.in/api/users'));
    print(response);
    print('Printing in response getPosts');

  
    if (response.statusCode == 200) {
      Map body = jsonDecode(response.body);
      print('Printing in getPosts');

      print(body.length);
      print(body);

      return body;
    } else {
      throw "Unable to retrieve posts.";
    }
  }
}
