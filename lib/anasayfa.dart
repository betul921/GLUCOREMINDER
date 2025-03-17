import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Gereksiz debug etiketi kaldırıldı
      home: Anasayfa(),
    );
  }
}

class Anasayfa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const CircleAvatar(
            backgroundColor: Color.fromARGB(255, 79, 210, 210),
            child: Icon(Icons.person, color: Colors.white),
          ),
          onPressed: () {
            // Butona basılınca olacak işlemler
          },
        ),
        title: Text('Kullanıcı', style: TextStyle(fontSize: 16)),
      ),
    );
  }
}
