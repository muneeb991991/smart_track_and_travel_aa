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
import 'create_edit_account.dart';
import 'home_location.dart';
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
    double abc=double.parse(raat);
    print(raat);
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
                   Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.width*0.06,
                      ),
                      //
                      SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.width*0.25,
                        child: Container(
                          //height: MediaQuery.of(context).size.width*0.25,
                          alignment: const Alignment(0.0,2.5),
                          child:  CircleAvatar(
                            backgroundColor: Colors.black12,
                            child:
                            CircleAvatar(
                             // backgroundColor: Colors.black12,
                              radius: 65,
                              //backgroundImage: AssetImage('assets/bottombar/loading.gif'),
                              child: CircleAvatar(
                                radius: 65,
                                backgroundColor: Colors.transparent,
                                backgroundImage: NetworkImage(image),
                              ),
                            ),
                            radius: 80.0,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(DriverName,style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 17),),
                        Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(5, (index) {
                              return Icon(
                           index < abc ? Icons.star : Icons.star_border,
                         );
                         }),
                             ),
                      Text(("(")+num+(")"),style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 13),),
                      Text(("(")+status+(")"),style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 13),),
                      Text(("(")+cnic+(")"),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 13),),
                      SizedBox(
                        height: MediaQuery.of(context).size.width*0.02,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
                        child: Container(
                            color: Colors.blue,
                            height: MediaQuery.of(context).size.width*0.08,
                            width: MediaQuery.of(context).size.width,
                            child:
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 6, 0, 0),
                              child: Text("Seating Capacity",style: TextStyle(color: Colors.white),),
                            )
                        ),
                      ),
                      Row(
                        children: [
                          Card(
                            elevation: 8,
                            child: Container(
                              //color: Colors.blue,
                              height: MediaQuery.of(context).size.width*0.13,
                              width: MediaQuery.of(context).size.width*0.31,
                              child: Column(
                                children: [
                                  Text("Reserve Seats",style: TextStyle(),),
                                  Text(reserve,style: TextStyle(),),
                                  // SizedBox(
                                  //   height: MediaQuery.of(context).size.width*0.02,
                                  // ),
                                  // Text("Vehicle No.",style: TextStyle(),),
                                  // Text(vehicalno,style: TextStyle(),),

                                ],
                              ),
                            ),
                          ),Card(
                            elevation: 8,
                            child: Container(
                              //color: Colors.blue,
                              height: MediaQuery.of(context).size.width*0.13,
                              width: MediaQuery.of(context).size.width*0.31,
                              child: Column(
                                children: [
                                  Text("Available Seats",style: TextStyle(),),
                                  Text(available,style: TextStyle(),),
                                  // SizedBox(
                                  //   height: MediaQuery.of(context).size.width*0.02,
                                  // ),
                                  // Text("Color",style: TextStyle(),),
                                  // Text(vehicalcolor,style: TextStyle(),),

                                ],
                              ),
                              //child: T,
                            ),
                          ),
                          Card(
                            elevation: 8,
                            child: Container(
                              //color: Colors.blue,
                              height: MediaQuery.of(context).size.width*0.13,
                              width: MediaQuery.of(context).size.width*0.31,
                              //child: T,
                              child: Column(
                                children: [
                                  Text("Total Seats",style: TextStyle(),),
                                  Text(totalseats,style: TextStyle(),),
                                  // SizedBox(
                                  //   height: MediaQuery.of(context).size.width*0.02,
                                  // ),
                                  // Text("Dues",style: TextStyle(),),
                                  // Text(dues,style: TextStyle(),),

                                ],
                              ),
                            ),
                          ),
                        ],
                      ),Padding(
                        padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
                        child: Container(
                            color: Colors.blue,
                            height: MediaQuery.of(context).size.width*0.08,
                            width: MediaQuery.of(context).size.width,
                            child:
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 6, 0, 0),
                              child: Text("Vehicle Detail",style: TextStyle(color: Colors.white),),
                            )
                        ),
                      ),
                      Row(
                        children: [
                          Card(
                            elevation: 8,
                            child: Container(
                              //color: Colors.blue,
                              height: MediaQuery.of(context).size.width*0.13,
                              width: MediaQuery.of(context).size.width*0.31,
                              child: Column(
                                children: [
                                  // Text("Reserve Seats",style: TextStyle(),),
                                  // Text(reserve,style: TextStyle(),),
                                  // SizedBox(
                                  //   height: MediaQuery.of(context).size.width*0.02,
                                  // ),
                                  Text("Vehicle No.",style: TextStyle(),),
                                  Text(vehicalno,style: TextStyle(),),

                                ],
                              ),
                            ),
                          ),Card(
                            elevation: 8,
                            child: Container(
                              //color: Colors.blue,
                              height: MediaQuery.of(context).size.width*0.13,
                              width: MediaQuery.of(context).size.width*0.31,
                              child: Column(
                                children: [
                                  // Text("Available Seats",style: TextStyle(),),
                                  // Text(available,style: TextStyle(),),
                                  // SizedBox(
                                  //   height: MediaQuery.of(context).size.width*0.02,
                                  // ),
                                  Text("Color",style: TextStyle(),),
                                  Text(vehicalcolor,style: TextStyle(),),

                                ],
                              ),
                              //child: T,
                            ),
                          ),
                          Card(
                            elevation: 8,
                            child: Container(
                              //color: Colors.blue,
                              height: MediaQuery.of(context).size.width*0.13,
                              width: MediaQuery.of(context).size.width*0.31,
                              //child: T,
                              child: Column(
                                children: [
                                  // Text("Total Seats",style: TextStyle(),),
                                  // Text(totalseats,style: TextStyle(),),
                                  // SizedBox(
                                  //   height: MediaQuery.of(context).size.width*0.02,
                                  // ),
                                  Text("Dues",style: TextStyle(),),
                                  Text(dues,style: TextStyle(),),

                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
                        child: Container(
                            color: Colors.blue,
                            height: MediaQuery.of(context).size.width*0.08,
                            width: MediaQuery.of(context).size.width,
                            child:
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 6, 0, 0),
                              child: Text("Route",style: TextStyle(color: Colors.white),),
                            )
                        ),
                      ),
                      Card(
                        elevation: 8,
                        child: Container(
                            //color: Colors.blue,
                            height: MediaQuery.of(context).size.width*0.222,
                            width: MediaQuery.of(context).size.width,
                            child:
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 8,8, 0),
                              child: Text(route+" "+destination
                                ,style: TextStyle(),),
                            )
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) => Home()));
                        },
                        child: Card(
                          elevation: 8,
                          child: Container(
                              //color: Colors.blue,
                              height: MediaQuery.of(context).size.width*0.15,
                              width: MediaQuery.of(context).size.width,
                              child:
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                child: Row(
                                  children: [

                                    Text("Location",style: TextStyle(),),
                                    const Expanded(child: SizedBox()),
                                    Align(alignment: Alignment.topRight,
                                      child: Switch(
                                      value: isSwitched,
                                      activeColor: Colors.blue,
                                      inactiveThumbColor: Colors.black,
                                      onChanged: (value) {
                                        setState(() {
                                          isSwitched = value;
                                          print(value);
                                          if(value==true){

                                            print("hhhhh");

                                            setState(() {

                                              checkGps();
                                            });


                                              timer = Timer.periodic(Duration(seconds: 15), (Timer t) => checkGps());


                                          }
                                          else if (value==false){
                                            //haspermission=false;


                                           setState(() {
                                             isSwitched=false;
                                           });
                                          }
                                          print("value");
                                        });
                                      },
                                    ),
                                    ),
                                  ],

                                ),
                              )
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          print("llll");
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) => ParentRequest(drivername: DriverName,Driverphone:phoneno,driverlocation:"location",driverpicture:image)));

                        },
                        child: Card(
                          elevation: 8,
                          child: Container(
                              //color: Colors.blue,
                              height: MediaQuery.of(context).size.width*0.15,
                              width: MediaQuery.of(context).size.width,
                              child:
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                child: Row(
                                  children: [

                                    Text("Parent Requests",style: TextStyle(),),
                                    const Expanded(child: SizedBox()),
                                    Align(alignment: Alignment.topRight,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(8, 15, 12, 0),
                                          child: Icon(Icons.arrow_forward),
                                        )
                                    ),
                                  ],

                                ),
                              )
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) => StudentDetail(title: uoid,)));
                        },
                        child: Card(
                          elevation: 8,
                          child: Container(
                              ///color: Colors.red,
                              height: MediaQuery.of(context).size.width*0.15,
                              width: MediaQuery.of(context).size.width,
                              child:
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                child: Row(
                                  children: [

                                    Text("Student Detail",style: TextStyle(),),
                                    const Expanded(child: SizedBox()),
                                    Align(alignment: Alignment.topRight,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(8, 15, 12, 0),
                                          child: Icon(Icons.arrow_forward),
                                        )
                                    ),
                                  ],

                                ),
                              )
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(60.0),
                      //   child: ElevatedButton(
                      //     style: ElevatedButton.styleFrom(
                      //       primary: Colors.red,
                      //       elevation: 0,
                      //       shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(32.0)),
                      //       minimumSize: const Size(200, 50),
                      //     ),
                      //     onPressed: () async {
                      //
                      //       Navigator.of(context)
                      //           .push(MaterialPageRoute(builder: (context) => CreateEditAccount()));
                      //     },
                      //     child: const Text("Account Create/Edit", style: TextStyle(fontSize: 17,),),
                      //   ),
                      // ),



                    ],
                  ),
                ]
                else if (_selectedIndex == 1) ...[
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.82 ,
                    width: MediaQuery.of(context).size.width,
                    child:CreateEditAccount(data: Data(totalseats,available,route,reserve,dues,vehicalcolor,vehicalno,phoneno,DriverName,image,uoid,destination)),
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



