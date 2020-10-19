import 'dart:convert';

class Residente {
  String idUsuario;
  String nombre;
  String torre;
  String numeroApto;
  String cedula;
  String telefono;
  String email;

  Residente(
      {this.idUsuario,
      this.nombre,
      this.torre,
      this.numeroApto,
      this.cedula,
      this.telefono,
      this.email});

  static Residente fromJson(Map<String, dynamic> json) {
    return Residente(
        idUsuario: json["idUsuario"],
        nombre: json["nombre"],
        torre: json["torre"],
        numeroApto: json["numero_apto"],
        cedula: json["cedula"],
        telefono: json["telefono"],
        email: json["email"]);
  }

/*--------------------PARA GUARDAR EN LAS PREFERENCIAS-------------------------*/

  Map<String, dynamic> toMap() => {
        'idUsuario': idUsuario,
        'nombre': nombre,
        'torre': torre,
        'numero_apto': numeroApto,
        'cedula': cedula,
        'telefono': telefono,
        'email': email
      };

  String toJson() => json.encode(
      toMap()); //convierte el map de la info del paciente a un json(STRING)

}
