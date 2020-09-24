import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'homeResidente_page.dart';

class CrearSolicitudPage extends StatefulWidget {
  static String id = 'crear_solicitud_page';
  final String emailController;

  const CrearSolicitudPage({Key key, this.emailController}) : super(key: key);
  @override
  _CrearSolicitudPageState createState() => _CrearSolicitudPageState();
}

class _CrearSolicitudPageState extends State<CrearSolicitudPage> {
  @override
  void initState() {
    super.initState();
    verUsuarioData();
  }

  TextEditingController controltipo = new TextEditingController();
  TextEditingController controlMotivo = new TextEditingController();
  TextEditingController controlDescripcion = new TextEditingController();
  bool validateCreacionSolicitud = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String idUsuario;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        _crearFondo(context),
        _loginForm(context),
      ]),
    );
  }

  var _lista = ['QUEJA', 'RECLAMO', 'SUGERENCIA'];
  String _vista = 'Tipo de Solicitud';
  String _tipoSoli;

  Widget _loginForm(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
        child: Form(
      autovalidate: false,
      key: _formKey,
      child: Column(children: <Widget>[
        SafeArea(
          child: Container(
            height: 80.0,
          ),
        ),
        Container(
          width: size.width * 0.85,
          margin: EdgeInsets.symmetric(vertical: 10.0),
          padding: EdgeInsets.symmetric(vertical: 30.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 3.0,
                    offset: Offset(0.0, 5.0),
                    spreadRadius: 3.0)
              ]),
          child: Column(
            children: <Widget>[
              Text("FORMULARIO", style: TextStyle(fontSize: 20.0)),
              Text('email remitente:' + widget.emailController),
              _crearBotonPrueba(),
              _crearSpinner(),
              _crearMotivo(),
              _crearDescripcion(),
              SizedBox(
                height: 30.0,
              ),
              _crearBoton(),
            ],
          ),
        ),
        SizedBox(
          height: 50.0,
        )
      ]),
    ));
  }

  Widget _crearSpinner() {
    return Container(
      child: DropdownButtonFormField(
        validator: (value) => value == null ? 'field required' : null,
        value: _tipoSoli,
        items: _lista.map((String a) {
          return DropdownMenuItem(value: a, child: Text(a));
        }).toList(),
        onChanged: (opt) {
          {
            setState(() {
              _tipoSoli = opt;
            });
          }
        },
        hint: Text(_vista),
      ),
    );
  }

  Widget _crearDescripcion() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
      child: TextFormField(
        validator: (val) {
          if (val.isEmpty) return 'Empty';
          return null; //sino esta vacio, retorne null
        },
        controller: controlDescripcion,
        maxLines: 8,
        decoration: InputDecoration.collapsed(
          hintText: 'Detalle su caso en este espacio',
        ),
      ),
    );
  }

  Widget _crearMotivo() {
    if (_tipoSoli == 'SUGERENCIA') {
      return Text('');
    } else {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        child: TextFormField(
          controller: controlMotivo,
          decoration: InputDecoration(
            labelText: 'Motivo (titulo) de su Solicitud',
          ),
        ),
      );
    }
  }

  Widget _crearBotonPrueba() {
    return RaisedButton(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
        child: Text('ENVIAR'),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      elevation: 0.0,
      color: Colors.yellow.shade200,
      onPressed: () {
        verUsuarioData();
      },
    );
  }

  Widget _crearBoton() {
    return RaisedButton(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
        child: Text('ENVIAR'),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      elevation: 0.0,
      color: Colors.yellow.shade200,
      onPressed: () {
        _validateInputs();
      },
    );
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
        Color.fromRGBO(202, 160, 82, 0.79),
        Color.fromRGBO(255, 255, 177, 1)
      ])),
    );
  }

  //guardada final de la informacion si todo es correcto
  void _validateInputs() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      agregarSolicitud();
      // Navigator.pushNamed(context, HomeResidentePage.id);
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  List<dynamic> dataUser;
  void verUsuarioData() async {
    var url =
        "http://ssolutiones.com/prueba_nextToManager/obtenerUsuario.php?email=" +
            widget.emailController;
    var data = {
      "email": widget.emailController,
    };
    var res = await http.post(url, body: data);

    dataUser = json.decode(res.body);
    Map mapaData = dataUser[0] as Map;
    print(widget.emailController);
    //print(dataUser);
    print(mapaData);

    setState(() {
      idUsuario = mapaData['idUsuario'];
    });
  }

  List<dynamic> dataSoli;
  void agregarSolicitud() async {
    verUsuarioData();
    print("el id que llego a la funcion de registro:" + idUsuario);
    var url =
        "https://ssolutiones.com/prueba_nextToManager/agregarSolicitud.php";
    var data = {
      "idUsuario": idUsuario,
      "descripcion": controlDescripcion.text,
      "tipo_solicitud": _tipoSoli,
      "motivo": controlMotivo.text,
      "revisado": "false",
    };
    var res = await http.post(url, body: data);

    dataSoli = json.decode(res.body);
    Map mapaData = dataSoli[0] as Map;
    //print(mapaData);

    if (mapaData.containsValue('true')) {
      validateCreacionSolicitud = true;
      setState(() {
        _mostrarAlert(context);
      });

      print('Solicitud registrada exitosamente');
    } else if (mapaData.containsValue('error')) {
      validateCreacionSolicitud = false;
      setState(() {
        _mostrarAlert(context);
      });

      print('Ocurrio un error al registrar la solicitud');
    }
  }

  void _mostrarAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        Color messageColor = Colors.black;
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              title: Center(
                  child: Text(
                "Estado de la solicitud:",
                style: TextStyle(fontSize: 16),
              )),
              content:
                  Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                Text(
                  mensajeCreacionSoli(),
                  style: TextStyle(fontSize: 15, color: messageColor),
                ),
              ]),
              actions: <Widget>[
                FlatButton(
                    child: Text('ok'),
                    onPressed: () {
                      setState(() {
                        if (validateCreacionSolicitud == true) {
                          Navigator.pushNamed(context, HomeResidentePage.id);
                          messageColor = Colors.green;
                        } else {
                          messageColor = Colors.red;
                          Navigator.of(context).pop();
                        }
                      });
                    }),
              ],
            );
          },
        );
      },
    );
  }

  String mensajeCreacionSoli() {
    if (validateCreacionSolicitud == true) {
      return 'SU SOLICITUD HA SIDO ENVIADA CORRECTAMENTE';
    } else {
      return "HA OCURRIDO UN ERROR, POR FAVOR VERIFIQUE LOS DATOS";
    }
  }
}
