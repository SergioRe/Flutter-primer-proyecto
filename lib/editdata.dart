import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'main.dart';
import 'appConfig.dart';

class EditData extends StatefulWidget {
  final List list;
  final int index;

  EditData({this.list, this.index});

  @override
  _EditDataState createState() => new _EditDataState();
}

class _EditDataState extends State<EditData> {

  TextEditingController controllerCode;
  TextEditingController controllerName;
  TextEditingController controllerPrice;
  TextEditingController controllerStock;

  Future editData() async {
    var idAlu = widget.list[widget.index]['id_alumno'];
    String url = urlWs + "case=update_alu" + "&id_alumno=$idAlu";
    String json = '{"nombres": "' + controllerName.text + '", "monto": "' + controllerPrice.text + '", "estado": "' + controllerStock.text + '"}';
    final response = await http.put(url, headers: { "Accept" : "application/json"}, body: json);
    var extractdata = jsonDecode(response.body);
    print(extractdata["success"]);
  }

  @override
    void initState() {
      controllerCode= new TextEditingController(text: widget.list[widget.index]['id_alumno'] );
      controllerName= new TextEditingController(text: widget.list[widget.index]['nombres'] );
      controllerPrice= new TextEditingController(text: widget.list[widget.index]['monto'] );
      controllerStock= new TextEditingController(text: widget.list[widget.index]['estado'] );
      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Editar alumno"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            new Column(
              children: <Widget>[
                new TextField(
                  controller: controllerCode,
                  decoration: new InputDecoration(
                      hintText: "Código", labelText: "Ingrese Código"),
                ),
                new TextField(
                  controller: controllerName,
                  decoration: new InputDecoration(
                      hintText: "Nombres", labelText: "Nombre"),
                ),
                new TextField(
                  controller: controllerPrice,
                  decoration: new InputDecoration(
                      hintText: "Monto", labelText: "Monto"),
                ),
                new TextField(
                  controller: controllerStock,
                  decoration: new InputDecoration(
                      hintText: "Estado", labelText: "Estado"),
                ),
                new Padding(
                  padding: const EdgeInsets.all(10.0),
                ),
                new RaisedButton(
                  child: new Text("Editar alumno"),
                  color: Colors.blueAccent,
                  onPressed: () {
                    editData();
                    Navigator.of(context).push(
                      new MaterialPageRoute(
                        builder: (BuildContext context)=>new Home()
                      )
                    );
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}