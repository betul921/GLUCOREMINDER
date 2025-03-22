import 'package:flutter/material.dart';
import 'package:gluco_reminder/profil.dart';
import 'package:gluco_reminder/randevu_ekleme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RandevuSayfasi(),
    );
  }
}

class Randevu {
  final String doktorAdi;
  final String hastaneAdi;
  final String tarih;
  final String saat;
  final String bilgiler;

  Randevu({
    required this.doktorAdi,
    required this.hastaneAdi,
    required this.tarih,
    required this.saat,
    required this.bilgiler,
  });
}

class RandevuSayfasi extends StatefulWidget {
  @override
  _RandevuSayfasiState createState() => _RandevuSayfasiState();
}

class _RandevuSayfasiState extends State<RandevuSayfasi> {
  List<Color> renkler = [
    Color(0xFFFFC68C),
    Color(0xFF5CA695),
    Color(0xFFFFBFB4)
  ]; // 3 farklı renk
  List<Color> randevuRenkleri =
      []; // Eklenen randevuların renklerini saklayan liste
  List<Randevu> randevular = []; // Eklenen randevuları saklayan liste
  int renkIndex = 0; // Sırayla renk seçmek için

  void randevuEkle(Randevu yeniRandevu) {
    setState(() {
      randevular.add(yeniRandevu);
      renkIndex = (renkIndex + 1) % renkler.length;
    });
  }

  void randevuSil(int index) {
    setState(() {
      randevular.removeAt(index); // Belirtilen index'teki randevuyu kaldır
    });
  }

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
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Profil()), //profil sayfasına geçiş
            );
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
            Expanded(
              child: ListView.builder(
                itemCount: randevular.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: renkler[index % renkler.length],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Doktor: ${randevular[index].doktorAdi}",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            Text(
                              "Hastane: ${randevular[index].hastaneAdi}",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            Text(
                              "Tarih: ${randevular[index].tarih}",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            Text(
                              "Saat: ${randevular[index].saat}",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            Text(
                              "Bilgiler: ${randevular[index].bilgiler}",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.white),
                          onPressed: () => randevuSil(index),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RandevuEkleme()),
          );

          if (result != null) {
            randevuEkle(result);
          }
        },
        backgroundColor: Color.fromARGB(255, 79, 210, 210),
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
