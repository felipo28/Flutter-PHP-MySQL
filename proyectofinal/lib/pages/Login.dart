import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:proyectofinal/pages/Principal.dart';

String username = '';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isHidden = true;

  TextEditingController user = new TextEditingController();
  TextEditingController pass = new TextEditingController();
  String mensaje = '';

  Future<List> login() async {
    var url = "http://192.168.20.39/ejerciciofinal/login.php";
    var response = await http.post(Uri.parse(url), body: {
      "username": user.text,
      "password": pass.text,
    });

    var datauser = json.decode(response.body);
    if (datauser.length == 0) {
      Fluttertoast.showToast(
          msg: "El usuario o contraseña estan incorrectos.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => principalPages(
              cedula: datauser[0]['cedula'],
              nombre: datauser[0]['nombre'] + " " + datauser[0]['apellidos']),
        ),
      );
      //Navigator.pushReplacementNamed(context, '/principal');
      setState(() {
        username = datauser[0]['usuario'];
      });
    }
    return datauser;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("imagenes/fondovariado.jpg"),
                    opacity: 100.0,
                    fit: BoxFit.cover)),
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 25.0),
                  _AppLogo(),
                  const SizedBox(height: 15.0),
                  _userTextField(),
                  const SizedBox(height: 15.0),
                  _passWordTextField(),
                  const SizedBox(height: 30.0),
                  _bottonLogin(),
                  const SizedBox(height: 20.0),
                  _bottonRegistro(),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _AppLogo() {
    return const Image(
      height: 130.0,
      image: AssetImage(
        'imagenes/logo.png',
      ),
    );
  }

  Widget _userTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: TextFormField(
          controller: user,
          validator: _validateRequired,
          decoration: const InputDecoration(
            filled: true,
            fillColor: Color.fromARGB(255, 255, 255, 255),
            prefixIcon: Icon(
              Icons.email,
              color: Color.fromARGB(209, 70, 60, 181),
            ),
            hintText: "Usuario docente",
            labelText: "Usuario docente",
            labelStyle: TextStyle(color: Colors.black),
          ),
          onChanged: (value) {},
        ),
      );
    });
  }

  Widget _passWordTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: TextFormField(
          controller: pass,
          validator: _validateRequired,
          obscureText: isHidden,
          decoration: InputDecoration(
              filled: true,
              fillColor: Color.fromARGB(255, 255, 255, 255),
              prefixIcon: const Icon(
                Icons.lock,
                color: Color.fromARGB(209, 70, 60, 181),
              ),
              hintText: "Contraseña",
              labelText: "Contraseña",
              labelStyle: TextStyle(color: Colors.black),
              suffixIcon: IconButton(
                alignment: Alignment.bottomCenter,
                icon: isHidden
                    ? const Icon(Icons.visibility_off)
                    : const Icon(
                        Icons.visibility,
                        color: Color.fromARGB(209, 70, 60, 181),
                      ),
                onPressed: togglePasswordVisibility,
              )),
          onChanged: (value) {},
        ),
      );
    });
  }

  void togglePasswordVisibility() => setState(() => isHidden = !isHidden);

  Widget _bottonLogin() {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: const Text(
              "Iniciar Sesion",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 10.0,
          color: const Color.fromARGB(209, 70, 60, 181),
          onPressed: () {
            _save();
          },
        );
      },
    );
  }

  Widget _bottonRegistro() {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: Text(
              "Crear cuenta",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 10.0,
          color: const Color.fromARGB(209, 70, 60, 181),
          onPressed: () {
            Navigator.pushNamed(context, '/registro');
          },
        );
      },
    );
  }

  String _validateRequired(String value) {
    if (value == null || value.isEmpty) return 'El dato es requerido';
    return null;
  }

  void _save() {
    if (_formKey.currentState.validate()) {
      login();
    } else {
      print('Error');
    }
  }
}
