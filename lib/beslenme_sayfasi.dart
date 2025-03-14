import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BeslenmeSayfasi(),
    );
  }
}

class BeslenmeSayfasi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Başlık "Beslenmelerim" yazısını biraz daha aşağıya almak için bir padding ekledim
            Padding(
              padding: const EdgeInsets.only(top: 30.0), // Başlık için üstten boşluk ekliyoruz
              child: Center(
                child: Text(
                  'Beslenmelerim',
                  style: TextStyle(
                    fontSize: 24, // Yazı boyutunu büyüttüm
                    fontWeight: FontWeight.bold, // Yazıyı kalın yaptım
                  ),
                ),
              ),
            ),
            SizedBox(height: 40), // Başlık ile butonlar arasına boşluk ekledim
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 300,
                  height: 120,
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  child: ElevatedButton(
                    onPressed: () {
                      // Kahvaltı ekleme işlemi
                    },
                    child: Text('Kahvaltı Ekle'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 300,
                  height: 120,
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  child: ElevatedButton(
                    onPressed: () {
                      // Öğle yemeği ekleme işlemi
                    },
                    child: Text('Öğle Yemeği Ekle'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 300,
                  height: 120,
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  child: ElevatedButton(
                    onPressed: () {
                      // Akşam yemeği ekleme işlemi
                    },
                    child: Text('Akşam Yemeği Ekle'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 300,
                  height: 120,
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  child: ElevatedButton(
                    onPressed: () {
                      // Atıştırmalık ekleme işlemi
                    },
                    child: Text('Atıştırmalık Ekle'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
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
