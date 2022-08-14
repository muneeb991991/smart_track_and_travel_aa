import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../driver/lata.dart';
import 'google_map.dart';
class Home1 extends StatefulWidget {
  const Home1({Key? key}) : super(key: key);

  @override
  State<Home1> createState() => _HomeState();
}

class _HomeState extends State<Home1> {
  String latdriver='';
  String longdriver='';


  List<Lata> lataList = [];
  late DatabaseReference _referenceu;
  late DatabaseReference _referencear;
  String lating='3';

  @override
  void initState() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user?.uid;
    String? l =uid;
    // TODO: implement initState
    super.initState();
    _referenceu =FirebaseDatabase.instance.reference().child('Drivers');
    _referencear =FirebaseDatabase.instance.reference().child('ApprovedRequests');
    Query referenceData = FirebaseDatabase.instance.reference().child("ApprovedRequests").orderByChild("parentuid").equalTo(l);
    referenceData.once().then((DataSnapshot dataSnapshot) {
      lataList.clear();
      var keys = dataSnapshot.value.keys;
      var values = dataSnapshot.value;
      for (var key in keys) {
        Lata data = Lata(
          values [key]["driverlocation"],
          values [key]["drivername"],
          values [key]["driverpicture"],
          values [key]["driveruid"],
          values [key]["parentname"],
          values [key]["parentphone"],
          values [key]["parentuid"],
          values [key]["startpoint"],
          values [key]["key"],
          values [key]["Duespm"],


        );
        lataList.add(data);
        // print(dataList[0].);
      }
      setState(() {
        // String length=dataList.length.toString();
      });
    });

  }
  @override
  Widget build(BuildContext context) {
    return lataList.isEmpty?
    Container(
      child: const Center(
          child: CupertinoActivityIndicator()
      ),
    ) :
      ListView.builder(
        itemCount: lataList.length,

        itemBuilder: (_, index) {
          return Card(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width*0.02,
                ),
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
                        radius: 65,
                        child: CircleAvatar(
                          radius: 65,
                          backgroundColor: Colors.transparent,
                          backgroundImage: NetworkImage(lataList[index].driverpicture),
                        ),
                      ),
                      radius: 80.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(lataList[index].drivername,style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 17),),
                SizedBox(
                  height: MediaQuery.of(context).size.width*0.02,
                ),
                Text(lataList[index].parentphone),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(onPressed: (){
                        setState(() {
                          print("kkkk");
                          String ab=lataList[index].driveruid;
                          Query referenceDat =FirebaseDatabase.instance.reference().child("DriversLocations").orderByChild("driveruid").equalTo(ab);
                          referenceDat.once().then((DataSnapshot event) {
                            var values = event.value;
                            Map<dynamic,dynamic> map = values as Map<dynamic,dynamic>;
                            map.forEach((key,value){
                              var lat = value['Lat'];
                              var long = value['Long'];
                              print("driver ki value get kar salya"+lat.toString());
                              latdriver=lat;
                              longdriver=long;
                              _showDialog(lat:latdriver ,long:longdriver,du:ab);
                            });
                            setState(() {
                            });
                          });
                        });

                      }, child: Text("Location")),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(onPressed: () async{
                        print("llll");
                        await _showDeleteDialog(productKey: lataList[index].key1,indexno:index,drivuid:lataList[index].driveruid);

                        // Navigator.of(context)
                        //     .push(MaterialPageRoute(builder: (context) => GooMap()));

                      }, child: Text("Leave Driver")),
                    ),
                  ],
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.width*0.02,
                ),
              ],
            ),
          );
        }
    );
  }
  _showDeleteDialog({required String productKey,required int indexno,required String drivuid}){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: const Text('Raating Befor Leave '),
        content: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            RatingBar.builder(
              initialRating: 3/*double.parse(cs.bs)*/,
              minRating: 0,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {


                print(rating);
                lating=rating.toString() ;


              },
            ),
          ],
        ),
        actions: [
          FlatButton(onPressed: (){
            Navigator.pop(context);
          },
              child: const Text('Cancel')),
          FlatButton(onPressed: () {




            Query referenceData =FirebaseDatabase.instance.reference().child("Drivers").orderByChild("uid").equalTo(drivuid);
            referenceData.once().then((DataSnapshot event) {
              //sataList.clear();
              // var keys = event.value;
              var values = event.value;
              // DataSnapshot snapshot = event.value;
              Map<dynamic,dynamic> map = values as Map<dynamic,dynamic>;
              // print(map);
              // var values = dataSnapshot.value;
              print("values");
              print(values);
              map.forEach((key,value){
                print(value);
                var raa = value['raating'];
                var ran = value['raatingno'];
                print(raa);
                print(ran);
                double a=double.parse(raa);
                double b=double.parse(ran);
                double c=b*a;
                double cq=c+double.parse(lating);

                double d=b+1;
                double  e=cq/d;
                String rating =e.toString();
                String ratingno =d.toString();
                print(lating);
                setState(() {
                  Map<String,String> products={
                    'raating' :rating,
                    'raatingno':ratingno,
                  };
                  _referenceu.child(drivuid).update(products).then((value) {

                     _referencear.child(productKey).remove().whenComplete(() {
                       setState(() {
                         lataList.removeAt(indexno);
                       });

                       Navigator.pop(context);
                     } );
                  });

                });




              });

            });







          },
              child: const Text('Leave')
          ),
        ],
      );
    }
    );
  }
  _showDialog({required String lat,required String long,required String du}){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: const Text('Driver Location'),
        content: Container(
          height: MediaQuery.of(context).size.width*0.15,
          width: MediaQuery.of(context).size.width*0.75,
          child: Column(

            children: [
              Text("Lat:"+latdriver),
              Text("Long:"+longdriver),


            ],
          ),
        ),
        actions: [
          FlatButton(onPressed: (){
            Navigator.pop(context);
          },
              child: const Text('Cancel')),
          FlatButton(onPressed: () {
            double a=double.parse(lat);
            double b=double.parse(long);

            print(a);
            print(b);
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => GooMap(duid: du,latdr:a,lond:b)));

          },
              child: const Text('Map Location')
          ),
        ],
      );
    }
    );
  }
}
