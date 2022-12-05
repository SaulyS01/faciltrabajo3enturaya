import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_basic/models/Juego.dart';
import 'package:http/http.dart' as http;
import '../models/Juego.dart';


class ListadoDeJuegos extends StatefulWidget {
  const ListadoDeJuegos({super.key});

  @override
  State<ListadoDeJuegos> createState() => ListadoDeJuegosState();

}

class ListadoDeJuegosState extends State<ListadoDeJuegos> {
  Future<List<Juego>>? _listadoJuegos;
  String url = 'http://10.0.2.2:8000/api/resultados';

  void saveJuegos(
      nombre,
      jugador1,
      jugador2,
      ganador,
      estado,
      puntos,
      ) async {
    final juego = {
      "nombre": nombre,
      "jugador1": jugador1,
      "jugador2": jugador2,
      "ganador": ganador,
      "estado": estado,
      "puntos": puntos
    };

    final headers = {
      "Content-Type": "application/json"
    };

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(juego),
    );
  }

  Future<List<Juego>> _getJuegos() async {
    final response = await http.get(Uri.parse(url));

    List<Juego> juegos = [];

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);

      for (var item in jsonData["resultados"]) {
        juegos.add(Juego(item["nombre"], item["puntos"], item["estado"], item["ganador"]));
      }

      return juegos;
    } else {
      throw Exception("Falló la conexión");
    }
  }



  @override
  void initState() {
    super.initState();
    _listadoJuegos = _getJuegos();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text('Listado de juegos'),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back))
            ],
          ),
          body: Padding(
              padding: const EdgeInsets.all(32.0),
              child: FutureBuilder(
                future: _listadoJuegos,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print(snapshot.data);
                    return ListView(children: _listJuegos(snapshot.data!));
                  } else if (snapshot.hasError) {
                    print(snapshot.error);
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ))),
    );
  }



  List<Widget> _listJuegos(List<Juego> data) {
    List<Widget> juegos = [];

    for (var juego in data) {
      juegos.add(Container(
        margin: const EdgeInsets.only(bottom: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${juego.nombre}'),
                Text('Ganador: ${juego.ganador}')
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 20.0),
                      child: Text('${juego.puntos}'),
                    ),
                    Container(
                      child: Text('${juego.estado}'),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ));
    }
    return juegos;
  }
}
