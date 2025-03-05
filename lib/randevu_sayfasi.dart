import 'package:flutter/material.dart';

class RandevuSayfasi extends StatefulWidget {
  const RandevuSayfasi({super.key});

  @override
  State<RandevuSayfasi> createState() => _RandevuSayfasiState();
}

class _RandevuSayfasiState extends State<RandevuSayfasi> {
  @override
  Widget build(BuildContext context) {
   return const Center(child:Text("randevu sayfasıı",style:TextStyle(fontSize:30,color:Colors.black54),),);
  }
}