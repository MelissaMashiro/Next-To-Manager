import 'package:flutter/material.dart';
import 'package:next_to_manager/components/recursos/RoundedButton.dart';
import 'package:next_to_manager/components/services/services.dart';
import 'package:provider/provider.dart';

class PruebaPaises extends StatefulWidget {
  @override
  _PruebaPaisesState createState() => _PruebaPaisesState();
}

class _PruebaPaisesState extends State<PruebaPaises> {
  @override
  Widget build(BuildContext context) {
    final solicitudesService = Provider.of<SolicitudesService>(context);
    //paisesService.countries;
    return Container(
      child: RoundedButton(
          text: Text("paises"),
          onPressed: () {
            for (var soli in solicitudesService.listaSolicitudes) {
              print("Cedula" + soli.cedula);
            }
          }),
    );
  }
}
