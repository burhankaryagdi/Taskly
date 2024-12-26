import 'package:flutter/material.dart';
import 'package:taskly/ana_sayfa.dart';

void main(){

  runApp(AnaMain());

}

// Class ismini AnaMain yapmak yerine MyApp veya uygulamanın adını yapmak daha iyi olur.
class AnaMain extends StatelessWidget {
  const AnaMain({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnaSayfa(),
      debugShowCheckedModeBanner: false,
    );
  }
}
