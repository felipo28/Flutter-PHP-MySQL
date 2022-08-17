import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Notas extends StatefulWidget {
  String cedula;
  List list;
  String nombreDato;
  String id;

  Notas({this.cedula, this.list, this.nombreDato, this.id});
  @override
  _DetailState createState() => new _DetailState();
}

class Services {
  static String ElimNotas = "Elimiar_Datos";
  static String ModiNotas = "Modificar_Datos";
  static String GuarNotas = "Guardar_Datos";

  static Future<String> EliminarNota(String id) async {
    var url = "http://192.168.20.39/ejerciciofinal/getNotas.php";
    final response = await http.post(Uri.parse(url), body: {
      'action': ElimNotas,
      'id': id,
    });
  }

  static Future<String> ModificarNota(String id, String NotaModificada) async {
    var url = "http://192.168.20.39/ejerciciofinal/getNotas.php";
    final response = await http.post(Uri.parse(url), body: {
      'action': ModiNotas,
      'id': id,
      'primer_parcial': NotaModificada,
    });
  }

  static Future<String> GuardarNota(String id, String NotaCreada) async {
    var url = "http://192.168.20.39/ejerciciofinal/getNotas.php";
    final response = await http.post(Uri.parse(url), body: {
      'action': GuarNotas,
      'id_notas': id,
      'primer_parcial': NotaCreada,
    });
  }
}

class _DetailState extends State<Notas> {
  String _valor;
  String id_otra_tabla;
  List<String> numeros = [
    'Seleccione una nota',
    '1.0',
    '1.1',
    '1.2',
    '1.3',
    '1.4',
    '1.5',
    '1.6',
    '1.7',
    '1.8',
    '1.9',
    '2.0',
    '2.1',
    '2.2',
    '2.3',
    '2.4',
    '2.5',
    '2.6',
    '2.7',
    '2.8',
    '2.9',
    '3.0',
    '3.1',
    '3.2',
    '3.3',
    '3.4',
    '3.5',
    '3.6',
    '3.7',
    '3.8',
    '3.9',
    '4.0',
    '4.1',
    '4.2',
    '4.3',
    '4.4',
    '4.5',
    '4.6',
    '4.7',
    '4.8',
    '4.9',
    '5.0'
  ];
  double revenueSum = 0;
  int valor = 0;
  String TraerNotas = "Traer_Datos";

  String cedula;
  String nombreEstudiante;
  List<Calificaciones> _employees;

  @override
  void initState() {
    _valor = 'Seleccione una nota';
    cedula = widget.cedula;
    id_otra_tabla = widget.id;
    nombreEstudiante = widget.nombreDato;
    super.initState();
    _employees = [];
    _getEmployees();
  }

  Future<List<Calificaciones>> ListaNotas() async {
    var url = "http://192.168.20.39/ejerciciofinal/getNotas.php";

    final response = await http.post(Uri.parse(url), body: {
      'action': TraerNotas,
      'idMateria': widget.list[0]['id_materia'],
      'cedula': cedula,
    });
    var list = json.decode(response.body);
    List<Calificaciones> _employees = await list
        .map<Calificaciones>((json) => Calificaciones.fromJson(json))
        .toList();
    return _employees;
  }

  _createTable(String nota) {
    if (nota == 'Seleccione una nota') {
      Fluttertoast.showToast(
          msg: "Seleccione una nota.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return false;
    } else {
      Services.GuardarNota(id_otra_tabla, nota).then(
        _getEmployees(),
      );
      return true;
    }
  }

  _updateTable(String nota, String idNota) {
    if (nota == 'Seleccione una nota') {
      Fluttertoast.showToast(
          msg: "Seleccione una nota.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return false;
    } else {
      Services.ModificarNota(idNota, nota).then(
        _getEmployees(),
      );
      return true;
    }
  }

  _getEmployees() {
    ListaNotas().then((getLista) {
      setState(() {
        revenueSum = 0;
        valor = 0;
        _valor = 'Seleccione una nota';
        _employees = getLista;
      });
    });
  }

  _deleteEmployee(Calificaciones getCali) {
    Services.EliminarNota(getCali.id.toString()).then(
      _getEmployees(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70.0,
        backgroundColor: const Color.fromARGB(209, 70, 60, 181),
        title: Text("Estudiante: $nombreEstudiante"),
        actions: <Widget>[
          IconButton(
            alignment: Alignment.centerLeft,
            icon: const Icon(Icons.refresh),
            onPressed: () {
              _getEmployees();
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(top: 10.0),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: Column(children: [
                    Container(
                      child: _userText(),
                    ),
                  ]),
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      padding: EdgeInsets.only(right: 20, top: 18),
                      child: MaterialButton(
                        shape: const CircleBorder(),
                        color: Color.fromARGB(142, 70, 60, 181),
                        child: const Icon(
                          Icons.add,
                          size: 40,
                        ),
                        onPressed: () {
                          showAlertDialog(context, 'Crear_Nota', null);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.only(top: 10.0, left: 5, right: 5),
              child: tablaEstudiantes(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _userText() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
          padding: EdgeInsets.only(left: 40, top: 5),
          child: TextField(
            decoration: InputDecoration(
              enabled: false,
              hintText: "Nota Final",
              labelText: "Nota Final ${revenueSum / valor}",
            ),
          ));
    });
  }

  showAlertDialog(BuildContext context, String seleccion, _id) {
    Widget cancelButton() {
      return StreamBuilder(
          builder: (BuildContext context, AsyncSnapshot snapshot) {
        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(10.0),
              ),
              Row(children: <Widget>[
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close_sharp, size: 35),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ]),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: const Text(
                        "Asignar Calificacion",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.save, size: 35),
                      onPressed: () {
                        if (seleccion == 'Crear_Nota') {
                          bool op = _createTable(_valor);
                          if (op == true) {
                            Navigator.pop(context);
                          }
                        } else if (seleccion == 'Modificar_Nota') {
                          bool op = _updateTable(_valor, _id);
                          if (op == true) {
                            Navigator.pop(context);
                          }
                        }
                      },
                    ),
                  ],
                ),
              ]),
              Center(
                child: Container(
                  padding: const EdgeInsets.only(top: 20, bottom: 30),
                  width: 250.0,
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(131, 50, 43, 132)),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(131, 50, 43, 132)),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    hint: const Center(
                      child: Text(
                        "Seleccione una opcion",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    isExpanded: true,
                    value: _valor,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: numeros.map((_numeros) {
                      return DropdownMenuItem(
                        value: _numeros,
                        child: Text(_numeros),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _valor = value;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      });
    }

    AlertDialog alert = AlertDialog(
      actions: [
        cancelButton(),
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  SingleChildScrollView tablaEstudiantes() {
    final double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics:
          const NeverScrollableScrollPhysics(), //Evitará a que trate de Scrolear
      child: SingleChildScrollView(
        child: SizedBox(
          width: width,
          child: DataTable(
            showBottomBorder: true,
            dividerThickness: 2.0,
            columnSpacing: 0,
            horizontalMargin: 0,
            columns: [
              DataColumn(
                label: SizedBox(
                  width: width * .3,
                  child: const Text("Nota",
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center),
                ),
              ),
              DataColumn(
                label: Container(
                  width: width * .3,
                  child: const Text("Editar",
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center),
                ),
              ),
              DataColumn(
                label: SizedBox(
                  width: width * .3,
                  child: const Text("Eliminar",
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center),
                ),
              ),
            ],
            rows: _employees.map((employee) {
              revenueSum += double.parse(employee.Nota);
              valor += 1;
              return DataRow(
                cells: [
                  DataCell(
                    Center(
                      child: Text(employee.Nota.toString(),
                          style: TextStyle(fontSize: 15),
                          textAlign: TextAlign.center),
                    ),
                  ),
                  DataCell(
                    const Center(
                      child: Icon(Icons.edit),
                    ),
                    onTap: () {
                      showAlertDialog(
                          context, 'Modificar_Nota', employee.id.toString());
                    },
                  ),
                  DataCell(
                    const Center(
                      child: Icon(Icons.delete),
                    ),
                    onTap: () {
                      _deleteEmployee(employee);
                    },
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class Calificaciones {
  String id;
  String id_notas;
  String Nota;

  Calificaciones({this.id, this.Nota, this.id_notas});

  factory Calificaciones.fromJson(Map<String, dynamic> json) {
    return Calificaciones(
      id: json['id'] as String,
      id_notas: json['id_notas'] as String,
      Nota: json['primer_parcial'] as String,
    );
  }
}
