import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String name = "", rank = "";

class Crear extends StatelessWidget {
  const Crear({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
          const Text(
            "Crear",
            style: TextStyle(color: Color(0xFFE74C3C), fontSize: 40.0),
          ), //titulo de widget

          Container(
              //container con nombre de usuario y dropbox
              margin: const EdgeInsets.all(25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (text) {
                        name = text;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Nombre de usuario  ',
                      ),
                    ),
                  ),
                  DropdownButtonExample(),
                ],
              )),

          Container(), //container vacio(es para un espacio en blanco)

          Container(
              //boton de crear partida
              margin: const EdgeInsets.all(25),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                ),
                onPressed: () async {
                  var url = Uri.http('localhost:3000', 'matchs');
                  var response = await http.post(url);
                  print('Response status: ${response.statusCode}');
                  print('Response body: ${response.body}');
                  var decoded = json.decode(response.body);
                  var nid = decoded["id"];
                  var body = json.encode({
                    "id": nid,
                    "team1": [
                      {"name": name, "rank": rank}
                    ],
                    "team2": []
                  });
                  await http.put(url, body: body, headers: {
                    'Content-Type': 'application/json',
                  });
                  // ignore: use_build_context_synchronously
                  Navigator.pushNamed(context, '/sala',
                      arguments: {'idMatch': nid});
                },
                child: const Text(
                  'Crear partida',
                  style: TextStyle(fontSize: 20.0),
                ),
              ))
        ])));
  }
}

//dropdown
const List<String> list = <String>[
  'Unranked',
  'Hierro 1',
  'Hierro 2',
  'Hierro 3',
  'Bronce 1',
  'Bronce 2',
  'Bronce 3',
  'Plata 1',
  'Plata 2',
  'Plata 3',
  'Oro 1',
  'Oro 2',
  'Oro 3',
  'Platino 1',
  'Platino 2',
  'Platino 3',
  'Diamante 1',
  'Diamante 2',
  'Diamante 3',
  'Ascendente 1',
  'Ascendente 2',
  'Ascendente 3',
  'Inmortal 1',
  'Inmortal 2',
  'Inmortal 3',
  'Radiante'
];

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.red),
      underline: Container(
        height: 2,
        color: Colors.red,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
          rank = value;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
