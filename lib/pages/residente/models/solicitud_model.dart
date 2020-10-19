// To parse this JSON data, do
//
//     final solicitud = solicitudFromJson(jsonString);

import 'dart:convert';

Solicitud solicitudFromJson(String str) => Solicitud.fromJson(json.decode(str));

String solicitudToJson(Solicitud data) => json.encode(data.toJson());

class Solicitud {
  Solicitud({
    this.idSolicitud,
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
    this.cedula,
  });

  String idSolicitud;
  String idUsuario;
  DateTime fecha;
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

  factory Solicitud.fromJson(Map<String, dynamic> json) => Solicitud(
        idSolicitud: json["idSolicitud"],
        idUsuario: json["idUsuario"],
        fecha: DateTime.parse(json["fecha"]),
        tipoSolicitud: json["tipo_solicitud"],
        motivo: json["motivo"],
        descripcion: json["descripcion"],
        revisado: json["revisado"],
        nombre: json["nombre"],
        telefono: json["telefono"],
        email: json["email"],
        torre: json["torre"],
        numeroApto: json["numero_apto"],
        cedula: json["cedula"],
      );

  Map<String, dynamic> toJson() => {
        "idSolicitud": idSolicitud,
        "idUsuario": idUsuario,
        "fecha": fecha.toIso8601String(),
        "tipo_solicitud": tipoSolicitud,
        "motivo": motivo,
        "descripcion": descripcion,
        "revisado": revisado,
        "nombre": nombre,
        "telefono": telefono,
        "email": email,
        "torre": torre,
        "numero_apto": numeroApto,
        "cedula": cedula,
      };
}
