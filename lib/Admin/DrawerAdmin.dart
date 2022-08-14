import 'package:flutter/material.dart';

import 'blocked_driver.dart';



class NavigationDrawerWidgetAdmin extends StatefulWidget {
  const NavigationDrawerWidgetAdmin({Key? key}) : super(key: key);

  @override
  _NavigationDrawerWidgetState createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidgetAdmin> {
  List<String> number = [];

  @override
  Widget build(BuildContext context) {
    return Drawer(

      child: Material(



        child: ListView(
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            const Text(
              ' Admin Panel',

              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue),
            ),
            const SizedBox(
              height: 20,
            ),
            /*Text(
              '  2 Shabbir Rd, Cantt,Lahore,Punjab 54100, Pakistan',

              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),

            ),*/
            const SizedBox(
              height: 20,
            ),
            const Divider(
              height: 1,
            ),

            /*const SizedBox(height: 0),
            buildMenuItem(
              text: 'Categories',
              icon: Icons.category,
              onClicked: ()=> selectedItem(context,0),
            ),*/
            const SizedBox(height: 0),
            buildMenuItem(
              text: 'Blocked Driver',
              icon: Icons.drive_eta_rounded,
              onClicked: ()=> selectedItem(context,1),
            ),
            const SizedBox(height: 0),
            buildMenuItem(
              text: 'Blocked Parent',
              icon: Icons.person,
              onClicked: ()=> selectedItem(context,2),
            ),
            const SizedBox(height: 0),
            buildMenuItem(
              text: 'Logout',
              icon: Icons.logout,
              onClicked: ()=> selectedItem(context,3),
            ),
            /*const SizedBox(height: 0),
            buildMenuItem(
              text: 'Grocer Club',
              icon: Icons.card_membership,
              onClicked: ()=> selectedItem(context,4),
            ),*/
            /*const SizedBox(height: 0),
            buildMenuItem(
              text: 'Share & Earn',
              icon: Icons.attach_money,
              onClicked: ()=> selectedItem(context,5),
            ),*/
           /* const SizedBox(height: 0),
            buildMenuItem(
              text: 'Promo Alerts',
              icon: Icons.doorbell_outlined,
              onClicked: ()=> selectedItem(context,6),
            ),*/
            /*const SizedBox(height: 0),
            buildMenuItem(
              text: 'share',
              icon: Icons.share,
              onClicked: ()=> selectedItem(context,7),
            ),*/
            // const SizedBox(height: 0),
            // buildMenuItem(
            //   text: 'FAQs',
            //   icon: Icons.question_answer,
            //   onClicked: ()=> selectedItem(context,8),
            // ),
            /*const SizedBox(height: 0),
            buildMenuItem(
              text: 'Live Chat',
              icon: Icons.chat,
              onClicked: ()=> selectedItem(context,9),
            ),*/
            // const SizedBox(height: 0),
            // buildMenuItem(
            //   text: 'Call Us',
            //   icon: Icons.phone,
            //   onClicked: ()=> selectedItem(context,10),
            // ),
            // const SizedBox(height: 0),
            // buildMenuItem(
            //   text: 'Brands',
            //   icon: Icons.branding_watermark,
            //   onClicked: ()=> selectedItem(context,11),
            // ),
            /*const SizedBox(height: 0),
            buildMenuItem(
              text: 'App Inbox',
              icon: Icons.email,
              onClicked: ()=> selectedItem(context,12),
            ),*/
            // const SizedBox(height: 0),
            // buildMenuItem(
            //   text: 'Sign In',
            //   icon: Icons.power_settings_new,
            //   onClicked: ()=> selectedItem(context,13),
            // ),

          ],
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color =Colors.black;
    final hoverColor =Colors.white70;
    return ListTile(
      leading: Icon(icon,color: color,),
      title: Text(text,style: TextStyle(color: color),),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  selectedItem(BuildContext context, int i) {
    switch (i){
      case 0:
       // Navigator.of(context).push(MaterialPageRoute(builder: (context) => CATGEORY(),));
    }
    switch (i){
      case 1:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => BlockedDriver(),));
    }
    switch (i){

      case 2:
        // number.add(orderN0.numb);
        // Navigator.of(context).push(MaterialPageRoute(builder: (context) => pansal(),));
    }
    switch (i){
      case 3:
       // Navigator.of(context).push(MaterialPageRoute(builder: (context) => Products(),));
    }
    switch (i){
      case 4:
       // Navigator.of(context).push(MaterialPageRoute(builder: (context) => Home(),));
    }
    switch (i){
      case 5:
       // Navigator.of(context).push(MaterialPageRoute(builder: (context) => Beverage(),));
    }
    switch (i){
      case 6:
       // Navigator.of(context).push(MaterialPageRoute(builder: (context) => Home(),));
    }
    switch (i){
      case 7:
       // Navigator.of(context).push(MaterialPageRoute(builder: (context) => Home(),));
    }
    switch (i){
      case 8:
       // Navigator.of(context).push(MaterialPageRoute(builder: (context) => FAQs(),));
    }
    switch (i){
      case 9:
       // Navigator.of(context).push(MaterialPageRoute(builder: (context) => Home(),));
    }
    switch (i){
      case 10:
        //Navigator.of(context).push(MaterialPageRoute(builder: (context) => Phone(),));
    }
    switch (i){
      case 11:
       // Navigator.of(context).push(MaterialPageRoute(builder: (context) => Brands(),));
    }
    switch (i){
      case 12:
       // Navigator.of(context).push(MaterialPageRoute(builder: (context) => Home(),));
    }
    switch (i){
      case 13:
        //Navigator.of(context).push(MaterialPageRoute(builder: (context) => Home(),));
    }
  }
}