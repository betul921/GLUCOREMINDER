import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AcilDurumSayfasi(),
  ));
}

class AcilDurumSayfasi extends StatefulWidget {
  const AcilDurumSayfasi({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AcilDurumSayfasiState createState() => _AcilDurumSayfasiState();
}

class _AcilDurumSayfasiState extends State<AcilDurumSayfasi> {
  List<Map<String, String>> kisiler = [];

  void kisiEkle() {
    String ad = '';
    String soyad = '';
    String yakinlik = '';
    String telefon = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Acil Durum Kişisi"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: "Ad"),
                onChanged: (value) => ad = value,
              ),
              TextField(
                decoration: InputDecoration(labelText: "Soyad"),
                onChanged: (value) => soyad = value,
              ),
              TextField(
                decoration: InputDecoration(labelText: "Yakınlık Derecesi"),
                onChanged: (value) => yakinlik = value,
              ),
              TextField(
                decoration: InputDecoration(labelText: "Telefon Numarası"),
                keyboardType: TextInputType.phone,
                onChanged: (value) => telefon = value,
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text("İptal"),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              child: Text("Ekle"),
              onPressed: () {
                setState(() {
                  kisiler.add({
                    "ad": ad,
                    "soyad": soyad,
                    "yakinlik": yakinlik,
                    "telefon": telefon,
                  });
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void kisiSil(int index) {
    setState(() {
      kisiler.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Acil Durum Sayfası")),
      body: kisiler.isEmpty
          ? Center(child: Text("Kayıtlı acil durum kişisi yok."))
          : ListView.builder(
              itemCount: kisiler.length,
              itemBuilder: (context, index) {
                var kisi = kisiler[index];
                return Card(
                  color: Colors.teal[100],
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text("${kisi['ad']} ${kisi['soyad']}"),
                    subtitle: Text("${kisi['yakinlik']} - ${kisi['telefon']}"),
                    leading: Icon(Icons.person),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => kisiSil(index),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: kisiEkle,
        child: Icon(Icons.add),
      ),
    );
  }
}