import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:taskly/model/user.dart';
import 'package:taskly/view/home_page.dart';

class LoginViewModel extends ChangeNotifier {
  void Login(User user, BuildContext context) async {
    var uri = Uri.parse("https://dummyjson.com/user/login");
    var jsonData = jsonEncode(user.toJson());
    var response = await http.post(uri,
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonData);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }
    notifyListeners();
  }
}
