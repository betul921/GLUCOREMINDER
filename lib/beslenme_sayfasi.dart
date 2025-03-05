import 'package:flutter/material.dart';

class BeslenmeSayfasi extends StatefulWidget {
  const BeslenmeSayfasi({super.key});

  @override
  State<BeslenmeSayfasi> createState() => _BeslenmeSayfasiState();
}

class _BeslenmeSayfasiState extends State<BeslenmeSayfasi> {
  @override
  Widget build(BuildContext context) {
   return const Center(child:Text("beslenme sayfasıı",style:TextStyle(fontSize:30,color:Colors.black54),),);
  }
}