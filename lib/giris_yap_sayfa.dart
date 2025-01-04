import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'ana_sayfa.dart';

class GirisYap extends StatefulWidget {
  const GirisYap({super.key});

  @override
  State<GirisYap> createState() => _GirisYapState();
}

class _GirisYapState extends State<GirisYap> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;
  String errorMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Giriş Yap",
          style: TextStyle(fontSize: 30),
        ),
        leading: const Icon(Icons.account_circle),
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
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "Kullanıcı Adı",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Şifre",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              if (errorMessage.isNotEmpty)
                Text(
                  errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      child: Text(
                        "Giriş Yap",
                        style: TextStyle(fontSize: 25, color: Colors.blue[800]),
                      ),
                      onPressed: () {
                        login(
                          _emailController.text.trim(),
                          _passwordController.text,
                          context,
                        );
                      },
                    )
            ],
          ),
        ),
      ),
    );
  }

  void login(String email, String password, BuildContext context) async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse("https://dummyjson.com/users");
    try {
      final response = await http.get(url); //kullanıcı listesini getiriyor.

      if (response.statusCode == 200) {
        final List users = jsonDecode(response.body)["users"];
        final user = users.firstWhere(
          (user) => user["email"] == email && user["password"] == password,
          orElse: () => null,
        );
        if (user != null) {
          //Giriş Başarılı ise;
          if (context.mounted) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AnaSayfa()));
          }
        } else {
          // Kullanıcı Bulunamadi ise;
          setState(() {
            errorMessage = "Geçersiz E-posta veya şifre!";
          });
        }
      } else {
        //Api hatalı
        setState(() {
          errorMessage = "Sunucu Hatası ${response.statusCode}";
        });
      }
    } catch (e) {
      //Ağ Bağlantısı hatası
      setState(() {
        errorMessage = "Bağlantı Hatası: $e";
      });
    } finally {
      setState(() {
        isLoading = false; //göstergeyi kapat
      });
    }
  }
}
