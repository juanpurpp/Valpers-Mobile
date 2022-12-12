import 'package:flutter/material.dart';

final ButtonStyle style =
    ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

class Resultado extends StatelessWidget {
  const Resultado({super.key});
  @override
  Widget build(BuildContext context) {
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
                  10,
                  (index) => TextField(
                      enabled: false,
                      decoration: InputDecoration(
                          hintText: 'Juagador ${index + 1}',
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.redAccent),
                          )))),
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
      ),
    );
  }
}
