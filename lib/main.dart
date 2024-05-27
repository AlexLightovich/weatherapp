import 'package:flutter/material.dart';
import 'package:weatherapp/pages/error_geo.dart';
import 'package:weatherapp/pages/getting_geo.dart';
import 'package:weatherapp/pages/home_page.dart';
import 'package:weatherapp/utils/GetPostion.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geolocator/geolocator.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyApp();
}

class _MyApp extends State<MyApp>{
  String position = "";

  @override
  void initState() {
    _getPosition();
    super.initState();
  }

  void _getPosition() async {
    var s = await GetPositionOfUser().determinePosition().then((Position position) {
        this.position = "${position.latitude},${position.longitude}";
    });
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Colors.deepPurpleAccent, textTheme: GoogleFonts.montserratTextTheme()),
        home: SafeArea(child: (position == "") ? GettingGeoPage() : (position == "Error") ? ErrorGeoPage() : HomePage(position: position,),)
    );
  }
}






