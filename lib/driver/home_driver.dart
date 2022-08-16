import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:smart_track_and_travel/driver/parents_requests.dart';
import 'package:smart_track_and_travel/driver/setting.dart';
import 'package:smart_track_and_travel/driver/students_detail.dart';


import '../Drawer.dart';
import '../data.dart';
import '../phone_login_two_type_user/login_splash.dart';
import 'DrawerDriver.dart';
import 'constructor_editior.dart';
import 'create_edit_account.dart';
import 'home_location.dart';
import 'home_main.dart';
class HomeDriver extends StatefulWidget {
  const HomeDriver({Key? key}) : super(key: key);

  @override
  State<HomeDriver> createState() => _HomeDriverState();
}

class _HomeDriverState extends State<HomeDriver> {
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
  String destination='';
  String raat='';
  String num='';
  String status='';
  String cnic='';
  String lat1='';
  String long1='';
  String late1='';
  String longe1='';

 // print(t)
  Timer? timer;
  late DatabaseReference _reference;

  void initState() {
    // TODO: implement initState
    super.initState();
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user?.uid;
    String? l =uid;
    print(l);
    print("l");
    print(l);
    print("l");
    print(l);
    print("l");
    print(l);
     _reference =FirebaseDatabase.instance.reference().child('DriversLocations');
    Query referenceData =FirebaseDatabase.instance.reference().child("Drivers").orderByChild("uid").equalTo(l);
    referenceData.once().then((DataSnapshot event) {
      //sataList.clear();
      // var keys = event.value;
      print("jjjjjjjjjjjjjjj");
      var values = event.value;
      // DataSnapshot snapshot = event.value;
      print(values);
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
        var des = value['destination'];
        var raa = value['raating'];
        var ran = value['raatingno'];
        var statu = value['status'];
        var cni = value['Cnic'];
        var tal = value['Lat'];
        var gnol = value['Long'];
        var etal = value['Late'];
        var egnol = value['Longe'];


        uoid=id;
        image=pic;
        DriverName=dn;
        phoneno=pn;
        totalseats=ts;
        reserve=re;
        available=av;
        route=r;
        destination=des;
        raat=raa;
        num=ran;
        status=statu;
        cnic=cni;
        lat1=tal;
        long1=gnol;
        late1=etal;
        longe1=egnol;

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
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  String long = "", lat = "";
  late StreamSubscription<Position> positionStream;

  checkGps() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if(servicestatus){
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
        }else if(permission == LocationPermission.deniedForever){
          print("'Location permissions are permanently denied");
        }else {
          haspermission = true;
        }
      }else {

        haspermission = true;
      }

      if(haspermission){
        setState(() {
          //refresh the UI
        });

        getLocation();
      }
    }else {
      print("GPS Service is not enabled, turn on GPS location");
    }

    setState(() {
      //refresh the UI
    });
  }

  getLocation() async {
    if(isSwitched==true){
      position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      print(position.longitude); //Output: 80.24599079
      print(position.latitude); //Output: 29.6593457

      long = position.longitude.toString();
      lat = position.latitude.toString();
      // print(long);
      // print(lat);

      setState(() {
        //refresh UI
      });

      LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high, //accuracy of the location data
        distanceFilter: 100, //minimum distance (measured in meters) a
        //device must move horizontally before an update event is generated;
      );


      StreamSubscription<Position> positionStream = Geolocator.getPositionStream(
          locationSettings: locationSettings).listen((Position position) {
        print(position.longitude); //Output: 80.24599079
        print(position.latitude); //Output: 29.6593457

        long = position.longitude.toString();
        lat = position.latitude.toString();

        setState(() {
          //refresh UI on update
        });
      });

      ///////
      //String key = _reference.push().key as String;
      final FirebaseAuth auth = FirebaseAuth.instance;
      final User? user = auth.currentUser;
      final uid = user?.uid;
      String? l =uid;
      String ab=l!;


      Map<String,String> products={
        'driveruid' :ab,
        'Long' :long,
        'Lat' :lat,
      };

      _reference.child(ab).set(products).then((value) {
       // Navigator.pop(context);
      });


    }
    else{
      print("ll");
    }

  }


  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Driver Side"),
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
        //drawer: NavigationDrawerWidgetDriver(),

        body: Container(
         // color: Colors.black12,
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (_selectedIndex == 0) ...[
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.82 ,
                    width: MediaQuery.of(context).size.width,
                    child:HomeMain(),
                    //FirebaseAuth.instance.currentUser==null? SignIn():account(),
                  ),

                ]

                else if (_selectedIndex == 1) ...[

                  SizedBox(

                    height: MediaQuery.of(context).size.height*0.82 ,
                    width: MediaQuery.of(context).size.width,
                    child:

                    Constructure()
                    //FirebaseAuth.instance.currentUser==null? SignIn():account(),
                  ),
                ]
                else if (_selectedIndex == 2) ...[
                    SizedBox(
                      height: MediaQuery.of(context).size.height *0.82,
                      width: MediaQuery.of(context).size.width,
                      child: Setting(),
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
                icon: Icon(Icons.person),
                label: 'Account',
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



