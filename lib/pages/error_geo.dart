import 'package:flutter/material.dart';

class ErrorGeoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const Scaffold(
      body: Center(child: Text("Произошла ошибка при получении местоположения.\nПожалуйста, разрешите доступ к геолокации.", textAlign: TextAlign.center,),),
    );
  }

}