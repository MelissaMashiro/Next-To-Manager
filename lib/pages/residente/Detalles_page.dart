import 'package:flutter/material.dart';
import 'package:next_to_manager/constants.dart';

class DetalleSolicitudPage extends StatelessWidget {
  static String id = 'detalleSolicitud_page';
  DetalleSolicitudPage(
      {@required this.motivo,
      @required this.fecha,
      @required this.descripcion});
  final String motivo;
  final String fecha;
  final String descripcion;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        color: kMainColorExtraLight,
        child: ListView(
          children: [
            Text("MOTIVO:"),
            Text(motivo),
            Text("Fecha"),
            Text(fecha),
            Text("Descripcion"),
            Text(descripcion),
          ],
        ),
      )),
    );
  }
}
