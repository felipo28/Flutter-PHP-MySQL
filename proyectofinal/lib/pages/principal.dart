import 'dart:async';

import 'package:flutter/material.dart';
import 'package:proyectofinal/pages/pantallaEstudiantes.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class principalPages extends StatefulWidget {
  String cedula;
  String nombre;
  principalPages({Key key, this.cedula, this.nombre}) : super(key: key);

  @override
  _HomeState createState() => new _HomeState();
}

Future<List> getData(String cedula) async {
  var url = "http://192.168.20.39/ejerciciofinal/getDatosMateria.php";
  final response = await http.post(Uri.parse(url), body: {"cedula": cedula});
  return json.decode(response.body);
}

class _HomeState extends State<principalPages> {
  Icon actionIcon = new Icon(Icons.close, color: Colors.white);
  String nombre;
  String cedula;
  int _selectedIndex = 0;

  @override
  void initState() {
    cedula = widget.cedula;
    nombre = widget.nombre;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Bienvenido $nombre'),
          toolbarHeight: 100.0,
          backgroundColor: const Color.fromARGB(209, 70, 60, 181),
        ),
        body: _selectedIndex == 0
            ? PrincipalHome(cedula: cedula)
            : PrincipalConfig(),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Principal',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Configuracion',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: const Color.fromARGB(209, 70, 60, 181),
          onTap: _onItemTapped,
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

class PrincipalConfig extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 40.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 110.0, vertical: 15.0),
                    child: Text(
                      "Perfil",
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
                  color: const Color.fromARGB(125, 100, 60, 181),
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 80.0, vertical: 15.0),
                      child: Text("Cerrar Sesion",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ))),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 10.0,
                  color: const Color.fromARGB(125, 100, 60, 181),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PrincipalHome extends StatelessWidget {
  final String cedula;
  final String nombre;
  PrincipalHome({this.cedula, this.nombre});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: getData(cedula),
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);
        return snapshot.hasData
            ? ItemList(
                list: snapshot.data,
              )
            : Center(
                child: new CircularProgressIndicator(),
              );
      },
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  ItemList({this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return Container(
          padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
          decoration: BoxDecoration(),
          child: GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (BuildContext context) => Detail(
                        list: list,
                        index: i,
                      )),
            ),
            child: Card(
              child: ListTile(
                title: Text(
                  list[i]['nombre'],
                  style: const TextStyle(
                    fontSize: 21.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: const Icon(
                  Icons.edit_outlined,
                  size: 45.0,
                  color: Color.fromARGB(255, 24, 69, 88),
                ),
                subtitle: Text(
                  "Codigo Materia: ${list[i]['id_materia']}",
                  style: const TextStyle(fontSize: 18.0, color: Colors.black),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
