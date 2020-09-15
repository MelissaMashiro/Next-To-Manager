import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:next_to_manager/components/recursos/metodosValidacion.dart';
import 'package:next_to_manager/constants.dart';
import 'package:next_to_manager/pages/residente/LoginResidente_page.dart';
import 'package:next_to_manager/pages/residente/homeResidente_page.dart';

import 'package:http/http.dart' as http;

class RegistrationPage extends StatefulWidget {
  static String id = 'registration_page';

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController controlNombres = new TextEditingController();
  TextEditingController controlApellidos = new TextEditingController();
  TextEditingController controlTelefono = new TextEditingController();
  TextEditingController controlEmail = new TextEditingController();
  TextEditingController controlCedula = new TextEditingController();
  TextEditingController controlPassword = new TextEditingController();

  String torreSeleccionada;
  String apartamentoSeleccionado;
  bool validateRegistro = false;
  String _vista = 'Seleccione TORRE';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _autoValidate = false;
  String _nombres;
  String _apellidos;
  String _cedula;
  String _telefono;
  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        _crearFondo(context),
        _loginForm(context),
      ]),
    );
  }

  Widget _loginForm(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
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
        child: Form(
          autovalidate: false,
          key: _formKey,
          child: Column(
            children: <Widget>[
              Text('Datos Personales', style: TextStyle(fontSize: 20.0)),
              _crearNombre(),
              _crearApellido(),
              _crearCedula(),
              _crearEmail(),
              _crearPassword(),
              _crearTorre(),
              _crearApartamento(),
              _crearTelefono(),
              SizedBox(
                height: 30.0,
              ),
              _crearBoton(),
            ],
          ),
        ),
      ),
      SizedBox(
        height: 50.0,
      )
    ]));
  }

  Widget _crearNombre() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
      child: TextFormField(
        controller: controlNombres,
        keyboardType: TextInputType.text,
        inputFormatters: [
          new WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
        ],
        decoration:
            InputDecoration(labelText: 'Nombres', hintText: 'Ej: Pedro '),
        validator: validateNomApe,
        onSaved: (String val) {
          _nombres = val;
        },
      ),
    );
  }

  Widget _crearApellido() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
      child: TextFormField(
        controller: controlApellidos,
        keyboardType: TextInputType.text,
        inputFormatters: [
          new WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
        ],
        decoration: InputDecoration(
          labelText: 'Apellidos',
        ),
        validator: validateNomApe,
        onSaved: (String val) {
          _apellidos = val;
        },
      ),
    );
  }

  Widget _crearEmail() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
      child: TextFormField(
        controller: controlEmail,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: 'correo electronico',
          hintText: "example@gmail.com",
        ),
        validator: validateEmail,
        onSaved: (String val) {
          _email = val;
        },
      ),
    );
  }

  Widget _crearPassword() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
      child: TextFormField(
        controller: controlPassword,
        keyboardType: TextInputType.text,
        obscureText: true,
        decoration: InputDecoration(
          labelText: 'contraseña',
        ),
        validator: validatePassword,
        onSaved: (String val) {
          _password = val;
        },
      ),
    );
  }

  Widget _crearCedula() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
      child: TextFormField(
        controller: controlCedula,
        inputFormatters: [
          new WhitelistingTextInputFormatter(RegExp("[0-9]")),
        ],
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            labelText: 'Cedula o NIT', hintText: 'Ej: 10449785'),
        validator: validateCedula,
        onSaved: (String val) {
          _cedula = val;
        },
      ),
    );
  }

  Widget _crearTorre() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
      child: DropdownButtonFormField(
          validator: (value) => value == null ? 'field required' : null,
          hint: Text("TORRE"),
          value: torreSeleccionada,
          items: getOpcionesDropdown(kTorres),
          onChanged: (opt) {
            setState(() {
              torreSeleccionada = opt;
            });
          }),
    );
  }

  Widget _crearApartamento() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
      child: DropdownButtonFormField(
          validator: (value) => value == null ? 'field required' : null,
          hint: Text("APTO"),
          value: apartamentoSeleccionado,
          items: getOpcionesDropdown(kNumeroTorres),
          onChanged: (opt) {
            setState(() {
              apartamentoSeleccionado = opt;
            });
          }),
    );
  }

  Widget _crearTelefono() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
      child: TextFormField(
        controller: controlTelefono,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
            labelText: 'Numero de Celular', hintText: 'Ej: 3012458795'),
        validator: validateTelefono,
        onSaved: (String val) {
          _telefono = val;
        },
      ),
    );
  }

  Widget _crearBoton() {
    return RaisedButton(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
        child: Text('FINALIZAR REGISTRO'),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      elevation: 0.0,
      color: Colors.yellow.shade200,
      onPressed: () {
        _validateInputs();
        //print(controlNombres);
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

  //Este metodo genérico funciona dentro del widget del dropdown para listar nuestros items
  List<DropdownMenuItem<String>> getOpcionesDropdown(List myList) {
    //ahora mismo es una lista de strings
    List<DropdownMenuItem<String>> list = new List();
    myList.forEach((item) {
      list.add(DropdownMenuItem(
        child: Text(item),
        value: item,
      ));
    });
    return list;
  }

//guardada final de la informacion si todo es correcto
  void _validateInputs() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print('cedula es: ' + controlCedula.text);
      agregarUsuario();

      //Navigator.pushNamed(context, HomeResidentePage.id);
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  List<dynamic> dataUser;
  void agregarUsuario() async {
    var url = "https://ssolutiones.com/prueba_nextToManager/agregarUsuario.php";
    var data = {
      "nombre": controlNombres.text + " " + controlApellidos.text,
      "cedula": controlCedula.text,
      "telefono": controlTelefono.text,
      "email": controlEmail.text,
      "password": controlPassword.text,
      "torre": torreSeleccionada,
      "numero_apto": apartamentoSeleccionado,
    };
    var res = await http.post(url, body: data);

    dataUser = json.decode(res.body);
    Map mapaData = dataUser[0] as Map;
    //print(mapaData);

    if (mapaData.containsValue('true')) {
      validateRegistro = true;
      setState(() {
        _mostrarAlert(context);
      });

      print('Usuario registrado exitosamente');
    } else if (mapaData.containsValue('error')) {
      validateRegistro = false;
      setState(() {
        _mostrarAlert(context);
      });

      print('Ocurrio un error al registrarte.');
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
                "REGISTRO NextToManager",
                style: TextStyle(fontSize: 16),
              )),
              content:
                  Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                Text(mensajeRegistro(),
                    style: TextStyle(
                      fontSize: 15,
                      color: messageColor,
                    )),
              ]),
              actions: <Widget>[
                FlatButton(
                    child: Text('ok'),
                    onPressed: () {
                      setState(() {
                        if (validateRegistro == true) {
                          Navigator.pushNamed(context, LoginResidente.id);
                          messageColor = Colors.green;
                        } else {
                          messageColor = Colors.red;
                          Navigator.of(context).pop();
                          messageColor = Colors.red;
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

  String mensajeRegistro() {
    if (validateRegistro == true) {
      return 'SU REGISTRO A SIDO EXITOSO';
    } else {
      return "YA EXISTE UN USUARIO CON ESTOS DATOS (Cedula,email,torre-apto)";
    }
  }
}
