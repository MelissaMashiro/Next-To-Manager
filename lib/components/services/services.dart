import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:next_to_manager/components/modelos/Solicitud.dart';

//http://192.168.0.50:3000/countries

final _URL_COUNTRIES = 'http://192.168.0.50:3000';

class SolicitudesService with ChangeNotifier {
  List<Map<String, dynamic>> solicitudes = [];
  List<Solicitud> listaSolicitudes = [];
  // bool _isLoading = true;

  SolicitudesService() {
    this.getCountries();
  }

  // bool get isLoading => this._isLoading;
  getCountries() async {
    final url =
        'https://ssolutiones.com/prueba_nextToManager/obtenerSolicitudes.php';
    final resp = await http.post(url);

    final soliResponse =
        json.decode(resp.body); //respbody devuele una list dynamic

    //Solicitud solicitud = new Solicitud.fromJson(soliResponse);
    //this.solicitudes.addAll(solicitud);

    solicitudes = new List<Map<String, dynamic>>.from(soliResponse);

    solicitudes.forEach((soli) {
      Solicitud solicitud = new Solicitud(
        idSolicitud: soli['idSolicitud'],
        idUsuario: soli['idUsuario'],
        fecha: soli['fecha'],
        tipoSolicitud: soli['tipoSolicitud'],
        motivo: soli['motivo'],
        descripcion: soli['descripcion'],
        revisado: soli['revisado'],
        nombre: soli['nombre'],
        telefono: soli['telefono'],
        email: soli['email'],
        torre: soli['torre'],
        numeroApto: soli['numeroApto'],
        cedula: soli['cedula'],
      );
      listaSolicitudes.add(solicitud);
    });
    notifyListeners();
  }
}
