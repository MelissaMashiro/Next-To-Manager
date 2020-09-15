import 'package:flutter/material.dart';
import 'package:next_to_manager/pages/admin/Quejas_page.dart';
import 'package:next_to_manager/pages/admin/Reclamos_page.dart';

import 'Sugerencias_page.dart';

class HomeAdminPage extends StatefulWidget {
  static String id = 'homeAdmin_page';

  @override
  _HomeAdminPageState createState() => _HomeAdminPageState();
}

class _HomeAdminPageState extends State<HomeAdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HOME"),
      ),
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
                            Navigator.pushNamed(context, ReclamosPage.id);
                          },
                          child: Image.asset(
                            'assets/images/quote.png',
                            width: 100,
                          ),
                        )),
                    Text("RECLAMOS",
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
                            Navigator.pushNamed(context, SugerenciasPage.id);
                          },
                          child: Image.asset(
                            'assets/images/quote.png',
                            width: 100,
                          ),
                        )),
                    Text("SUGERENCIAS",
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
                            Navigator.pushNamed(context, QuejasPage.id);
                          },
                          child: Image.asset(
                            'assets/images/quote.png',
                            width: 100,
                          ),
                        )),
                    Text("QUEJAS",
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
                            'assets/images/logout.png',
                            width: 90,
                          ),
                        )),
                    Text(" LOGOUT",
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
