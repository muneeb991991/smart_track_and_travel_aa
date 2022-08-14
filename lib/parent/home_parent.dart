import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Drawer.dart';
import '../driver/home_location.dart';
import '../driver/lata.dart';
import '../phone_login_two_type_user/login_splash.dart';
import '../phone_login_two_type_user/login_type.dart';
import '../phone_login_two_type_user/setting1.dart';
import 'available_drivers.dart';
import 'google_map.dart';
import 'home.dart';
class HomeParent extends StatefulWidget {

  const HomeParent({Key? key}) : super(key: key);

  @override
  State<HomeParent> createState() => _HomeParentState();
}

class _HomeParentState extends State<HomeParent> {


  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:
      Scaffold(
        appBar: AppBar(title: Text("Parent Side"),
          actions: [
            new IconButton(onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context
                , MaterialPageRoute(builder: (_)=> LoginSplash()),
              );

            },
                icon: Icon(Icons.logout)),
          ],
        ),
       // drawer: NavigationDrawerWidget(),

          body: Container(
            // color: Colors.black12,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (_selectedIndex == 0) ...[
                        Container(
                          height: MediaQuery.of(context).size.height*0.80,
                          width: MediaQuery.of(context).size.width,
                          child: Home1(),
                        ),
                  ]
                  else if (_selectedIndex == 1) ...[
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.82 ,
                      width: MediaQuery.of(context).size.width,
                      child:AvailableDriver(),
                      //FirebaseAuth.instance.currentUser==null? SignIn():account(),
                    ),
                  ]
                  else if (_selectedIndex == 2) ...[
                      SizedBox(
                        height: MediaQuery.of(context).size.height *0.82,
                        width: MediaQuery.of(context).size.width,
                        child: Setting1(),
                      ),
                    ]
                ],
              ),

            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,

            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.drive_eta_rounded),
                label: 'Drivers',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_applications),
                label: 'Setting',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.blue,
            onTap: _onItemTapped,
          )
      ),
    );
  }
}
