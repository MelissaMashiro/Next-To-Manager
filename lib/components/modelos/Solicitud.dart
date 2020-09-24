import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Solicitud {
  // int idUsuario;
  int idSolicitud;
  String fecha;
  String tipoSolicitud;
  int descripcion;
  String telefono;
  String email;
  String torre;
  int apto;

  Solicitud(
      {this.idSolicitud,
      this.fecha,
      this.tipoSolicitud,
      this.descripcion,
      this.telefono,
      this.email,
      this.apto});

  factory Solicitud.fromJson(Map<String, dynamic> json) {
    return Solicitud(
      idSolicitud: json['idSolicitud'] as int,
      email: json['email'] as String,
    );
  }
}
