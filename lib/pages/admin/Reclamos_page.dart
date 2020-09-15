import 'package:flutter/material.dart';

import '../../constants.dart';

class ReclamosPage extends StatefulWidget {
  static String id = 'reclamos_page';

  @override
  _ReclamosPageState createState() => _ReclamosPageState();
}

class _ReclamosPageState extends State<ReclamosPage> {
  List<dynamic> data = List<dynamic>(3);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("RECLAMOS"),
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          width: double.maxFinite,
          child: ListView(
            children: _listaReclamos(data),
          ),
        ),
      ),
    );
  }

  List<Widget> _listaReclamos(List<dynamic> data) {
    final List<Widget> cards = [];

    data.forEach((element) {
      final card = SolicitudCard(
        fechaSolicitud: "MIERCOLES 2 DE SEPTIEMBRE",
        onPressed: null,
        tipoSolicitud: "RECLAMO",
        tituloSolicitud: "Recoleccion de plasticos",
      );
      cards.add(card);
      cards.add(
        //divider entre cada uno
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Divider(
            indent: 2.0,
            endIndent: 2.0,
            height: 6.0,
          ),
        ),
      );
    });
    return cards;
  }
}

class SolicitudCard extends StatelessWidget {
  SolicitudCard(
      {@required this.tituloSolicitud,
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
        child: Expanded(
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
      ),
    );
  }
}
