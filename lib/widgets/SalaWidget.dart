// ignore: file_names
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:collection';
import 'package:flutter_dotenv/flutter_dotenv.dart';

String API_URL = dotenv.env['API_URL']!;

String codigo = " ";
bool balance = false;
final ButtonStyle style =
    ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

List<dynamic> selectedMapas = [];

List<dynamic> values = ['Breeze', "Haven", "Split", "Bind", "Dust 2"];

List<dynamic> players = [];

List<PopupMenuItem> menuItems = [];
IO.Socket socket = IO.io('https://' + API_URL, <String, dynamic>{
  'transports': ['websocket'],
});

class Sala extends StatefulWidget {
  const Sala({super.key});
  initState() {
    builds = 0;
    idMatch = -1;
    inombre = "";
    players = [];
  }

  @override
  _SalaState createState() => _SalaState();
}

int idMatch = -1;
int builds = 0;
String inombre = "";

class _SalaState extends State<Sala> {
  final _controller = [
    for (var i = 0; i < 10; i++) TextEditingController(text: '')
  ];

  @override
  // ignore: must_call_super
  initState() {
    print('Init state');
    builds = 0;
    idMatch = -1;
    inombre = "";
    players = [];
    for (var i = 0; i < players.length; i++) {
      if (players[i] != null) _controller[i].text = players[i];
    }

    // ignore: avoid_print
    //

    //conexión entre los websocket

    //
  }

  @override
  dispose() {
    socket.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    idMatch = arguments['idMatch'];
    if (builds == 0) {
      print('obteniendo anteriores');
      var uri = Uri.https(API_URL, 'matchs', {'id': "${idMatch}"});
      http.get(uri).then((res) {
        var decoded = json.decode(res.body);
        print(
            "\n\n\n-----------------------\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
        print(res.body);
        print('decoded:');
        print(decoded);
        if (decoded["team1"] == null) decoded["team1"] == [];
        if (decoded["team2"] == null) decoded["team2"] == [];
        if (decoded["team1"] != null) {
          for (var p in decoded["team1"]) {
            print('P \n\n');
            print(p);
            players.add(p["name"]);
          }
        }

        for (var p in decoded["team2"]) {
          print('P \n\n');
          print(p);
          players.add(p["name"]);
        }

        setState(() {
          codigo = decoded["invite"];
          print(players);
          for (var i = 0; i < players.length; i++) {
            if (players[i] != null) _controller[i].text = players[i];
          }
          socket.emit('subscribe', codigo);
          print('suscrito al codigo ' + codigo);
        });
      });
      socket.onConnect((_) {
        print('connected');
      });

      //    Cuando se recibe una actualizaciónGET
      socket.on('message', (entrada) {
        // do something with the data received from the server
        print(entrada);
        selectedMapas = entrada['mapas'].toList();
        balance = entrada['balance'];
        setState(() {});
      });
      socket.on('joining', (entrada) async {
        // do something with the data received from the server

        players.add(entrada);

        setState(() {
          for (var i = 0; i < players.length; i++) {
            _controller[i].text = players[i];
          }
        });
      });
    }
    builds++;
    idMatch = arguments['idMatch'];
    print(arguments['idMatch']);
    menuItems = [];
    for (dynamic value in values) {
      menuItems.add(
        CheckedPopupMenuItem(
          checked: selectedMapas.contains(value),
          value: value,
          child: Text(value.toString()),
        ),
      );
    }

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          const Expanded(
              child: Center(
            child: Text('Sala'),
          )),
          Expanded(
            child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, mainAxisExtent: 55),
                children: List.generate(
                    10,
                    (index) => TextField(
                          controller: _controller[index],
                        ))),
          ),
          Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: PopupMenuButton(
                        onSelected: (result) {
                          var envio = {
                            "channel": codigo,
                            "message": {
                              "mapas": selectedMapas,
                              "balance": balance
                            }
                          };
                          setState(() {
                            if (!selectedMapas.contains(result)) {
                              selectedMapas.add(result);
                            } else {
                              selectedMapas.remove(result);
                            }
                            socket.emit('update', envio);
                          });
                        },
                        itemBuilder: (BuildContext context) => menuItems,
                      ),
                    ),
                    Checkbox(
                      value: balance,
                      onChanged: (bool? value) {
                        setState(() {
                          balance = value!;
                          var envio = {
                            "channel": codigo,
                            "message": {
                              "mapas": selectedMapas,
                              "balance": balance
                            }
                          };
                          socket.emit('update', envio);
                        });
                      },
                    ),
                  ],
                ),
                Text("Codigo: $codigo"),
              ])),
          Container(
              margin: EdgeInsets.all(25),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                ),
                onPressed: () async {
                  var body = jsonEncode({
                    "id": idMatch,
                    "map": selectedMapas,
                    "team1": players.sublist(0, (players.length / 2).round()),
                    "team2": players.sublist(
                        (players.length / 2).round(), players.length)
                  });
                  var uri = Uri.https(API_URL, 'matchs',
                      {"balance": "true", "choosemap": "true"});
                  var response = await http.put(uri, body: body, headers: {
                    'Content-Type': 'application/json',
                  });
                  // ignore: use_build_context_synchronously
                  Navigator.pushNamed(context, '/resultado',
                      arguments: {'idMatch': idMatch});
                },
                child: const Text(
                  'Lanzar',
                  style: TextStyle(fontSize: 20.0),
                ),
              ))
        ],
      ),
    );
  }
}
