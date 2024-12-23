import 'package:flutter/material.dart';

class AnaSayfa extends StatelessWidget {
  const AnaSayfa({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Taskly",style: TextStyle(fontSize: 30),)),
        backgroundColor: Colors.teal,
      ),
    );
  }
}
