String validateNomApe(String value) {
  //mejorar, que no permita simbolos
  if (value.length < 3)
    return 'digite un nombre o apellido valido';
  else
    return null;
}

String validateCedula(String value) {
  if (value.length < 6)
    return 'Digite una cédula válida';
  else
    return null;
}

String validateTelefono(String value) {
  if (value.length < 10)
    return 'Digite una cédula válida';
  else
    return null;
}

String validatePassword(String value) {
  //mejorar, que no permita simbolos
  if (value.length < 5)
    return 'Contraseña debe ser de minimo 5 caracteres';
  else
    return null;
}

String validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value))
    return 'Digite un email válido';
  else
    return null;
}
