import 'package:flutter/material.dart';
import 'package:next_to_manager/pages/LoginSelect_page.dart';
import 'package:next_to_manager/pages/residente/CrearSolicitud_page.dart';
import 'package:next_to_manager/pages/residente/Historial_page.dart';
import 'package:next_to_manager/pages/residente/LoginResidente_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeResidentePage extends StatefulWidget {
  static String id = 'homeResidente_page';

  @override
  _HomeResidentePageState createState() => _HomeResidentePageState();
}

class _HomeResidentePageState extends State<HomeResidentePage> {
  String emailUser = "";
  Future _checkLogin() async {
//SHARED PREFERENCES
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getBool("isLogin") == false) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => LoginResidente()));
    }
  }

  Future _Logout() async {
//SHARED PREFERENCES
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("isLogin", false);
    //Navigator.pushNamed(context, LoginResidente.id);
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => LoginSelect()));
  }

  Future _checkUser() async {
//SHARED PREFERENCES
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString("email") != null) {
      setState(() {
        emailUser = pref.getString("email");
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _checkLogin();
    _checkUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.6), BlendMode.dstATop),
            fit: BoxFit.cover,
            image: AssetImage('assets/images/fondoeditado.jpg'),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: new BorderRadius.circular(20),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CrearSolicitudPage(
                                        emailController: emailUser)));
                          },
                          child: Image.asset(
                            'assets/images/quote.png',
                            width: 100,
                          ),
                        )),
                    Text(" RADICAR\nSOLICITUD",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20))
                  ],
                ),
                Column(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: new BorderRadius.circular(20),
                        ),
                        child: InkWell(
                          onTap: () {},
                          child: Image.asset(
                            'assets/images/profile.png',
                            width: 100,
                          ),
                        )),
                    Text(" PERFIL",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20))
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: new BorderRadius.circular(20),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, HistorialPage.id);
                          },
                          child: Image.asset(
                            'assets/images/historial.png',
                            width: 100,
                          ),
                        )),
                    Text(" HISTORIAL",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20))
                  ],
                ),
                Column(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: new BorderRadius.circular(20),
                        ),
                        child: InkWell(
                          onTap: () {
                            /*FlutterSession().set('token', '');
                            print(FlutterSession().get('token'));
                            print('loguting');*/
                            _Logout();
                          },
                          child: Image.asset(
                            'assets/images/logout.png',
                            width: 90,
                          ),
                        )),
                    Text(" LOG OUT",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20))
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
