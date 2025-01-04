import 'package:flutter/material.dart';
import 'package:taskly/giris_yap_sayfa.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: GirisYap(),
      debugShowCheckedModeBanner: false,
    );
  }
}
