import 'dart:convert';

import 'package:next_to_manager/pages/residente/models/residente_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyPreferences {
  //cambiar nombre
  final String _userInfo = 'userInfo';

  //persistir info obtenida
  void saveUserInformation(Residente paciente) async {
    final prefs = await SharedPreferences.getInstance();
    print(paciente);
    print(paciente.nombre);
    print(paciente.toJson());
    prefs.setString(_userInfo,
        paciente.toJson()); //convierte la info del paciente de un map a un JSON
  }

//traer info persistida
  Future<Residente> retrieveUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    var userInfo = prefs.getString(_userInfo);
    
    if (userInfo != null) {
      print("info persistida solicitada: " + userInfo);
//decodifica la info que habia codificado en un string de la info del usuario, para poder ser usada como Map (invertir el proceso al haber persistido la info)
      return Residente.fromJson(jsonDecode(
          userInfo)); //user info es un json(Map) que se retorna y decodificado
    } else {
      return null;
    }
  }
}
