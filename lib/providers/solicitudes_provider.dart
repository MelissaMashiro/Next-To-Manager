import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:next_to_manager/components/modelos/Solicitud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SolicitudesProvider with ChangeNotifier {
  BuildContext context;
  SolicitudesProvider({this.context}) {
    this.getSolicitudesQuejas();
  }

  List<dynamic> solicitudes = [];
  List<Map<String, dynamic>> solicitudesMaps = [];
  List<Solicitud> listaSolicitudes = [];
  List<dynamic> listaSolicitudesQueja = [];
  List<Solicitud> ultimaLista = [];
  Future<List<dynamic>> cargarAllSolicitudes() async {
    // final _residente = Provider.of<ResidenteProvider>(context).paciente;
    var url =
        "https://ssolutiones.com/prueba_nextToManager/obtenerSolicitudes.php";

    var res = await http.post(url);

    solicitudes = json.decode(res.body);

    return solicitudes;
  }

  getSolicitudesQuejas() async {
    final url =
        'https://ssolutiones.com/prueba_nextToManager/obtenerSolicitudes.php';
    final resp = await http.post(url);
    try {
      final paisesResponse = json.decode(resp.body); //List<dynamic>
      solicitudesMaps = new List<Map<String, dynamic>>.from(paisesResponse);
      //creando lista de paises a partir del map del json
      listaSolicitudes =
          solicitudesMaps.map((e) => Solicitud.fromJson(e)).toList();
      print('vamos al for..');
      solicitudes = json.decode(resp.body);
      for (var soli in solicitudes) {
        if (soli['tipo_solicitud'] == "QUEJA") {
          listaSolicitudesQueja.add(soli);
        }
      }
      ultimaLista =
          listaSolicitudesQueja.map((e) => Solicitud.fromJson(e)).toList();
      print("salio bien peticion");
      // print('todas solicitudes: $listaSolicitudes');
      //print('quejas:');
      print(ultimaLista);
      // return listaSolicitudesQueja;||||
      notifyListeners();
    } catch (e) {
      return null;
    }
  }

  Future<List<dynamic>> cargarSoliPorUsuario() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    String emailUser = pref.getString("email");
    // this.paciente = await MyAPI.instance.getUserInfo();
    print('haciendo peticion para ver solicitudes');

    print("email pasado:" + emailUser);
    var url =
        "http://ssolutiones.com/prueba_nextToManager/obtenerSolicitud.php?email=" +
            emailUser;
    var data = {
      "email": emailUser,
    };
    print("email pasado:" + emailUser);

    var res = await http.post(url, body: data);
    print(res);
    solicitudes = json.decode(res.body);
    print("solicitudes recibidas:");
    print(solicitudes);
    return solicitudes;
  }
}

final solicitudesProvider = new SolicitudesProvider();
