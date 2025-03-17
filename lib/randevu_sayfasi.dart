import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Gereksiz debug etiketi kaldırıldı
      home: RandevuSayfasi(),
    );
  }
}

class RandevuSayfasi extends StatelessWidget {
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
        actions: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'Randevu Sayfası',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 165,
                  height: 60,
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  child: ElevatedButton(
                    onPressed: () {
                      // Randevu ekleme işlemi
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 169, 235, 235),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text('Randevu Ekle',
                        style: TextStyle(color: Colors.black)),
                  ),
                ),
                Container(
                  width: 165,
                  height: 60,
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  child: ElevatedButton(
                    onPressed: () {
                      // Randevu ekleme işlemi
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 169, 235, 235),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text('Randevu Sil',
                        style: TextStyle(color: Colors.black)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
