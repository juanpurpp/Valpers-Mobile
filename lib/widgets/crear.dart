import 'package:flutter/material.dart';

class Inicio extends StatelessWidget {
  const Inicio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
        Center(child:

              
        
        Column (mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: <Widget>[

          const Text("Crear", style:TextStyle(color: Color(0xFFE74C3C),fontSize: 40.0),),   //titulo de widget

          Container(                //container con nombre de usuario y dropbox
            margin: const EdgeInsets.all(25),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: const <Widget>[
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Nombre de usuario  ',
                  ),
                ),
              ),
              DropdownButtonExample(),
            ],)

          ),

          Container(),              //container vacio(es para un espacio en blanco)

          Container(                //boton de crear partida
            margin: EdgeInsets.all(25),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
              ),
              onPressed: () {},
              child: const Text('Crear partida', style:TextStyle(fontSize: 20.0),),
            )
          )
        ])
      )       
    );
  } 
}


//dropdown
const List<String> list = <String>['Indefinido','Hierro-1', 'Hierro-2', 'Hierro-3', 'Bronce-1', 'Bronce-2', 'Bronce-3', 'Plata-1',
'Plata-2', 'Plata-3', 'Oro-1', 'Oro-2', 'Oro-3', 'Platino-1', 'Platino-2', 'Platino-3','Diamante-1','Diamante-2','Diamante-3',
'Ascendente-1','Ascendente-2','Ascendente-3','Inmortal-1','Inmortal-2','Inmortal-3','Radiante'];

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