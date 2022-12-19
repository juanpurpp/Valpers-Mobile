import 'dart:async';

import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:flutter/material.dart';
import 'package:valpersmobile/widgets/Components/Switch.dart';
import 'package:valpersmobile/widgets/Components/mapaCheckbox.dart';

class Sala extends StatelessWidget {
  const Sala({super.key});

  get list => null;
  @override
  Widget build(BuildContext context) {
    List<dynamic> nombres = ['1', '2', '3', '4'];
    List<dynamic> valores = [
      1,
      2,
      3,
      4,
    ];
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        const Expanded(
            child: Center(
          child: Text(
            "Sala",
            style: TextStyle(color: Color(0xFFE74C3C), fontSize: 40.0),
          ),
        )),
        Expanded(
          child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisExtent: 55),
            children: const [
              TextField(
                  decoration: InputDecoration(
                      hintText: 'Username',
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Colors.redAccent),
                      ))),
              TextField(
                  decoration: InputDecoration(
                      hintText: 'Username',
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Colors.redAccent),
                      ))),
              TextField(
                  decoration: InputDecoration(
                      hintText: 'Username',
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Colors.redAccent),
                      ))),
              TextField(
                  decoration: InputDecoration(
                      hintText: 'Username',
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Colors.redAccent),
                      ))),
              TextField(
                  decoration: InputDecoration(
                      hintText: 'Username',
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Colors.redAccent),
                      ))),
              TextField(
                  decoration: InputDecoration(
                      hintText: 'Username',
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Colors.redAccent),
                      ))),
              TextField(
                  decoration: InputDecoration(
                      hintText: 'Username',
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Colors.redAccent),
                      ))),
              TextField(
                  decoration: InputDecoration(
                      hintText: 'Username',
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Colors.redAccent),
                      ))),
              TextField(
                  decoration: InputDecoration(
                      hintText: 'Username',
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Colors.redAccent),
                      ))),
              TextField(
                  decoration: InputDecoration(
                      hintText: 'Username',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  DialogExample(),
                  Text('Balancear'),
                  SwitchExample(),
                ],
              ),
              const Text('Codigo: AAAA-44BD-2022'),
            ])),
      ],
    );
  }
}
