import 'package:flutter/cupertino.dart';
import 'package:next_to_manager/pages/residente/models/residente_model.dart';
import 'package:next_to_manager/pages/residente/services/user_preferences.dart';

class ResidenteProvider with ChangeNotifier {
  Residente paciente = Residente();

  ResidenteProvider() {
    print("llamando al provider residente info");
    this.retrieveUser(); //cargar info persistida
  }
  //cambiar nombre a: cargarPaciente
  void retrieveUser() async {
    final paciente =
        await MyPreferences().retrieveUserInfo(); //traer info guardada en pref
    if (paciente != null) {
      print("info guardada es nula");
      //print('Paciente solicitado en el perfil:  ${paciente.toJson()}');
      setUserPreferences(paciente);
    } //carga la informacion persistida del paciente
  }

  void setUserPreferences(infoPaciente) {
    paciente = infoPaciente;
    print(
        "email del paciente: " + paciente.email + " nombre:" + paciente.nombre);
    MyPreferences().saveUserInformation(paciente);
    notifyListeners();
  }
}
