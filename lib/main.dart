import 'package:flutter/material.dart';
import 'package:flutter_app_basic/screens/listadoJuegos.dart';
import './screens/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

