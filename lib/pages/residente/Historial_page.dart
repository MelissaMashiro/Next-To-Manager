import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:next_to_manager/constants.dart';
import 'package:http/http.dart' as http;
import 'package:next_to_manager/pages/residente/Detalles_page.dart';
import 'package:next_to_manager/providers/providersMetods.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class HistorialPage extends StatefulWidget {
  static String id = 'historial_page';

  @override
  _HistorialPageState createState() => _HistorialPageState();
}

class _HistorialPageState extends State<HistorialPage> {
  bool _isInAsyncCall = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("SOLICITUDES"),
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          width: double.maxFinite,
          child: ModalProgressHUD(
              color: Colors.black,
              inAsyncCall: _isInAsyncCall,
              opacity: 0.5,
              progressIndicator: CircularProgressIndicator(
                backgroundColor: kMainColor,
                valueColor: AlwaysStoppedAnimation<Color>(kMainColorDark),
              ),
              child: _lista()),
        ),
      ),
    );
  }

  Widget _lista() {
    return FutureBuilder(
      //el fuuture uilder no puede retornar una lista, solo un Widget

      future: solicitudesProvider.cargarData(),
      initialData: [], //es la info que tendra por defecto mientras no se ha resuelto ese future(podria ser una fila vacia)
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        //retonra un widget builder osea algo q permitira dibujar en la pantalla

        return ListView(
          //necesito leer un archivo Json para ir a gregando alli todas las opciones y posterior rmente revisalas en base a un JSON
          children: _listaSolicitudes(snapshot.data, context),
        );
      },
    );
  }

  List<Widget> _listaSolicitudes(List<dynamic> data, BuildContext context) {
    final List<Widget> cards = [];

    data.forEach((solicitud) {
      final card = SolicitudCard(
        fechaSolicitud: solicitud['fecha'],
        onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => DetalleSolicitudPage(
                        descripcion: solicitud['descripcion'],
                        fecha: solicitud['fecha'],
                        motivo: solicitud['motivo'],
                      )));
        },
        tipoSolicitud: solicitud['tipo_solicitud'],
        tituloSolicitud: solicitud['motivo'],
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
/*
  List<dynamic> dataSoli;
  void verSolicitudes() async {
    var url =
        "https://ssolutiones.com/prueba_nextToManager/obtenerSolicitudes.php";

    var res = await http.post(url);

    dataSoli = json.decode(res.body);
    Map mapaData = dataSoli[0] as Map;
    print(mapaData);
    //print(dataSoli);
  }*/
}

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
