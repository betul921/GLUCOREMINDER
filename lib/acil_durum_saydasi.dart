import 'package:flutter/material.dart';

class AcilDurumSayfasi extends StatefulWidget {
  const AcilDurumSayfasi({super.key});

  @override
  State<AcilDurumSayfasi> createState() => _AcilDurumSayfasiState();
}

class _AcilDurumSayfasiState extends State<AcilDurumSayfasi> {
  @override
  Widget build(BuildContext context) {
    return const Center(child:Text("acil ",style:TextStyle(fontSize:30,color:Colors.black54),),);
  }
}