import 'dart:math';
import 'package:flutter_app_basic/screens/listadoJuegos.dart';

import '../components/CustomButton.dart';
import 'package:flutter/material.dart';
import '../screens/listadoJuegos.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool buttonenabled = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _controllerJ1 = new TextEditingController();
  TextEditingController _controllerJ2 = new TextEditingController();
  List labelList = [" ", " ", " ", " ", " ", " ", " ", " ", " "];
  bool enableDisable = false;
  bool enableDisableTxt = true;
  String turno = "";
  String ganador = "";
  bool clickTurno = false;
  int chance_flag = 0;

  /*getJuegos() async {
    final url = 'http://localhost:4000/api/resultados';

    http.Response response = await http.get(Uri.parse(url));
    debugPrint(response.body);
  }*/

  void btnInicio() {
    labelList.replaceRange(0, 9, ["", "", "", "", "", "", "", "", ""]);
    ganador = "";
    enableDisable = true;
    chance_flag = 0;
    Random rnd = new Random();
    int min = 13, max = 42;
    int r = min + rnd.nextInt(max - min);
    if (r % 2 == 0) {
      turno = "J1:${_controllerJ1.value.text}-(X)";
    } else {
      turno = "J2:${_controllerJ2.value.text}-(O)";
    }
  }

  void btnAnular() {
    labelList.replaceRange(0, 9, ["", "", "", "", "", "", "", "", ""]);
    enableDisable = false;
    turno = "";
  }

  void numClick(String text, int index) {
    setState(() {
      if (text == "") {
        chance_flag += 1;
      }
      start(index);
      matchCheck();
      print(
          "ver txt: ${text} index: ${index} num val: ${labelList[index]} cant:${chance_flag}");
    });
  }

  void start(int index) {
    var parts = turno.split(':');
    if (parts[0].trim() == "J1" && clickTurno == false) {
      labelList[index] = "X";
      clickTurno = true;
      turno = "J2:${_controllerJ2.value.text}-(O)";
    } else {
      labelList[index] = "O";
      clickTurno = false;
      turno = "J1:${_controllerJ1.value.text}-(X)";
    }
  }

  void matchCheck() {
    if ((labelList[0] == "X") &&
        (labelList[1] == "X") &&
        (labelList[2] == "X")) {
      xWins();
    } else if ((labelList[0] == "X") &&
        (labelList[4] == "X") &&
        (labelList[8] == "X")) {
      xWins();
    } else if ((labelList[0] == "X") &&
        (labelList[3] == "X") &&
        (labelList[6] == "X")) {
      xWins();
    } else if ((labelList[1] == "X") &&
        (labelList[4] == "X") &&
        (labelList[7] == "X")) {
      xWins();
    } else if ((labelList[2] == "X") &&
        (labelList[4] == "X") &&
        (labelList[6] == "X")) {
      xWins();
    } else if ((labelList[2] == "X") &&
        (labelList[5] == "X") &&
        (labelList[8] == "X")) {
      xWins();
    } else if ((labelList[3] == "X") &&
        (labelList[4] == "X") &&
        (labelList[5] == "X")) {
      xWins();
    } else if ((labelList[6] == "X") &&
        (labelList[7] == "X") &&
        (labelList[8] == "X")) {
      xWins();
    } else if ((labelList[0] == "O") &&
        (labelList[1] == "O") &&
        (labelList[2] == "O")) {
      oWins();
    } else if ((labelList[0] == "O") &&
        (labelList[3] == "O") &&
        (labelList[6] == "O")) {
      oWins();
    } else if ((labelList[0] == "O") &&
        (labelList[4] == "O") &&
        (labelList[8] == "O")) {
      oWins();
    } else if ((labelList[1] == "O") &&
        (labelList[4] == "O") &&
        (labelList[7] == "O")) {
      oWins();
    } else if ((labelList[2] == "O") &&
        (labelList[4] == "O") &&
        (labelList[6] == "O")) {
      oWins();
    } else if ((labelList[2] == "O") &&
        (labelList[5] == "O") &&
        (labelList[8] == "O")) {
      oWins();
    } else if ((labelList[3] == "O") &&
        (labelList[4] == "O") &&
        (labelList[5] == "O")) {
      oWins();
    } else if ((labelList[6] == "O") &&
        (labelList[7] == "O") &&
        (labelList[8] == "O")) {
      oWins();
    } else if (chance_flag == 9) {
      enableDisable = false;
      ganador = "Empate";
      turno = "Termino";
      enableDisableTxt = true;
      buttonenabled = false;
      //donde se registre el juego
    }
  }

  void xWins() {
    ganador = "J1:${_controllerJ1.value.text}-(X)";
    enableDisable = false;
    turno = "Termino";
    buttonenabled = false;
    enableDisableTxt = true;
  }

  void oWins() {
    ganador = "J2:${_controllerJ2.value.text}-(O)";
    enableDisable = false;
    turno = "Termino";
    buttonenabled = false;
    enableDisableTxt = true;
    //REGISTRAR
  }

  @override
  Widget build(BuildContext context) {
    List funx = [
      numClick,
      numClick,
      numClick,
      numClick,
      numClick,
      numClick,
      numClick,
      numClick,
      numClick
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text("JUEGO DE 3 EN RAYA"),
        elevation: 0,
        backgroundColor: Colors.deepOrangeAccent,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ListadoDeJuegos()));
              },
              icon: Icon(Icons.list))
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 32.0,
            ),
            child: Column(
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5.0,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: TextField(
                              enabled: enableDisableTxt ? true : false,
                              controller: _controllerJ2,
                              decoration: InputDecoration(
                                labelText: 'Jugador 1',
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: TextField(
                              enabled: enableDisableTxt ? true : false,
                              controller: _controllerJ1,
                              decoration: InputDecoration(
                                labelText: "Jugador 2",
                              )),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: <Widget>[
                                ElevatedButton(
                                  onPressed: buttonenabled
                                      ? null
                                      : () {
                                          setState(() {
                                            //setState to refresh UI
                                            if (buttonenabled) {
                                              buttonenabled = false;
                                              //if buttonenabled == true, then make buttonenabled = false
                                            } else {
                                              btnInicio();
                                              enableDisableTxt = false;
                                              buttonenabled = true;
                                              //if buttonenabled == false, then make buttonenabled = true
                                            }
                                          });
                                        },
                                  child: Text('Inicio'),
                                )
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                ElevatedButton(
                                  onPressed: buttonenabled
                                      ? () {
                                          setState(() {
                                            //setState to refresh UI
                                            if (buttonenabled) {
                                              btnAnular();
                                              enableDisableTxt = true;
                                              buttonenabled = false;
                                              //if buttonenabled == true, then make buttonenabled = false
                                            } else {
                                              buttonenabled = true;
                                              //if buttonenabled == false, then make buttonenabled = true
                                            }
                                          });
                                        }
                                      : null,
                                  child: Text('Anular'),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5),
                  children: [
                    ...List.generate(
                      labelList.length,
                      (indexx) => CustomButton(
                        text: labelList[indexx],
                        index: indexx,
                        buttonenabled: enableDisable,
                        callback: funx[indexx] as Function,
                      ),
                    ),
                  ],
                  shrinkWrap: true,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: <Widget>[
                          OutlinedButton(
                              onPressed: null, child: Text('Jugador: $turno'))
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          OutlinedButton(
                              onPressed: null, child: Text('Ganador: $ganador'))
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
