import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class YurumeSayfasi extends StatefulWidget {
  const YurumeSayfasi({super.key});

  @override
  State<YurumeSayfasi> createState() => _YurumeSayfasiState();
}

class _YurumeSayfasiState extends State<YurumeSayfasi>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progress;

  bool _isLoading = true;

  int seconds = 0;
  Timer? timer;
  double calories = 0.0;
  int kilo = 50;
  int metDegeri = 3; // Yürüyüş için MET
  bool _timerRunning = false;
  DateTime? _lastSavedTime;
  int _pausedSeconds = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 30),
    );
    _progress = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.repeat();

    _loadLastSession();
  }

  Future<void> _loadLastSession() async {
    try {
      final query = await FirebaseFirestore.instance
          .collection('yurume_verileri')
          .orderBy('zaman_damgasi', descending: true)
          .limit(1)
          .get();

      if (query.docs.isNotEmpty) {
        final data = query.docs.first.data();
        setState(() {
          _pausedSeconds = int.tryParse(data['zaman'].toString()) ?? 0;
          seconds = _pausedSeconds;
          calories = double.tryParse(data['kalori'].toString()) ?? 0.0;
          _lastSavedTime = data['zaman_damgasi'] is Timestamp
              ? (data['zaman_damgasi'] as Timestamp).toDate()
              : null;

          if ((data['zamanlayici_durum'] ?? false) == true &&
              _lastSavedTime != null) {
            final now = DateTime.now();
            final diff = now.difference(_lastSavedTime!).inSeconds;
            _pausedSeconds += diff;
            seconds = _pausedSeconds;
            startTimer();  // Sayacın devam etmesini sağla
          }
        });
      }
    } catch (e) {
      print("❌ Hata oluştu: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _kaydetYurumeVerisi({bool timerRunning = false}) async {
    try {
      await FirebaseFirestore.instance.collection('yurume_verileri').add({
        'zaman': seconds,
        'kalori': calories,
        'zamanlayici_durum': timerRunning,
        'zaman_damgasi': FieldValue.serverTimestamp(),
      });
      _lastSavedTime = DateTime.now();
      print("✅ Veri kaydedildi: $seconds saniye, $calories kalori");
    } catch (e) {
      print("❌ Veri kaydedilemedi: $e");
    }
  }

  void startTimer() {
    if (_timerRunning) return;

    setState(() {
      _timerRunning = true;
      seconds = _pausedSeconds; // Kaldığı yerden devam et
    });

    timer?.cancel();

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        seconds++;
        _pausedSeconds = seconds;
        calculateCalories();
      });
    });
  }

  void stopTimer() {
    if (!_timerRunning) return;

    timer?.cancel();
    setState(() {
      _timerRunning = false;
      _pausedSeconds = seconds;  // Zamanı durdurduğunda kaydet
    });

    _kaydetYurumeVerisi(timerRunning: false);
  }

  void resetTimer() {
    stopTimer();
    setState(() {
      seconds = 0;
      _pausedSeconds = 0;
      calories = 0.0;
    });
    _kaydetYurumeVerisi(timerRunning: false);
  }

  void calculateCalories() {
    double minutes = seconds / 60.0;
    calories = (metDegeri * kilo * 3.5 / 200) * minutes;
  }

  String get formattedTime {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _controller.dispose();
    timer?.cancel();
    if (_timerRunning) {
      _kaydetYurumeVerisi(timerRunning: true);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.cyan,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  SizedBox(width: 8),
                  Text('Kullanıcı', style: TextStyle(color: Colors.black)),
                ],
              ),
              Text('Yürüyüş Sayfası', style: TextStyle(color: Colors.black)),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Center(
                child: AnimatedBuilder(
                  animation: _progress,
                  builder: (context, child) {
                    return CustomPaint(
                      painter: RingPainter(_progress.value),
                      child: SizedBox(
                        width: 170,
                        height: 170,
                        child: Center(
                          child: Icon(
                            Icons.directions_walk,
                            size: 60,
                            color: Colors.greenAccent,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(16),
                      margin: EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: Colors.green[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      height: 160,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Süre", style: TextStyle(fontSize: 16)),
                          SizedBox(height: 10),
                          Text(formattedTime, style: TextStyle(fontSize: 26)),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(Icons.play_arrow),
                                onPressed: startTimer,
                              ),
                              IconButton(
                                icon: Icon(Icons.pause),
                                onPressed: stopTimer,
                              ),
                              IconButton(
                                icon: Icon(Icons.refresh),
                                onPressed: resetTimer,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(16),
                      margin: EdgeInsets.only(left: 8),
                      decoration: BoxDecoration(
                        color: Colors.green[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      height: 160,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Kalori", style: TextStyle(fontSize: 16)),
                          SizedBox(height: 10),
                          Text("${calories.toStringAsFixed(4)} kcal",
                              style: TextStyle(fontSize: 26)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RingPainter extends CustomPainter {
  final double progress;

  RingPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = 8.0;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - strokeWidth / 2;

    final backgroundPaint = Paint()
      ..color = Colors.green.shade100
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final foregroundPaint = Paint()
      ..color = Colors.greenAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);

    final sweepAngle = 2 * pi * progress;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
        -pi / 2, sweepAngle, false, foregroundPaint);
  }

  @override
  bool shouldRepaint(covariant RingPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
