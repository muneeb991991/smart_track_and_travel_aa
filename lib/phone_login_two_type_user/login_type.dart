import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


import '../driver/driver_profile.dart';
import '../driver/home_driver.dart';
import '../parent/home_parent.dart';

class LoginType extends StatefulWidget {
  const LoginType({Key? key}) : super(key: key);

  @override
  State<LoginType> createState() => _LoginTypeState();

}
final FirebaseAuth auth = FirebaseAuth.instance;


class _LoginTypeState extends State<LoginType> {
  void inputData() {
    final User? user = auth.currentUser;
    final uid = user?.uid;
    String? l =uid;
    q.r=l!;
  }
  String image='';
  String DriverName='';
  String phoneno='';
  String totalseats='';
  String reserve='';
  String available='';
  String route='';
  String vehicalno='';
  String vehicalcolor='';
  String dues='';
  String uoid='';
  late DatabaseReference _reference;
  late DatabaseReference _referenc;
  void initState() {
    inputData();
    // TODO: implement initState
    super.initState();
    _reference =FirebaseDatabase.instance.reference().child('LoginType');
    _referenc =FirebaseDatabase.instance.reference().child('applock');
    Query referenceData =FirebaseDatabase.instance.reference().child("Drivers").orderByChild("uid").equalTo(q.r);
    referenceData.once().then((DataSnapshot event) {
      //sataList.clear();
      // var keys = event.value;
      var values = event.value;
      print("llllllllllllllllll");
      // DataSnapshot snapshot = event.value;
      Map<dynamic,dynamic> map = values as Map<dynamic,dynamic>;

      print(map);
      // var values = dataSnapshot.value;
      print("values");
      print(values);
      map.forEach((key,value){
        print(value);
        var pic = value['picUrl'];
        var due = value['dues'];
        var vc = value['vehicalcilor'];
        var vn = value['vahicalno'];
        var r = value['route'];
        var av = value['availableseats'];
        var re = value['reserveseats'];
        var ts = value['totalseats'];
        var pn = value['phone'];
        var dn = value['name'];
        var id = value['uid'];

        uoid=id;
        image=pic;
        DriverName=dn;
        phoneno=pn;
        totalseats=ts;
        reserve=re;
        available=av;
        route=r;
        //image=pic;

        vehicalcolor=vc;
        dues=due;
        vehicalno=vn;
        print("lun");
        print(image);
        print("lin");

        // a=uid;
        // print(uid);
        // print(u);
      });
      //print(value[uid]uid);

      setState(() {

      });
    });
  }
  @override
  Widget build(BuildContext context) {
    inputData();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [



              SizedBox(
                height: MediaQuery.of(context).size.height*0.06,
                width: MediaQuery.of(context).size.width,
              ),
              Card(
                //color: Colors.cyanAccent,
                child: SizedBox(
                  height: MediaQuery.of(context).size.width*0.30,
                  width: MediaQuery.of(context).size.width*0.30,
                  child:Image.asset('assets/images/stlogo.jpeg'),
                ),
              ),
              const Text("Smart Track",style: TextStyle(
                fontSize: 13,
                color: Colors.blue,
                //fontWeight: FontWeight.bold,
              ),),
              const Text("& Travel",style: TextStyle(
                  fontSize: 13,
                  //fontWeight: FontWeight.bold,
                  color: Colors.blue
              ),),
              SizedBox(
                height: MediaQuery.of(context).size.width*0.10,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text("Login Type",style: TextStyle(
                        fontSize:22,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),),
                    ),
                  ),

                ],
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(0, 60, 0, 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    //primary: Colors.yellow,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                    minimumSize: const Size(200, 50), //////// HERE
                  ),
                  onPressed: () async {
                    print(uoid);
                    if (uoid==q.r){
                      String uid = q.r+"Driver";
                      // String loginType = "Driver";
                      String key = _reference.push().key as String;
                      Map<String,String> products={
                        'uid' :uid,
                      };
                      _reference.child(q.r).set(products).then((value) {

                        String uid = q.r+"Driver";
                        Map<String,String> products={
                          'uid' :uid,
                        };
                        _referenc.child(q.r).set(products).then((value) {
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(builder: (context) => HomeDriver()));
                        });

                        // Navigator.of(context)
                        //     .pushReplacement(MaterialPageRoute(builder: (context) => HomeDriver()));
                      });

                    }
                    else{
                      String uid = q.r+"Driver";
                      // String loginType = "Driver";
                      String key = _reference.push().key as String;
                      Map<String,String> products={
                        'uid' :uid,
                      };
                      _reference.child(q.r).set(products).then((value) {

                        String uid = q.r+"Driver";
                        // String loginType = "Driver";
                        String key = _reference.push().key as String;
                        Map<String,String> products={
                          'uid' :uid,
                        };
                        _referenc.child(q.r).set(products).then((value) {
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(builder: (context) => DriverProfile(data: q.r, longe: '', late: '', long: '', lat: '',a: "",b: "",
                          c: "",d: "",e: "",f: "",g: "",h: "",i: "",j: "",k: "",l: "",)));
                        });
                        // Navigator.of(context)
                        //     .pushReplacement(MaterialPageRoute(builder: (context) => DriverProfile(data: q.r)));
                      });
                    }

                  },
                  child: const Text("Continue as Driver",
                    style: TextStyle(fontSize: 17, color: Colors.white),),
                ),
              ),Padding(
                padding: const EdgeInsets.all(0.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    //primary: Colors.yellow,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                    minimumSize: const Size(200, 50), //////// HERE
                  ),
                  onPressed: () async {
                    String uid = q.r+"Parent";
                    String key = _reference.push().key as String;
                    Map<String,String> products={
                      'uid' :uid,
                    };
                    _reference.child(q.r).set(products).then((value) {
                      String uid = q.r+"Parent";
                      String key = _reference.push().key as String;
                      Map<String,String> products={
                        'uid' :uid,
                      };
                      _referenc.child(q.r).set(products).then((value) {


                        Navigator.of(context)
                            .pushReplacement(MaterialPageRoute(builder: (context) => HomeParent()));
                      });

                      // Navigator.of(context)
                      //     .pushReplacement(MaterialPageRoute(builder: (context) => HomeParent()));
                    });
                  },
                  child: const Text("Continue as Parent",
                    style: TextStyle(fontSize: 17, color: Colors.white),),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

class q{
  static String r='';
}
