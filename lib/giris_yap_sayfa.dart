import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:taskly/ana_sayfa.dart';
import 'package:http/http.dart' as http;

class GirisYap extends StatefulWidget {
  const GirisYap({super.key});

  @override
  State<GirisYap> createState() => _GirisYapState();
}

class _GirisYapState extends State<GirisYap> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool isLoading =false;
  String errorMessage ="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Giriş Yap",
          style: TextStyle(fontSize: 30),
        ),
        leading: Icon(Icons.account_circle),
        centerTitle: true,
        backgroundColor: Colors.blue[800],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/login_icon2.png",
                width: 250,
                height: 200,
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                    labelText: "Kullanıcı Adı",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25))),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: "Şifre",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25))),
              ),
              SizedBox(
                height: 10,
              ),
              if(errorMessage.isNotEmpty)
                Text(
                  errorMessage,style: TextStyle(color: Colors.red),
                ),
              isLoading ? CircularProgressIndicator() :
              ElevatedButton(
                child: Text(
                  "Giriş Yap",
                  style: TextStyle(fontSize: 25, color: Colors.blue[800]),
                ),
                onPressed: () {
                  login(
                    _emailController.text.trim(),
                    _passwordController.text.trim()
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void login(String email, String password) async {
    final url = Uri.parse("https://dummyjson.com/users");
    try {
      final response = await http.get(url); //kullanıcı listesini getiriyor.

      if (response.statusCode == 200) {
        final List users = jsonDecode(response.body)["users"];
        final user = users.firstWhere(
          (user) => user["email"] == email && user["password"] == password,
          orElse: () => null,
        );
        if (user != null) { //Giriş Başarılı ise;
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AnaSayfa()));
        } else {
          // Kullanıcı Bulunamadi ise;
          setState(() {
            errorMessage ="Geçersiz E-posta veya şifre!";
          });
        }
      }
      else{
        //Api hatalı
        setState(() {
          errorMessage = "Sunucu Hatası ${response.statusCode}";
        });
      }
    } catch (e) {
      //Ağ Bağlantısı hatası
      setState(() {
        errorMessage ="Bağlantı Hatası: $e";
      });
    }finally{
      setState(() {
        isLoading = false; //göstergeyi kapat
      });
    }
  }
}
