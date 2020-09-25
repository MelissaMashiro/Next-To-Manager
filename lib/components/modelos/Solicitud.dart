import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Solicitud countriesResponseFromJson(String str) =>
    Solicitud.fromJson(json.decode(str));

class Solicitud {
  String idSolicitud;
  String idUsuario;
  String fecha;
  String tipoSolicitud;
  String motivo;
  String descripcion;
  String revisado;
  String nombre;
  String telefono;
  String email;
  String torre;
  String numeroApto;
  String cedula;

  String getEmail() {
    return this.email;
  }

  Solicitud(
      {this.idSolicitud,
      this.idUsuario,
      this.fecha,
      this.tipoSolicitud,
      this.motivo,
      this.descripcion,
      this.revisado,
      this.nombre,
      this.telefono,
      this.email,
      this.torre,
      this.numeroApto,
      this.cedula});

/*  factory Solicitud.fromJson(Map<String, dynamic> json) {
    return Solicitud(
      idSolicitud: json['idSolicitud'],
      email: json['email'],
    );
  }
*/
  factory Solicitud.fromJson(Map<String, dynamic> json) => Solicitud(
        idSolicitud: json['idSolicitud'],
        idUsuario: json['idUsuario'],
        fecha: json['fecha'],
        tipoSolicitud: json['tipoSolicitud'],
        motivo: json['motivo'],
        descripcion: json['descripcion'],
        revisado: json['revisado'],
        nombre: json['nombre'],
        telefono: json['telefono'],
        email: json['email'],
        torre: json['torre'],
        numeroApto: json['numeroApto'],
        cedula: json['cedula'],
      );
}
