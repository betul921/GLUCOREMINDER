import 'package:flutter/material.dart';
import 'package:gluco_reminder/randevu_sayfasi.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RandevuEkleme(),
    );
  }
}

class RandevuEkleme extends StatefulWidget {
  const RandevuEkleme({super.key});

  @override
  _RandevuEklemeState createState() => _RandevuEklemeState();
}

class _RandevuEklemeState extends State<RandevuEkleme> {
  TextEditingController _doktorAdiController = TextEditingController();
  TextEditingController _hastaneAdiController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _bilgilerController = TextEditingController();

  // 📌 Tarih seçme fonksiyonu
  Future<void> _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _dateController.text =
            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
    }
  }

  // 📌 Saat seçme fonksiyonu
  Future<void> _pickTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        _timeController.text = "${pickedTime.hour}:${pickedTime.minute}";
      });
    }
  }

  void _kaydet() {
    Randevu yeniRandevu = Randevu(
      doktorAdi: _doktorAdiController.text,
      hastaneAdi: _hastaneAdiController.text,
      tarih: _dateController.text,
      saat: _timeController.text,
      bilgiler: _bilgilerController.text,
    );

    Navigator.pop(context, yeniRandevu); // Randevu bilgilerini geri döndür
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Randevu Ekleme',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _doktorAdiController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 79, 210, 210),
                      width: 2), // Normal durumdaki kenarlık rengi
                  borderRadius:
                      BorderRadius.circular(10), // Kenarları yuvarlak yap
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.green,
                      width: 2), // Tıklanınca kenarlık rengi
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: "Doktor Adı:",
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Butonları ortalamak için
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.zero,
                    minimumSize: Size(170, 100),
                  ),
                  child: Image.asset(
                    'assests/images/doktor_erkek.png', // Burada 'assests' yerine 'assets' olmalı
                    width: 170,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),

                SizedBox(width: 20), // Butonlar arasında 20 birim boşluk ekler

                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.zero,
                    minimumSize: Size(170, 100),
                  ),
                  child: Image.asset(
                    'assests/images/doktor_kadin.png', // Burada da 'assests' yerine 'assets' olmalı
                    width: 170,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _hastaneAdiController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 79, 210, 210), width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: "Hastane/ Poliklinik Adı:",
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Butonları ortalamak için
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.zero,
                    minimumSize: Size(170, 100),
                  ),
                  child: Image.asset(
                    'assests/images/hastane.png', // Burada 'assests' yerine 'assets' olmalı
                    width: 170,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),

                SizedBox(width: 20), // Butonlar arasında 20 birim boşluk ekler

                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.zero,
                    minimumSize: Size(170, 100),
                  ),
                  child: Image.asset(
                    'assests/images/saglik_ocagi.png', // Burada da 'assests' yerine 'assets' olmalı
                    width: 170,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _dateController,
              readOnly: true,
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.calendar_today),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 79, 210, 210), width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: "Tarih",
              ),
              onTap: _pickDate,
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _timeController,
              readOnly: true,
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.access_time),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 79, 210, 210), width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: "Saat:",
              ),
              onTap: _pickTime,
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 79, 210, 210), width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: "Randevu Bilgileri:",
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _kaydet,
        backgroundColor: Color.fromARGB(255, 79, 210, 210),
        child: Text('Kaydet', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
