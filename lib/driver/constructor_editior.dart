import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../data.dart';
import 'create_edit_account.dart';
class Constructure extends StatefulWidget {
  const Constructure({Key? key}) : super(key: key);

  @override
  State<Constructure> createState() => _ConstructureState();
}

class _ConstructureState extends State<Constructure> {
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
  @override
  Widget build(BuildContext context) {
    print(DriverName);
    return Container(
      child: CreateEditAccount(data:

      Data(image, DriverName, phoneno, totalseats, reserve, available, route, vehicalno, vehicalcolor, dues,
          uoid, destination, raat, num, status, cnic, lat1, long1, late1, longe1
      )),
    );
  }
}
