import 'package:flutter/material.dart';
import 'package:taskly/model/user.dart';
import 'package:taskly/view_model/login_view_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        //APPBAR KODLAR
        appBar: AppBar(
          title: Text(
            "Giriş Yap!",
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.blue[800],
        ),

        //BODY KODLAR
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Image.asset("assets/login_icon2.png"),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                      labelText: "Kullanıcı Adı",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                      labelText: "Şifre",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  child: Text(
                    "Giriş Yap",
                    style: TextStyle(fontSize: 25, color: Colors.blue[800]),
                  ),
                  onPressed: () {
                    LoginViewModel viewModel = LoginViewModel();
                    viewModel.Login(
                      User(
                          username: usernameController.text,
                          password: passwordController.text),
                      context,
                    );
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
