import 'package:flutter/material.dart';
import 'package:proyectofinal/pages/PantallaNotas.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Detail extends StatefulWidget {
  List list;
  int index;
  Detail({Key key, this.index, this.list}) : super(key: key);
  @override
  _DetailState createState() => new _DetailState();
}

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});
  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class _DetailState extends State<Detail> {
  List<Employee> _employees;
  List list;
  List<Employee> _filterEmployees;

  final _debuguncer = Debouncer(milliseconds: 500);
  @override
  void initState() {
    super.initState();
    list = widget.list;
    _employees = [];
    _filterEmployees = [];
    _getEmployees();
  }

  Future<List<Employee>> generarLista() async {
    var url = "http://192.168.20.39/ejerciciofinal/getDatosEstudiante.php";

    final response = await http.post(Uri.parse(url), body: {
      'idMateria': widget.list[widget.index]['id_materia'],
    });

    var lista = json.decode(response.body);
    List<Employee> _employees =
        await lista.map<Employee>((json) => Employee.fromJson(json)).toList();
    return _employees;
  }

  _getEmployees() {
    generarLista().then((employees) {
      setState(() {
        _employees = employees;
        _filterEmployees = employees;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70.0,
        backgroundColor: const Color.fromARGB(209, 70, 60, 181),
        title: Text("Asignatura: ${widget.list[widget.index]['nombre']}"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
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
                      child: _userTextField(),
                    ),
                  ]),
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.only(top: 10.0, left: 5, right: 5),
              child: tablaEstudiantes(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _userTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.only(left: 40, top: 5, right: 40, bottom: 5),
        child: TextField(
          decoration: const InputDecoration(
            prefixIcon: Icon(
              Icons.search,
            ),
            hintText: "Buscar Estudiante",
            labelText: "Buscar Estudiante",
          ),
          style: const TextStyle(
            letterSpacing: 0.3,
            fontSize: 17,
          ),
          onChanged: (String) {
            _debuguncer.run(() {
              setState(() {
                _filterEmployees = _employees
                    .where((u) => (u.cedula.toLowerCase().contains(String) ||
                        u.nombres.toLowerCase().contains(String) ||
                        u.apellidos.toLowerCase().contains(String)))
                    .toList();
              });
            });
          },
        ),
      );
    });
  }

  SingleChildScrollView tablaEstudiantes() {
    final double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics:
          const NeverScrollableScrollPhysics(), //Evitará a que trate de Scrolear
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            width: width,
            child: DataTable(
              showBottomBorder: true,
              dividerThickness: 2.0,
              columnSpacing: 0,
              horizontalMargin: 0,
              columns: [
                DataColumn(
                  label: Container(
                    width: width * .3,
                    child: const Text("Cedula",
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: width * .3,
                    child: const Text("Nombre",
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: width * .3,
                    child: const Text("Apellido",
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center),
                  ),
                ),
              ],
              rows: _filterEmployees
                  .map(
                    (employee) => DataRow(
                      cells: [
                        DataCell(
                          Center(
                            child: Text(employee.cedula,
                                style: TextStyle(fontSize: 15),
                                textAlign: TextAlign.center),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Notas(
                                    id: employee.id,
                                    cedula: employee.cedula,
                                    list: list,
                                    nombreDato: employee.nombres +
                                        " " +
                                        employee.apellidos),
                              ),
                            );
                          },
                        ),
                        DataCell(
                          Center(
                            child: Text(employee.nombres.toUpperCase(),
                                style: const TextStyle(fontSize: 15),
                                textAlign: TextAlign.center),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Notas(
                                    cedula: employee.cedula,
                                    list: list,
                                    nombreDato: employee.nombres +
                                        " " +
                                        employee.apellidos),
                              ),
                            );
                          },
                        ),
                        DataCell(
                          Center(
                            child: Text(employee.apellidos.toUpperCase(),
                                style: const TextStyle(fontSize: 15),
                                textAlign: TextAlign.center),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Notas(
                                    cedula: employee.cedula,
                                    list: list,
                                    nombreDato: employee.nombres +
                                        " " +
                                        employee.apellidos),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          )),
    );
  }
}

class Employee {
  String cedula;
  String nombres;
  String apellidos;
  String id;

  Employee({this.cedula, this.nombres, this.apellidos, this.id});

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      cedula: json['cedula'] as String,
      nombres: json['nombres'] as String,
      apellidos: json['apellidos'] as String,
      id: json['id'] as String,
    );
  }
}
