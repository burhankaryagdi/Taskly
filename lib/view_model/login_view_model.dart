import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:taskly/model/user.dart';
import 'package:taskly/view/home_page.dart';

class LoginViewModel extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void login(User user, BuildContext context) async {
    //print(user.username);
    //print(user.password);
    setLoading(true);

    var uri = Uri.parse("https://dummyjson.com/user/login");
    var jsonData = jsonEncode(user.toJson());
    var response = await http.post(uri,
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonData);

    //var responseBody = response.body;
    //print(responseBody.toString());

    if (response.statusCode >= 200 && response.statusCode < 300) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    } else if (response.statusCode >= 400 && response.statusCode < 500) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Hatalı Giriş!"),
              content: const Text(
                "Hatalı Kullanıcı Adı veya Şifre Denemesi.",
                style: TextStyle(color: Colors.red),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Kapat"),
                ),
              ],
            );
          });
    }
    setLoading(false);

    notifyListeners();
  }
}
