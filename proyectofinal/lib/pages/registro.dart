import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

String username = '';
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nombre = TextEditingController();
  TextEditingController apellidos = TextEditingController();
  TextEditingController usuario = TextEditingController();
  TextEditingController cedula = TextEditingController();
  TextEditingController correo = TextEditingController();
  TextEditingController clave = TextEditingController();
  TextEditingController confirmarClave = TextEditingController();

  String mensaje = '';
  var urlBuscarUsuario =
      "http://192.168.20.39/ejerciciofinal/busquedaUsuario.php";
  var urlBuscarCedula =
      "http://192.168.20.39/ejerciciofinal/busquedaCedula.php";
  var urlAgregar = "http://192.168.20.39/ejerciciofinal/registro.php";

  Future<List> Registro() async {
    var response = await http.post(Uri.parse(urlBuscarUsuario), body: {
      "usuario": usuario.text,
    });
    var datauser = json.decode(response.body);

    if (datauser.length != 0) {
      Fluttertoast.showToast(
          msg: "El usuario ya existe.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      var response = await http.post(Uri.parse(urlBuscarCedula), body: {
        "cedula": cedula.text,
      });
      var datacedula = json.decode(response.body);
      if (datacedula.length != 0) {
        Fluttertoast.showToast(
            msg: "La cedula ya existe.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        if (clave.text != confirmarClave.text) {
          Fluttertoast.showToast(
              msg: "Las contraseñas no coinciden",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          http.post(Uri.parse(urlAgregar), body: {
            "nombre": nombre.text,
            "apellidos": apellidos.text,
            "usuario": usuario.text,
            "cedula": cedula.text,
            "correo": correo.text,
            "clave": clave.text,
          });
          Fluttertoast.showToast(
              msg: "Se registro Exitosamente.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.lightGreen,
              textColor: Colors.white,
              fontSize: 16.0);
          Navigator.pop(context);
        }
      }
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
                    opacity: 100,
                    fit: BoxFit.cover)),
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40.0),
                _AppLogo(),
                const SizedBox(height: 35.0),
                const Text(
                  "Crear Cuenta",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(209, 70, 60, 181),
                  ),
                ),
                const SizedBox(height: 15.0),
                _nombresTextField(),
                const SizedBox(height: 15.0),
                _apellidosTextField(),
                const SizedBox(height: 15.0),
                _usuarioTextField(),
                const SizedBox(height: 15.0),
                _cedulaTextField(),
                const SizedBox(height: 15.0),
                _correoTextField(),
                const SizedBox(height: 15.0),
                _claveTextField(),
                const SizedBox(height: 15.0),
                _confirmarClaveTextField(),
                const SizedBox(height: 20.0),
                _bottonRegistrar(),
                const SizedBox(height: 20.0),
                _bottonAtras(),
                const SizedBox(height: 40.0),
              ],
            )),
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

  Widget _nombresTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: TextFormField(
          controller: nombre,
          validator: _validateRequired,
          decoration: const InputDecoration(
            filled: true,
            labelStyle: TextStyle(color: Colors.black),
            fillColor: Color.fromARGB(201, 255, 255, 255),
            prefixIcon: Icon(
              Icons.co_present_rounded,
              color: Color.fromARGB(239, 70, 60, 181),
            ),
            hintText: "Nombre",
            labelText: "Nombre",
          ),
          onChanged: (value) {},
        ),
      );
    });
  }

  Widget _apellidosTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: TextFormField(
          controller: apellidos,
          validator: _validateRequired,
          decoration: const InputDecoration(
            filled: true,
            labelStyle: TextStyle(color: Colors.black),
            fillColor: Color.fromARGB(201, 255, 255, 255),
            prefixIcon: Icon(
              Icons.co_present_rounded,
              color: Color.fromARGB(239, 70, 60, 181),
            ),
            hintText: "Apellidos",
            labelText: "Apellidos",
          ),
          onChanged: (value) {},
        ),
      );
    });
  }

  Widget _usuarioTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: TextFormField(
          controller: usuario,
          validator: _validateRequired,
          decoration: const InputDecoration(
            filled: true,
            labelStyle: TextStyle(color: Colors.black),
            fillColor: Color.fromARGB(201, 255, 255, 255),
            prefixIcon: Icon(
              Icons.account_circle,
              color: Color.fromARGB(239, 70, 60, 181),
            ),
            hintText: "Usuario Docente",
            labelText: "Usuario Docente",
          ),
          onChanged: (value) {},
        ),
      );
    });
  }

  Widget _cedulaTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: TextFormField(
            controller: cedula,
            keyboardType: TextInputType.number,
            validator: _validateRequired,
            decoration: const InputDecoration(
              filled: true,
              labelStyle: TextStyle(color: Colors.black),
              fillColor: Color.fromARGB(201, 255, 255, 255),
              prefixIcon: Icon(
                Icons.badge,
                color: Color.fromARGB(239, 70, 60, 181),
              ),
              hintText: "Cedula",
              labelText: "Cedula",
            ),
            onChanged: (value) {},
          ));
    });
  }

  Widget _correoTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: TextFormField(
            controller: correo,
            validator: _validateRequired,
            decoration: const InputDecoration(
              filled: true,
              labelStyle: TextStyle(color: Colors.black),
              fillColor: Color.fromARGB(201, 255, 255, 255),
              prefixIcon: Icon(
                Icons.email,
                color: Color.fromARGB(239, 70, 60, 181),
              ),
              hintText: "prueba@prueba.com",
              labelText: "Correo Electronico",
            ),
            onChanged: (value) {},
          ));
    });
  }

  Widget _claveTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: TextFormField(
            controller: clave,
            validator: _validateRequired,
            obscureText: true,
            decoration: const InputDecoration(
              filled: true,
              labelStyle: TextStyle(color: Colors.black),
              fillColor: Color.fromARGB(201, 255, 255, 255),
              prefixIcon: Icon(
                Icons.lock,
                color: Color.fromARGB(239, 70, 60, 181),
              ),
              hintText: "Contraseña",
              labelText: "Contraseña",
            ),
            onChanged: (value) {},
          ));
    });
  }

  Widget _confirmarClaveTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: TextFormField(
            controller: confirmarClave,
            validator: _validateRequired,
            obscureText: true,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Color.fromARGB(201, 255, 255, 255),
              labelStyle: TextStyle(color: Colors.black),
              prefixIcon: Icon(
                Icons.lock,
                color: Color.fromARGB(239, 70, 60, 181),
              ),
              hintText: "Confirmar Contraseña",
              labelText: "Confirmar Contraseña",
            ),
            onChanged: (value) {},
          ));
    });
  }

  Widget _bottonRegistrar() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return RaisedButton(
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 15.0),
              child: Text("Crear cuenta",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ))),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 10.0,
          color: Color.fromARGB(211, 70, 60, 181),
          onPressed: () {
            _save();
          });
    });
  }

  Widget _bottonAtras() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return RaisedButton(
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 15.0),
              child: Text("Cancelar",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ))),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 10.0,
          color: Color.fromARGB(211, 70, 60, 181),
          onPressed: () {
            Navigator.pop(context);
          });
    });
  }

  String _validateRequired(String value) {
    if (value == null || value.isEmpty) return 'El dato es requerido';
    return null;
  }

  void _save() {
    if (_formKey.currentState.validate()) {
      Registro();
    } else {
      print('Error');
    }
  }
}
