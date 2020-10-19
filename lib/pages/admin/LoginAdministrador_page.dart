import 'package:flutter/material.dart';
import 'package:next_to_manager/components/recursos/LoginField.dart';
import 'package:next_to_manager/components/recursos/RoundedButton.dart';
import 'package:next_to_manager/components/recursos/logo.dart';
import 'package:next_to_manager/components/recursos/metodosValidacion.dart';
import 'package:next_to_manager/constants.dart';
import 'package:next_to_manager/pages/admin/homeAdmin_page.dart';
import 'package:next_to_manager/pages/admin/pruebaSolicitudes.dart';
import 'package:next_to_manager/pages/residente/services/my_api.dart';

class LoginAdmin extends StatefulWidget {
  static String id = 'loginAdmin_page';

  @override
  _LoginAdminState createState() => _LoginAdminState();
}

class _LoginAdminState extends State<LoginAdmin> {
  String email;
  String _password;
  String _emailRecuperation;
  String message = " ";
  //icon password toggle
  bool _isHidden = true;
  TextEditingController controlEmail = new TextEditingController();
  TextEditingController controlPassword = new TextEditingController();
  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  bool _isInAsyncCall = false;

  void userSignIn() async {
    //dismiss keyboard during async call
    FocusScope.of(context).requestFocus(new FocusNode());

    //start the modal progress HUD
    setState(() {
      _isInAsyncCall = true;
    });
    //simulate a service call
    Future.delayed(Duration(seconds: 1), () async {
      MyAPI.instance.loginAdmin(context,
          email: controlEmail.text.trim(),
          password: controlPassword.text.trim());
      setState(() {
        _isInAsyncCall = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              LogoImage(),
              SizedBox(
                height: 25,
              ),
              Expanded(
                child: Container(
                  decoration: kBoxDecorationLogin,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          MyLoginField(
                            controller: controlEmail,
                            hintText: "correo electrónico",
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          MyLoginField(
                            controller: controlPassword,
                            hintText: "Ingrese su contraseña",
                            obscureText: _isHidden,
                            icon: IconButton(
                              onPressed: _toggleVisibility,
                              icon: _isHidden
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility),
                            ),
                          ),
                          Text(
                            message,
                            style: TextStyle(color: Colors.black),
                          ),
                          SizedBox(height: 20),
                          RoundedButton(
                            text: Text(
                              'INICIAR SESIÓN',
                              style: TextStyle(color: kMainColorExtraLight),
                            ),
                            onPressed: () {
                              userSignIn();
                            },
                            colour: Colors.grey[850],
                          ),
                          SizedBox(height: 20),
                          GestureDetector(
                            onTap: () => _mostrarAlert(context),
                            child: Text(
                              '¿Olvidaste tu contraseña?',
                              style: kBrownTextStyle,
                            ),
                          ),
                          SizedBox(
                            height: 80,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _mostrarAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        String message = "example@gmail.com";
        Color messageColor = Colors.black;
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              title: Center(
                  child: Text(
                "¿Olvidaste tu contraseña?",
                style: TextStyle(fontSize: 16),
              )),
              content:
                  Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                Text(
                  'Escribe tu email a continuación y te enviaremos un correo con tu contraseña',
                  style: TextStyle(fontSize: 15),
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (String value) {
                    _emailRecuperation = value;
                    print(_emailRecuperation);
                  },
                ),
                Text(
                  message,
                  style: TextStyle(fontSize: 14, color: messageColor),
                ),
              ]),
              actions: <Widget>[
                FlatButton(
                    child: Text('Recibir correo'),
                    onPressed: () {
                      setState(() {
                        if (validateEmail(_emailRecuperation) == null) {
                          message =
                              'Se le ha enviado un correo con su contraseña, puede tardar unos minutos';
                          messageColor = Colors.green;
                        } else {
                          message =
                              "Por favor, digite un correo electrónico válido";
                          messageColor = Colors.red;
                        }
                      });
                    }),
                FlatButton(
                  child: Text('Cancelar'),
                  onPressed: () => Navigator.of(context).pop(), //volver atras
                ),
              ],
            );
          },
        );
      },
    );
  }
}
