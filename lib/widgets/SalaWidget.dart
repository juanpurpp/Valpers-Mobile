import 'package:flutter/material.dart';

final ButtonStyle style =
    ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

class Sala extends StatelessWidget {
  const Sala({super.key});

  @override
  Widget build(BuildContext context) {
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
                    (index) => const TextField(
                        decoration: InputDecoration(
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
                      style: style,
                      onPressed: () {},
                      child: const Text('Mapa'),
                    ),
                    ElevatedButton(
                      style: style,
                      onPressed: () {},
                      child: const Text('CheckList'),
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
