import 'package:flutter/material.dart';

class MyLobby extends StatelessWidget {
  const MyLobby({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Valpers.gg Mobile')),
        body: Center(child: Column(children: <Widget>[
          Container(
            margin: EdgeInsets.all(25),
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Color(0xFFE74C3C),
              ),
              child:Text('Crear Partida', style:TextStyle(fontSize: 20.0),),
              onPressed: () {},
            )
          ),
          Container(
            margin: EdgeInsets.all(25),
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Color(0xFFE74C3C),
              ),
              onPressed: () {},
              child: const Text('Unirse a Partida', style:TextStyle(fontSize: 20.0),),
            )
          )
        ])
      )       
    );
  }
}