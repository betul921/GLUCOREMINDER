import 'package:flutter/material.dart';
import 'package:gluco_reminder/profil.dart';
import 'package:gluco_reminder/randevu_ekleme.dart';
import 'package:intl/intl.dart';

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

enum RandevuFiltre { tumu, gecmis, yaklasan }

class Randevu {
  final String doktorAdi;
  final String hastaneAdi;
  final String randevuTuru;
  final String tarih;
  final String saat;
  final String notlar;

  Randevu({
    required this.doktorAdi,
    required this.hastaneAdi,
    required this.randevuTuru,
    required this.tarih,
    required this.saat,
    required this.notlar,
  });
}

class RandevuSayfasi extends StatefulWidget {
  @override
  _RandevuSayfasiState createState() => _RandevuSayfasiState();
}

class _RandevuSayfasiState extends State<RandevuSayfasi> {
  final Color randevuRenk = Color.fromARGB(255, 79, 210, 210);
  List<Randevu> randevular = [];
  RandevuFiltre seciliFiltre = RandevuFiltre.tumu;
  List<Randevu> getFiltrelenmisRandevular() {
    DateTime simdi = DateTime.now();
    DateFormat format = DateFormat("dd.MM.yyyy"); // Türkçe format

    return randevular.where((randevu) {
      try {
        DateTime randevuTarihi = format.parse(randevu.tarih);
        switch (seciliFiltre) {
          case RandevuFiltre.gecmis:
            return randevuTarihi.isBefore(simdi);
          case RandevuFiltre.yaklasan:
            return randevuTarihi.isAfter(simdi);
          case RandevuFiltre.tumu:
          default:
            return true;
        }
      } catch (e) {
        return true;
      }
    }).toList();
  }

  void randevuEkle(Randevu yeniRandevu) {
    setState(() {
      randevular.add(yeniRandevu);
    });
  }

  void randevuSil(int index) {
    setState(() {
      randevular.removeAt(index); // Belirtilen index'teki randevuyu kaldır
    });
  }

  @override
  Widget build(BuildContext context) {
    final filtrelenmisRandevular = getFiltrelenmisRandevular();

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
              MaterialPageRoute(builder: (context) => Profil()),
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
      body: Column(
        children: [
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    seciliFiltre = RandevuFiltre.tumu;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: seciliFiltre == RandevuFiltre.tumu
                      ? Colors.teal
                      : Color.fromARGB(255, 79, 210, 210),
                ),
                child: Text(
                  "Tümü",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    seciliFiltre = RandevuFiltre.yaklasan;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: seciliFiltre == RandevuFiltre.yaklasan
                      ? Colors.teal
                      : Color.fromARGB(255, 79, 210, 210),
                ),
                child: Text(
                  "Yaklaşan",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    seciliFiltre = RandevuFiltre.gecmis;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: seciliFiltre == RandevuFiltre.gecmis
                      ? Colors.teal
                      : Color.fromARGB(255, 79, 210, 210),
                ),
                child: Text(
                  "Geçmiş",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Expanded(
            child: filtrelenmisRandevular.isEmpty
                ? Center(child: Text("Gösterilecek randevu yok."))
                : ListView.builder(
                    itemCount: filtrelenmisRandevular.length,
                    itemBuilder: (context, index) {
                      final randevu = filtrelenmisRandevular[index];
                      return Container(
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: randevuRenk,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Randevu Türü: ${randevu.randevuTuru}",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16)),
                                Text("Tarih: ${randevu.tarih}",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16)),
                                Text("Saat: ${randevu.saat}",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16)),
                              ],
                            ),
                            IconButton(
                              icon: Icon(Icons.arrow_forward_ios,
                                  color: Colors.white),
                              onPressed: () {
                                final orijinalIndex =
                                    randevular.indexOf(randevu);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RandevuDetaySayfasi(
                                      randevu: randevu,
                                      onSil: () {
                                        randevuSil(orijinalIndex);
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
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

class RandevuDetaySayfasi extends StatelessWidget {
  final Randevu randevu;
  final VoidCallback onSil;

  const RandevuDetaySayfasi(
      {super.key, required this.randevu, required this.onSil});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Randevu Detayı")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Doktor: ${randevu.doktorAdi}",
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Text("Hastane: ${randevu.hastaneAdi}",
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Text("Randevu Türü: ${randevu.randevuTuru}",
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Text("Tarih: ${randevu.tarih}", style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Text("Saat: ${randevu.saat}", style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Text("Notlar: ${randevu.notlar}", style: TextStyle(fontSize: 18)),
            Spacer(),
            Center(
              child: ElevatedButton.icon(
                onPressed: onSil,
                icon: Icon(Icons.delete),
                label: Text(
                  "Randevuyu Sil",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
