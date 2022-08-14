import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../driver/students_detail.dart';
import '../parent/datatwo.dart';
import '../phone_login_two_type_user/login_splash.dart';
import 'active_driver.dart';
import 'blocked_driver.dart';
class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(title: Text("Admin"),
            actions: [
              new IconButton(onPressed: () async {
               // await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context
                  , MaterialPageRoute(builder: (_)=> LoginSplash()),
                );

              },
                  icon: Icon(Icons.logout)),
            ],
          ),
         // drawer: NavigationDrawerWidgetAdmin(),
            body: SingleChildScrollView(
              child:Column(
                children: [
                  if (_selectedIndex == 0) ...[
                    Container(
                      height: MediaQuery.of(context).size.height*0.80,
                      width: MediaQuery.of(context).size.width,
                      child: ActiveDriver(),
                    ),
                  ]
                  else if (_selectedIndex == 1) ...[
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.82 ,
                      width: MediaQuery.of(context).size.width,
                      child:BlockedDriver(),
                      //FirebaseAuth.instance.currentUser==null? SignIn():account(),
                    ),
                  ]
                ],
              )


        ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,

              items: const <BottomNavigationBarItem>[

                BottomNavigationBarItem(
                  icon: Icon(Icons.drive_eta_rounded),
                  label: 'Active',
                ),BottomNavigationBarItem(
                  icon: Icon(Icons.drive_eta_rounded),
                  label: 'Blocked',
                ),

              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.blue,
              onTap: _onItemTapped,
            )



    ));
  }

}
