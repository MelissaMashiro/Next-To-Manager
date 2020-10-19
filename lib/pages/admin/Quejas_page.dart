import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:next_to_manager/components/modelos/Solicitud.dart';
import 'package:next_to_manager/components/recursos/custom_widgets.dart';
import 'package:next_to_manager/components/services/services.dart';
import 'package:next_to_manager/constants.dart';
import 'package:http/http.dart' as http;
import 'package:next_to_manager/pages/residente/Detalles_page.dart';
import 'package:next_to_manager/providers/solicitudes_provider.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class QuejasPage extends StatefulWidget {
  static String id = 'quejas_page';

  @override
  _QuejasPageState createState() => _QuejasPageState();
}

class _QuejasPageState extends State<QuejasPage> {
  bool _isInAsyncCall = false;
  @override
  Widget build(BuildContext context) {
    final solisProvider =
        Provider.of<SolicitudesProvider>(context, listen: true);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("SOLICITUDES QUEJAS"),
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
                child: ListView(
                  children:
                      _listaSolicitudes(solisProvider.ultimaLista, context),
                ))),
      ),
    );
  }

  Widget _lista() {
    return FutureBuilder(
      //el fuuture uilder no puede retornar una lista, solo un Widget

      future: solicitudesProvider.getSolicitudesQuejas(),
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

  List<Widget> _listaSolicitudes(List<Solicitud> data, BuildContext context) {
    final List<Widget> cards = [];

    data.forEach((solicitud) {
      final card = SolicitudCard(
        fechaSolicitud: solicitud.fecha,
        onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => DetalleSolicitudPage(
                        descripcion: solicitud.descripcion,
                        fecha: solicitud.fecha,
                        motivo: solicitud.motivo,
                      )));
        },
        tipoSolicitud: "solicitud.tipoSolicitud",
        tituloSolicitud: solicitud.motivo,
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
