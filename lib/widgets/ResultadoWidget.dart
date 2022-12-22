import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:collection';
import 'package:flutter_dotenv/flutter_dotenv.dart';

String API_URL = dotenv.env['API_URL']!;
final ButtonStyle style =
    ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
List team1 = [], team2 = [];
var map, idMatch;

class Resultado extends StatefulWidget {
  const Resultado({super.key});

  @override
  _ResultadoState createState() => _ResultadoState();
}

class _ResultadoState extends State<Resultado> {
  initState() {
    print('INIT STATE');
    var uri = Uri.https(API_URL, 'matchs', {'id': "${idMatch}"});
    http.get(uri).then((res) {
      var decoded = json.decode(res.body);
      print(
          "\n\n\n-----------------------\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
      print(res.body);
      print('decoded:');
      print(decoded);
      team1 = (decoded["team1"] != null) ? decoded["team1"] : [];
      team2 = (decoded["team2"] != null) ? decoded["team2"] : [];
    });
  }

  @override
  Widget build(BuildContext context) {
    print('BUILD CONTEXT');
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    idMatch = arguments['idMatch'];

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          const Expanded(
              child: Center(
            child: Text('Resultado'),
          )),
          Expanded(
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisExtent: 55),
              children: List.generate(
                      team1.length,
                      (index) => TextField(
                          enabled: false,
                          decoration: InputDecoration(
                              hintText: team1[index],
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Colors.redAccent),
                              )))) +
                  List.generate(
                      team2.length,
                      (index) => TextField(
                          enabled: false,
                          decoration: InputDecoration(
                              hintText: team1[index],
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Colors.redAccent),
                              )))),
            ),
          ),
          Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                Expanded(
                  child: Center(
                    child: Text(map),
                  ),
                ),
                Image.asset("images/Maps.jpg"),
              ])),
        ],
      ),
    );
  }
}
