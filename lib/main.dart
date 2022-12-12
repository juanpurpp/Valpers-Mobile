import 'package:flutter/material.dart';
//Se importan los widgets
import 'package:valpersmobile/widgets/unirse.dart';

import 'package:valpersmobile/widgets/Background.dart';
import 'package:valpersmobile/widgets/ResultadoWidget.dart';
import 'package:valpersmobile/widgets/SalaWidget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Valpers',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.red,
      ),
      initialRoute: '/',
      //Aqui agregar las rutas de los widgets, primero hay que importarlo más arriba
      routes: {
        '/': (context) => const Inicio(),
      },
      home: const MyHomePage(title: 'Valpers.gg'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Stack(
        children: const <Widget>[
          Resultado(),
        ],
      )),
    );
  }
}
