import 'package:flutter/material.dart';
//Se importan los widgets
import 'widgets/Background.dart';
import 'widgets/ResultadoWidget.dart';
import 'widgets/SalaWidget.dart';
import 'widgets/crear.dart';
import 'widgets/unirse.dart';
import 'widgets/inicio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
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
          '/crear': (context) => const Crear(),
          '/unirse': (context) => const Unirse(),
          '/sala': (context) => const Sala(),
          '/resultado': (context) => const Resultado(),
        });
  }
}
