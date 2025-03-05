import 'package:flutter/material.dart';

class IlacSayfasi extends StatefulWidget {
  const IlacSayfasi({super.key});

  @override
  State<IlacSayfasi> createState() => _IlacSayfasiState();
}

class _IlacSayfasiState extends State<IlacSayfasi> {
  @override
  Widget build(BuildContext context) {
    return const Center(child:Text("ilaç sayfasıı",style:TextStyle(fontSize:30,color:Colors.black54),),);
  }
}