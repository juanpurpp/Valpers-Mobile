import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:convert';
import 'dart:collection';

bool balance = false;
final ButtonStyle style =
    ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

List<dynamic> selectedMapas = [];

List<dynamic> values = ['Breeze', "Haven", "Split", "Bind", "Dust 2"];

List<dynamic> players = [];

List<PopupMenuItem> menuItems = [];
IO.Socket socket = IO.io('http://localhost:3000', <String, dynamic>{
  'transports': ['websocket'],
});

class Sala extends StatefulWidget {
  const Sala({super.key});

  @override
  _SalaState createState() => _SalaState();
}

class _SalaState extends State<Sala> {
  @override
  // ignore: must_call_super
  initState() {
    // ignore: avoid_print
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
    //
  }

  @override
  dispose() {
    socket.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    (index) => TextFormField(
                        initialValue:
                            index < players.length ? players[index] : null,
                        decoration: const InputDecoration(
                            hintText: 'Username',
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.redAccent),
                            ))))),
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
                const Text('Codigo: AAAA-44BD-2022'),
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
