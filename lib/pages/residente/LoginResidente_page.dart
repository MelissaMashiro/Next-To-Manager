import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:next_to_manager/components/recursos/LoginField.dart';
import 'package:next_to_manager/components/recursos/RoundedButton.dart';
import 'package:next_to_manager/components/recursos/logo.dart';
import 'package:next_to_manager/components/recursos/metodosValidacion.dart';
import 'package:next_to_manager/constants.dart';
import 'package:next_to_manager/pages/residente/Registration_page.dart';
import 'package:next_to_manager/pages/residente/homeResidente_page.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

SharedPreferences localStorage;

class LoginResidente extends StatefulWidget {
  static String id = 'loginResidente_page';

  @override
  _LoginResidenteState createState() => _LoginResidenteState();
}

class _LoginResidenteState extends State<LoginResidente> {
  String email;
  String _password;
  String _emailRecuperation;
  String message = " ";
  //icon password toggle
  bool _isHidden = true;

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  TextEditingController controlEmail = new TextEditingController();
  TextEditingController controlPassword = new TextEditingController();

  bool _isInAsyncCall = false;

  List<dynamic> dataUser;
  void userSignIn() async {
    //dismiss keyboard during async call
    FocusScope.of(context).requestFocus(new FocusNode());

    //start the modal progress HUD
    setState(() {
      _isInAsyncCall = true;
    });
    //simulate a service call
    Future.delayed(Duration(seconds: 1), () async {
      //futuredelayed es para que mientras carga, se muestre la barra de loading
      var url = "https://ssolutiones.com/prueba_nextToManager/login.php";
      var data = {
        "email": controlEmail.text,
        "password": controlPassword.text,
      };
      var res = await http.post(url, body: data);

      dataUser = json.decode(res.body);
      Map mapaData = dataUser[0] as Map;
      //print(mapaData);

      if (mapaData.containsValue('true')) {
        //SHARED PREFERENCES
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setBool("isLogin", true);
        pref.setString("email", controlEmail.text);

        setState(() {
          _isInAsyncCall = false;
        });
        //LOGIN EXITOSO
        Fluttertoast.showToast(
            msg: 'Bienvenido a Next To Manager',
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.green);
//yendo al dashboard
        //Navigator.pushNamed(context, HomeResidentePage.id);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => HomeResidentePage()));
      } else if (mapaData.containsValue('false')) {
        //SHARED PREFERENCES
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setBool("isLogin", false);
        setState(() {
          _isInAsyncCall = false;
        });
        //LOGIN NO EXITOSO
        Fluttertoast.showToast(
            msg: 'Error credenciales',
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ModalProgressHUD(
          color: Colors.black,
          inAsyncCall: _isInAsyncCall,
          opacity: 0.5,
          progressIndicator: CircularProgressIndicator(
            backgroundColor: kMainColor,
            valueColor: AlwaysStoppedAnimation<Color>(kMainColorDark),
          ),
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
                              onChanged: (String value) {
                                email = value;
                                print(email);
                              },
                              hintText: "correo electrónico",
                              keyboardType: TextInputType.emailAddress,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            MyLoginField(
                              controller: controlPassword,
                              onChanged: (String value) {
                                _password = value;
                                print(_password);
                              },
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
                                bool emailValid = RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(email);
                                setState(() {
                                  if (emailValid == true) {
                                    message = '';
                                    userSignIn();
                                  } else {
                                    message =
                                        'datos incorrectos, favor revisar el email o contraseña';
                                  }
                                });
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
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: '¿No tienes una cuenta? ',
                                      style:
                                          TextStyle(color: Colors.grey[600])),
                                  TextSpan(
                                    text: 'Registrate aquí',
                                    style: kBrownTextStyle,
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushNamed(
                                            context, RegistrationPage.id);
                                      },
                                  ),
                                ],
                              ),
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
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  Future _checkLogin() async {
//SHARED PREFERENCES
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getBool("isLogin") == true) {
      Navigator.pushNamed(context, HomeResidentePage.id);
    }
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
