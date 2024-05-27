import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GettingGeoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Получаем разрешение на доступ геолокации...", textAlign: TextAlign.center,),),
    );
  }

}