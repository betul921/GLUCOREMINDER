import 'package:flutter/material.dart';
import 'package:gluco_reminder/bisiklet.dart';
import 'package:gluco_reminder/kosu.dart';
import 'package:gluco_reminder/yurume.dart';
import 'package:gluco_reminder/yuzme.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false, // Debug bandını kaldırma
    home: EgzersizSayfasi(),
  ));
}

class EgzersizSayfasi extends StatefulWidget {
  EgzersizSayfasi({super.key});
  

  final List<Map<String, dynamic>> egzersizler = [
    {'icon': Icons.pool, 'name': 'Yüzme'},
    {'icon': Icons.directions_run, 'name': 'Koşu'},
    {'icon': Icons.directions_walk, 'name': 'Yürüyüş'},
    {'icon': Icons.pedal_bike, 'name': 'Bisiklet'},
  ];

  @override
  State<EgzersizSayfasi> createState() => _EgzersizSayfasi();
}

class _EgzersizSayfasi extends State<EgzersizSayfasi>with SingleTickerProviderStateMixin {
  late AnimationController _heartAnimationController;
int heartRate = 75; // Varsayılan kalp atış hızı (BPM)

@override
void initState() {
  super.initState();
  _heartAnimationController = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 800),
    lowerBound: 0.0,
    upperBound: 1.0,
  )..repeat(reverse: true); // Kalbin sürekli atmasını sağlıyoruz
}

@override
void dispose() {
  _heartAnimationController.dispose();
  super.dispose();
}

  List<Map<String, dynamic>> egzersizVerileri = [];

  double waterLevel = 0.0; // Su seviyesi (litre cinsinden)
  static const double maxWater = 2.0; // Maksimum su seviyesi (2 litre)

  void _increaseWater() {
    setState(() {
      // Su seviyesini 250ml (0.25 litre) artır
      waterLevel = (waterLevel + 0.25).clamp(0.0, maxWater); // Maksimum 2 litre
    });
  }

  double _getTotalCalories() {
    return egzersizVerileri.fold(0.0, (sum, egzersiz) => sum + (egzersiz['calories'] as num).toDouble());
  }

  int _getTotalTime() {
    return egzersizVerileri.fold(0, (sum, egzersiz) => sum + (egzersiz['time'] as num).toInt());
  }

  void _egzersizHesapla(String egzersizAdi) {
    int time = 0; // Dakika cinsinden süre
    double calories = 0.0; // Kalori
    int kilo = 50;
    // ignore: non_constant_identifier_names
    int MET = 0; // Başlangıç değeri atanmalı

    switch (egzersizAdi) {
      case 'Koşu':
        MET = 3;
        time = 30;
        break;
      case 'Yüzme':
        MET = 4;
        time = 30;
        break;
      case 'Yürüyüş':
        MET = 3;
        time = 30;
        break;
      case 'Bisiklet':
        MET = 5;
        time = 30;
        break;
      default:
        return; // Geçersiz seçim
    }
    // Kalori hesaplaması
    calories = (MET * kilo * 3.5 / 200) * time;

    setState(() {
      egzersizVerileri.add({
        'name': egzersizAdi,
        'time': time,
        'calories': calories.toDouble() // double olarak kaydediyoruz
      });
    });
  }

  void _egzersizSec(String egzersizAdi) {
    Widget yeniSayfa;

    switch (egzersizAdi) {
      case 'Koşu':
        yeniSayfa = KosuSayfasi();
        break;
      case 'Yüzme':
        yeniSayfa = YuzmeSayfasi();
        break;
      case 'Yürüyüş':
        yeniSayfa = YurumeSayfasi();
        break;
      case 'Bisiklet':
        yeniSayfa = BisikletSayfasi();
        break;
      default:
        return; // Geçersiz bir seçim olursa fonksiyon sonlanır
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => yeniSayfa),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Egzersiz Sayfası')),
      body: SingleChildScrollView( // İçeriğin taşmasını engellemek için kaydırılabilir alan
        child: Column(
          children: [
            // EGZERSİZLER Başlığı
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: Text(
                  "EGZERSİZLER",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 10),
            // 4 Daire İçin Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: widget.egzersizler.map((egzersiz) {
                return Column(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          _egzersizHesapla(egzersiz['name']); // Kalori ve süre hesapla
                        });
                        _egzersizSec(egzersiz['name']); // Sayfaya yönlendir
                      },
                      borderRadius: BorderRadius.circular(25),
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.grey[300],
                        child: Icon(egzersiz['icon'], size: 24, color: Colors.black),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      egzersiz['name'],
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.none, // Alt çizgi kaldırıldı
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 170,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.pink[200],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(
                          "Toplam Süre: ${_getTotalTime()} dakika",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(width: 30),
                    Container(
                      width: 170,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.pink[200],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(
                          "Toplam Kalori: ${_getTotalCalories()} kcal",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 30),
 Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    // Su Tüketimi Container'ı
    Container(
  width: 175, // Dar bir genişlik
  height: 250, // Uzun bir yükseklik
  padding: EdgeInsets.all(8), // Kenarlardan boşluk
  decoration: BoxDecoration(
    color: Colors.blue[200], // Su için mavi renk
    borderRadius: BorderRadius.circular(15),
  ),
child: Column(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Text(
      "Su Tüketimi",
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
    Expanded(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 60), //  Su animasyonunu biraz yukarı kaydır
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 800),
              width: 100,
              height: 175 * (waterLevel / maxWater),
              decoration: BoxDecoration(
                color: Color.fromRGBO(0, 0, 255, 0.6),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(12),
                  top: Radius.circular(waterLevel > 0 ? 12 : 0),
                ),
              ),
              child: Center(
                child: Text(
                  "${(waterLevel * 1000).toStringAsFixed(0)} ml",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 1,
            child: ElevatedButton(
              onPressed: _increaseWater,
              child: const Text("+250ml"),
            ),
          ),
        ],
      ),
    ),
  ],
),

),

    SizedBox(width: 30), // Aralık
  Container(
  width: 175, // Dar bir genişlik
  height: 250, // Uzun bir yükseklik
  padding: EdgeInsets.all(8), // Kenarlardan boşluk
  decoration: BoxDecoration(
    color: Colors.red[200], // Kalp atışı için kırmızı renk
    borderRadius: BorderRadius.circular(15),
  ),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      // Kalp Atışı Başlığı
      Text(
        "Kalp Atışı",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),

      // Atan Kalp Animasyonu
      Expanded(
        child: AnimatedBuilder(
          animation: _heartAnimationController,
          builder: (context, child) {
            return Transform.scale(
              scale: 1.5 + 0.3 * _heartAnimationController.value, // Büyüyüp küçülen kalp
              child: Icon(
                Icons.favorite,
                color: Colors.red,
                size: 60,
              ),
            );
          },
        ),
      ),

      // Kullanıcının Kalp Atışı Değeri
      Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          "$heartRate bpm", // Dinamik kalp atışı verisi
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    ],
  ),
),
          ],
        ),
        SizedBox(height: 25),
   Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    // Uyku Verisi Container'ı
    Container(
      width: 350, // Genişliği arttırarak yatay bir kutu yapıyoruz
      height: 170, // Yüksekliği biraz daha kısa tutabiliriz
      padding: EdgeInsets.all(8), // Kenarlardan boşluk
      decoration: BoxDecoration(
        color: Colors.purple[200], // Uyku için mor renk
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Uyku Başlığı
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Uyku Süresi",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ),
          SizedBox(height: 50),
          // Gece Sembolü ve Uyku Süresi
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.nightlight_round, // Gece sembolü
                color: Colors.white,
                size: 40,
              ),
              SizedBox(width: 10),
              Text(
                "8h 30m", // Dinamik uyku süresi verisi (örnek)
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ),
          
          // Uyku Grafiksel Sembolü
          Icon(
            Icons.bedtime, // Uyku sembolü
            color: Colors.white,
            size: 60,
          ),
        ],
      ),
    ),
    SizedBox(width: 30), // Aralık
  ],
),

    SizedBox(width: 30), // Aralık
  ],
),

       
     
  

    
      ),
    );
  }
}
