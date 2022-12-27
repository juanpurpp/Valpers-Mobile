// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;

String API_URL = dotenv.env['API_URL']!;
String codeSala = "";
IO.Socket socket = IO.io('https://' + API_URL, <String, dynamic>{
  'transports': ['websocket'],
});

class Unirse extends StatelessWidget {
  const Unirse({super.key});
  initState() {
    socket.onConnect((_) {
      print('connected');
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController codeController = TextEditingController();
    final TextEditingController nombreController = TextEditingController();
    return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
          const Text(
            "Unirse",
            style: TextStyle(color: Color(0xFFE74C3C), fontSize: 40.0),
          ),
          Container(
              margin: const EdgeInsets.all(25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: nombreController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Nombre de usuario  ',
                      ),
                    ),
                  ),
                  const DropdownButtonExample(),
                ],
              )),
          Container(
            margin: const EdgeInsets.all(25),
            child: TextField(
              controller: codeController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'ingrese codigo ',
              ),
            ),
          ),
          Container(
              margin: const EdgeInsets.all(25),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                ),
                onPressed: () async {
                  // ignore: use_build_context_synchronously

                  var codeSala = codeController.text;
                  var uri = Uri.https(API_URL, 'matchs', {'invite': codeSala});
                  var res = await http.get(uri);
                  if (res.statusCode == 200) {
                    print('que esta pasaandooo');
                    print(json.encode({
                      "channel": codeSala,
                      "message": nombreController.text
                    }));
                    int nid = json.decode(res.body)["id"];
                    socket.emit('join', {
                      "channel": codeSala,
                      "message": nombreController.text
                    });
                    var team1 = json.decode(res.body)["team1"];
                    var team2 = json.decode(res.body)["team2"];
                    team1 ??= [];
                    team2 ??= [];
                    if (team1.length < 5) {
                      team1.add(
                          {"name": nombreController.text, "rank": "Unranked"});
                    } else if (team2.length < 5) {
                      team2.add(
                          {"name": nombreController.text, "rank": "Unranked"});
                    }
                    var body = json
                        .encode({"id": nid, "team1": team1, "team2": team2});
                    await http.put(uri, body: body, headers: {
                      'Content-Type': 'application/json',
                    });
                    // ignore: use_
                    Navigator.pushNamed(context, '/sala', arguments: {
                      'idMatch': json.decode(res.body)["id"],
                      'entrada': 'unido'
                    });
                  }
                },
                child: const Text(
                  'Unirse a partida',
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
