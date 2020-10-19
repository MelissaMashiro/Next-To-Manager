import 'package:flutter/material.dart';

import '../../constants.dart';

class SolicitudCard extends StatelessWidget {
  SolicitudCard(
      {this.tituloSolicitud = "",
      @required this.tipoSolicitud,
      @required this.fechaSolicitud,
      @required this.onPressed});

  final String tituloSolicitud;
  final String tipoSolicitud;
  final String fechaSolicitud;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tituloSolicitud,
                    style: TextStyle(
                        color: kMainColorDark,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  Text(
                    tipoSolicitud,
                    style: TextStyle(color: kMainColorDark, fontSize: 15),
                  ),
                  Text(
                    fechaSolicitud,
                    style: TextStyle(color: Colors.black, fontSize: 11),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Material(
                elevation: 5.0,
                color: kMainColor,
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                    minWidth: 30.0,
                    height: 10.0,
                    onPressed: onPressed,
                    child: Text('Detalles')),
              ),
            )
          ],
        ),
      ),
    );
  }
}
