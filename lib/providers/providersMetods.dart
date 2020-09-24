//para el root bundle
import 'dart:convert';
//para leer el archivo JSON necesito un archivo propio que viene de flutter
import 'package:http/http.dart' as http;

//este archivo será para manejar los datos provinientes del JSON

class _SolicitudesProvider {
  List<dynamic> solicitudes = [];

  _SolicitudesProvider() {
    //cargarData();
  }

  //como necesito que esto se cargue enseguida antes de todo, creare un Async await para manejar su momento de ejecucion
  Future<List<dynamic>> cargarData() async {
    var url =
        "https://ssolutiones.com/prueba_nextToManager/obtenerSolicitudes.php";

    var res = await http.post(url);

    solicitudes = json.decode(res.body);

    return solicitudes;
  }
}



//Instancia de la que hablé arriba -de esta manera el menu provider SOLO ESTA EXPONIENDO LA INSTANCIA CREADA DEL MENU PROV
final solicitudesProvider = new _SolicitudesProvider();
