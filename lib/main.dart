import 'dart:io';
import 'package:next_to_manager/providers/solicitudes_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:next_to_manager/constants.dart';
import 'package:next_to_manager/pages/admin/LoginAdministrador_page.dart';
import 'package:next_to_manager/pages/admin/Quejas_page.dart';
import 'package:next_to_manager/pages/admin/Reclamos_page.dart';
import 'package:next_to_manager/pages/admin/Sugerencias_page.dart';
import 'package:next_to_manager/pages/admin/homeAdmin_page.dart';
import 'package:next_to_manager/pages/residente/CrearSolicitud_page.dart';
import 'package:next_to_manager/pages/residente/Historial_page.dart';
import 'package:next_to_manager/pages/residente/LoginResidente_page.dart';
import 'package:next_to_manager/pages/LoginSelect_page.dart';
import 'package:next_to_manager/pages/residente/Registration_page.dart';
import 'package:next_to_manager/pages/residente/homeResidente_page.dart';

import 'components/services/services.dart';
import 'providers/residente_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
  HttpOverrides.global =
      new MyHttpOverrides(); //solo usar para proposito de desarrollo y no prroduccion
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => solicitudesProvider),
        ChangeNotifierProvider(create: (_) => new ResidenteProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Next to Manager',
        theme: ThemeData(
          primaryColor: kMainColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: LoginSelect.id,
        routes: {
          LoginSelect.id: (context) => LoginSelect(),
          LoginAdmin.id: (context) => LoginAdmin(),
          LoginResidente.id: (context) => LoginResidente(),
          RegistrationPage.id: (context) => RegistrationPage(),
          HomeResidentePage.id: (context) => HomeResidentePage(),
          HomeAdminPage.id: (context) => HomeAdminPage(),
          HistorialPage.id: (context) => HistorialPage(),
          SugerenciasPage.id: (context) => SugerenciasPage(),
          QuejasPage.id: (context) => QuejasPage(),
          ReclamosPage.id: (context) => ReclamosPage(),
          CrearSolicitudPage.id: (context) => CrearSolicitudPage(),
        },
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
