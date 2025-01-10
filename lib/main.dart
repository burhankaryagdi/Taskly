import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskly/view/login_page.dart';
import 'package:taskly/view_model/login_view_model.dart';
import 'package:taskly/view_model/note_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context)=>NoteViewModel()),
      ChangeNotifierProvider(create: (context)=>LoginViewModel())
    ],
    child: MaterialApp(
        home: LoginPage(),
      debugShowCheckedModeBanner: false,
    ),
    );
  }
}