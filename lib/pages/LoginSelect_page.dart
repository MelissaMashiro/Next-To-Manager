import 'package:flutter/material.dart';
import 'package:next_to_manager/components/recursos/logo.dart';
import 'package:next_to_manager/constants.dart';
import 'package:next_to_manager/pages/admin/LoginAdministrador_page.dart';
import 'package:next_to_manager/pages/residente/LoginResidente_page.dart';

class LoginSelect extends StatelessWidget {
  static String id = 'loginSelect_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: // C7CADC
              LinearGradient(
                  colors: [kMainColor, kMainColorLight],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LogoImage(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  elevation: 5.0,
                  color: Colors.grey[850],
                  borderRadius: BorderRadius.circular(30.0),
                  child: MaterialButton(
                      onPressed: () {
                        Navigator.pushNamed(context, LoginAdmin.id);
                      },
                      minWidth: 100.0,
                      height: 60.0,
                      child: Text(
                        "ADMINISTRADOR",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3.0),
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  elevation: 5.0,
                  color: Colors.grey[850],
                  borderRadius: BorderRadius.circular(30.0),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pushNamed(context, LoginResidente.id);
                    },
                    minWidth: 100.0,
                    height: 60.0,
                    child: Text(
                      "RESIDENTE",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 3.0),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
