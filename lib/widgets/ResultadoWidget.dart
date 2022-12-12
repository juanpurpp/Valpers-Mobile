import 'package:flutter/material.dart';

class Resultado extends StatelessWidget {
  const Resultado({super.key});
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
    return Column(
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
            children: const [
              TextField(
                  enabled: false,
                  decoration: InputDecoration(
                      hintText: 'Juagador 1',
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Colors.redAccent),
                      ))),
              TextField(
                  enabled: false,
                  decoration: InputDecoration(
                      hintText: 'Juagador 1',
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Colors.redAccent),
                      ))),
              TextField(
                  enabled: false,
                  decoration: InputDecoration(
                      hintText: 'Juagador 2',
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Colors.redAccent),
                      ))),
              TextField(
                  enabled: false,
                  decoration: InputDecoration(
                      hintText: 'Juagador 2',
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Colors.redAccent),
                      ))),
              TextField(
                  enabled: false,
                  decoration: InputDecoration(
                      hintText: 'Juagador 3',
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Colors.redAccent),
                      ))),
              TextField(
                  enabled: false,
                  decoration: InputDecoration(
                      hintText: 'Juagador 3',
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Colors.redAccent),
                      ))),
              TextField(
                  enabled: false,
                  decoration: InputDecoration(
                      hintText: 'Juagador 4',
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Colors.redAccent),
                      ))),
              TextField(
                  enabled: false,
                  decoration: InputDecoration(
                      hintText: 'Juagador 4',
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Colors.redAccent),
                      ))),
              TextField(
                  enabled: false,
                  decoration: InputDecoration(
                      hintText: 'Juagador 5',
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Colors.redAccent),
                      ))),
              TextField(
                  enabled: false,
                  decoration: InputDecoration(
                      hintText: 'Juagador 5',
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Colors.redAccent),
                      ))),
            ],
          ),
        ),
        Expanded(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
              const Expanded(
                child: Center(
                  child: Text('Mapa'),
                ),
              ),
              Container(
                child: Image.asset("images/Maps.jpg"),
              ),
            ])),
      ],
    );
  }
}
