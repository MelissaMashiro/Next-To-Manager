import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:next_to_manager/pages/admin/homeAdmin_page.dart';
import 'package:next_to_manager/pages/residente/homeResidente_page.dart';
import 'package:next_to_manager/pages/residente/models/residente_model.dart';
import 'package:next_to_manager/providers/residente_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MyAPI {
  BuildContext context;
  MyAPI({this.context});

  /*SINGLETON DE MyApi para tener una sola instancia*/
  MyAPI._internal();
  static MyAPI _instance = MyAPI._internal();
  static MyAPI get instance => _instance;

  List<dynamic> dataUser;

  Future<void> login(BuildContext context,
      {String email, String password}) async {
    try {
      var url = "https://ssolutiones.com/prueba_nextToManager/login.php";
      var data = {
        "email": email,
        "password": password,
      };
      var res = await http.post(url, body: data);
      dataUser = json.decode(res.body);
      Map mapaData = dataUser[0] as Map;

      if (mapaData.containsValue('true')) {
        print("LOGIN CORECTO");
        //SHARED PREFERENCES
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setBool("isLogin", true);
        pref.setString("email", email);

        //LOGIN EXITOSO
        Fluttertoast.showToast(
            msg: 'Bienvenido a Next To Manager',
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.green);

        final paciente = await getUserInfo(email);
        Provider.of<ResidenteProvider>(context, listen: false)
            .setUserPreferences(paciente);
        /*------------------------------------------------------*/
        Navigator.popAndPushNamed(context, HomeResidentePage.id);
        /* Navigator.pushNamedAndRemoveUntil(
            context, HomeResidentePage.id, (_) => false);*/
      } else if (mapaData.containsValue('false')) {
        print("LOGIN inCOrRECTO");
        //SHARED PREFERENCES
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setBool("isLogin", false);
        //LOGIN NO EXITOSO
        Fluttertoast.showToast(
            msg: 'Error credenciales',
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red);
      }
    } catch (e) {
      print(e);
    }
  }

  //print(mapaData);

//GET PROFILE INFO
  Future<Residente> getUserInfo(String email) async {
    try {
      var url =
          "http://ssolutiones.com/prueba_nextToManager/obtenerUsuario.php?email=" +
              email;
      var data = {
        "email": email,
      };
      var res = await http.post(url, body: data);

      dataUser = json.decode(res.body);
      Map mapaData = dataUser[0] as Map;
      return Residente.fromJson(mapaData);
    } catch (e) {
      print('entró al catch de getUser info');
      print(e);
      return null;
    }
  }

/*--------------------------------------------------------------------------*/

  Future<void> loginAdmin(BuildContext context,
      {String email, String password}) async {
    try {
      var url = "https://ssolutiones.com/prueba_nextToManager/LoginAdm.php";
      var data = {
        "email": email,
        "password": password,
      };
      var res = await http.post(url, body: data);
      dataUser = json.decode(res.body);
      Map mapaData = dataUser[0] as Map;

      if (mapaData.containsValue('true')) {
        print("LOGIN CORECTO");
        //SHARED PREFERENCES
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setBool("isLogin", true);
        pref.setString("email", email);

        //LOGIN EXITOSO
        Fluttertoast.showToast(
            msg: 'Bienvenido a Next To Manager',
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.green);

       
        /*------------------------------------------------------*/
        Navigator.popAndPushNamed(context, HomeAdminPage.id);
        /* Navigator.pushNamedAndRemoveUntil(
            context, HomeResidentePage.id, (_) => false);*/
      } else if (mapaData.containsValue('false')) {
        print("LOGIN inCOrRECTO");
        //SHARED PREFERENCES
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setBool("isLogin", false);
        //LOGIN NO EXITOSO
        Fluttertoast.showToast(
            msg: 'Error credenciales',
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red);
      }
    } catch (e) {
      print(e);
    }
  }
}
