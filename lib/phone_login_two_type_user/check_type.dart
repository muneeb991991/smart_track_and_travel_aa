import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../driver/home_driver.dart';
import '../parent/home_parent.dart';
import '../user_password.dart';

class CheckType extends StatefulWidget {
  const CheckType({Key? key}) : super(key: key);
  @override
  State<CheckType> createState() => _CheckTypeState();
}

class _CheckTypeState extends State<CheckType> {
  @override
  void initState() {
    inputDat();
    // TODO: implement initState
    super.initState();
    String equal=q.r+"Parent";
    Query referenceData =FirebaseDatabase.instance.reference().child("applock").orderByChild('uid').equalTo(equal);
    referenceData.once().then((DataSnapshot event) {
      var values = event.value;
      if (values == null) {

        String equal1=q.r+"Driver";
        print(q.r);
        Query referenceDat =FirebaseDatabase.instance.reference().child("applock").orderByChild('uid').equalTo(equal1);
        referenceDat.once().then((DataSnapshot event) {
          print("llln");
          var values = event.value;
          if (values == null) {
            Navigator.of(context)
                .pushReplacement(
                MaterialPageRoute(builder: (context) => UserPassword()));
          }
          else {
            Navigator.of(context)
                .pushReplacement(
                MaterialPageRoute(builder: (context) => HomeDriver()));
          }
          setState(() {});
        });

      }
      else {
          Navigator.of(context)
              .pushReplacement(
              MaterialPageRoute(builder: (context) => HomeParent()));
      }
      setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height*0.06,
                width: MediaQuery.of(context).size.width,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.10,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    const Text("Smart Track And",style: TextStyle(
                      //fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.blue
                    ),),
                    const Text("Travel",style: TextStyle(
                      //fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.blue
                    ),),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.425,
                width: MediaQuery.of(context).size.width,
                child:Image.asset('assets/images/stlogo.jpeg'),
              ),
              Container(
                height: MediaQuery.of(context).size.height*0.373,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.width*0.07,
                      ),
                      Text("Smart Track & Travel",style: TextStyle(color: Colors.white,fontSize: 25),),
                      SizedBox(
                        height: MediaQuery.of(context).size.width*0.10,
                      ),
                      Text("Welcome to Smart Track & Travel",style: TextStyle(color: Colors.white,fontSize: 19),),
                      Text("Let's Start working with us",style: TextStyle(color: Colors.white,fontSize: 19),),
                      // Text("Smart Track & Travel",style: TextStyle(color: Colors.white,fontSize: 19),),

                      SizedBox(
                        height: MediaQuery.of(context).size.width*0.10,
                      ),
                      CircularProgressIndicator(
                        color: Colors.white,
                      ),



                    ],
                  ),
                ),
                decoration: new BoxDecoration(
                  color: Colors.blue,

                  borderRadius: BorderRadius.vertical(

                      top: Radius.elliptical(
                          MediaQuery.of(context).size.width, 100.0)),

                ),

              ),
            ],
          ),
        ),
      ),
    );
  }
  void inputDat() {
    final FirebaseAuth auth = FirebaseAuth.instance;
      final User? user = auth.currentUser;
      final uid = user?.uid;
      String? l =uid;
      q.r=l!;
  }
}
class q{
  static String r='';
}
