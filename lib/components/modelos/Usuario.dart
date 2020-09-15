class Usuario {
  String nombres;
  String apellidos;
  int cedula;
  String email;
  String password;
  String torre;
  int apto;

  Usuario(
      {this.nombres,
      this.apellidos,
      this.cedula,
      this.email,
      this.password,
      this.torre,
      this.apto});

  String getNombres() {
    return nombres;
  }

  String getApellidos() {
    return apellidos;
  }

  int getCedula() {
    return cedula;
  }

  String getEmail() {
    return email;
  }

  String getPassword() {
    return password;
  }

  String getTorre() {
    return torre;
  }

  int getApto() {
    return apto;
  }
}
