import 'package:flutter/material.dart';
import 'package:proyectofinal/pages/Login.dart';
import 'package:proyectofinal/pages/registro.dart';
import 'package:proyectofinal/pages/principal.dart';
import 'package:proyectofinal/pages/pantallaEstudiantes.dart';
import 'package:proyectofinal/pages/PantallaNotas.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Login",
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      routes: <String, WidgetBuilder>{
        '/Login': (context) => LoginPage(),
        '/registro': (context) => const RegisterPage(),
        '/principal': (context) => principalPages(cedula: '', nombre: ''),
        '/ListaEstudiantes': (context) => Detail(),
        '/AgregarNotas': (context) =>
            Notas(id: '', cedula: '', list: const [], nombreDato: ''),
      },
    );
  }
}
