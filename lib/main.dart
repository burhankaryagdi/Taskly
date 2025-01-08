import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskly/view/home_page.dart';
import 'package:taskly/view_model/note_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NoteViewModel(),
      child: const MaterialApp(
        home: AnaSayfa(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}