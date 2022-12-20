// ignore: file_names
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:collection';

String codigo = " ";
bool balance = false;
final ButtonStyle style =
    ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

List<dynamic> selectedMapas = [];

List<dynamic> values = ['Breeze', "Haven", "Split", "Bind", "Dust 2"];

List<dynamic> players = ['xd'];

List<PopupMenuItem> menuItems = [];
IO.Socket socket = IO.io('http://localhost:3000', <String, dynamic>{
  'transports': ['websocket'],
});

class Sala extends StatefulWidget {
  const Sala({super.key});

  @override
  _SalaState createState() => _SalaState();
}

int idMatch = -1;
int builds = 0;

class _SalaState extends State<Sala> {
  final _controller = [
    for (var i = 0; i < 10; i++) TextEditingController(text: '')
  ];

  @override
  // ignore: must_call_super
  void initState() {
    super.initState();
    // ignore: avoid_print
    //

    //conexión entre los websocket

    socket.onConnect((_) {
      print('connected');
    });
    socket.emit('subscribe', 'channel.1');

    //    Cuando se recibe una actualización
    socket.on('message', (entrada) {
      // do something with the data received from the server
      print(entrada);
      selectedMapas = entrada['mapas'].toList();
      balance = entrada['balance'];
      setState(() {});
    });
    socket.on('joining', (entrada) {
      // do something with the data received from the server
      print(entrada);
      players.add(entrada);
      _controller[players.length - 1].text = entrada;
      setState(() {});
    });
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
      var uri = Uri.http('localhost:3000', 'matchs', {'id': "${idMatch}"});
      http.get(uri).then((res) {
        var decoded = json.decode(res.body);
        print(
            "\n\n\n-----------------------\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
        print(res.body);

        setState(() {
          int i = 0;
          for (var p in List.from(decoded["team1"])..addAll(decoded["team2"])) {
            players = [];
            print('\n\n');
            players.add(p["name"]);
            _controller[i].text = p["name"];
            i++;
          }
          codigo = decoded["invite"];
          print(players);
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
                            "channel": "channel.1",
                            "message": {"mapas": selectedMapas}
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
                            "channel": "channel.1",
                            "message": {"mapas": selectedMapas}
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
                onPressed: () {
                  Navigator.pushNamed(context, '/resultado');
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
