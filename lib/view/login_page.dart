import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
        body: Consumer<LoginViewModel>(
          builder: (context, viewModel, child) {
            return SingleChildScrollView(
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
                      child: viewModel.isLoading
                          ? SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.blue[800],
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              "Giriş Yap",
                              style: TextStyle(
                                  fontSize: 25, color: Colors.blue[800]),
                            ),
                      onPressed: viewModel.isLoading
                          ? null
                          : () {
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
            );
          },
        ));
  }
}
