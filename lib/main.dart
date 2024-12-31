import 'package:flutter/material.dart';
import 'package:taskly/ana_sayfa.dart';
import 'package:taskly/giris_yap_sayfa.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GirisYap(),
      debugShowCheckedModeBanner: false,
    );
  }
}
