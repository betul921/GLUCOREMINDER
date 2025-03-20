import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RandevuEkleme(),
    );
  }
}

class RandevuEkleme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Title(color: Colors.black, child: Text("randevu ekleme sayfası")),
    );
  }
}
