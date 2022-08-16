import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_track_and_travel/parent/send_request.dart';
import '../driver/google_map_box.dart';
import 'datatwo.dart';
class AvailableDriver extends StatefulWidget {
  const AvailableDriver({Key? key}) : super(key: key);

  @override
  State<AvailableDriver> createState() => _AvailableDriverState();
}


class _AvailableDriverState extends State<AvailableDriver> {
  List<Data> dataList = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Query referenceData = FirebaseDatabase.instance.reference().child("Drivers").orderByChild("status").equalTo("Active");
    referenceData.once().then((DataSnapshot dataSnapshot) {
      dataList.clear();
      var keys = dataSnapshot.value.keys;
      var values = dataSnapshot.value;
      for (var key in keys) {
        Data data = Data(
          values [key]["availableseats"],
          values [key]["dues"],
          values [key]["name"],
          values [key]["phone"],
          values [key]["picUrl"],
          values [key]["reserveseats"],
          values [key]["route"],
          values [key]["totalseats"],
          values [key]["uid"],
          values [key]["vahicalno"],
          values [key]["vehicalcilor"],
          values [key]["destination"],
          values [key]["raating"],
          values [key]["raatingno"],
          values [key]["Lat"],
          values [key]["Late"],
          values [key]["Long"],
          values [key]["Longe"],
        );
        dataList.add(data);
        print(dataList[0].phone);
      }
      setState(() {
        // String length=dataList.length.toString();
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return
       SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width*0.17,
              child:
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: TextField(
                  cursorColor: Colors.blue,
                  onChanged: (text) {
                    SearchMethod1(text);
                  },
                  textInputAction: TextInputAction.go,
                  decoration: const InputDecoration(
                      hintText: "Type City",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0),),
                      )
                  ),

                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width*0.17,
              child:
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: TextField(
                  cursorColor: Colors.blue,
                  onChanged: (text) {
                    SearchMethod(text);
                  },
                  textInputAction: TextInputAction.go,
                  decoration: const InputDecoration(
                      hintText: "Search Destination",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0),),
                      )
                  ),

                ),
              ),
            ),



            dataList.isEmpty?
            Container(
              child: const Center(
                  child: CupertinoActivityIndicator()
              ),
            ) :
            Container(

              height: MediaQuery.of(context).size.height*0.73,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  itemCount: dataList.length,

                  itemBuilder: (_, index) {
                    double ak =double.parse(dataList[index].raating);
                    double la =double.parse(dataList[index].Lat);
                    double lon =double.parse(dataList[index].Long);
                    double lae =double.parse(dataList[index].Late);
                    double lone =double.parse(dataList[index].Longe);
                    return Card(
                      color: Colors.white,
                      child: Column(
                        children: [
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
                                    backgroundImage: NetworkImage(dataList[index].picUrl),
                                  ),
                                ),
                                radius: 80.0,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(dataList[index].name,style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 17),),
                          Text(dataList[index].phone,),

                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(5, (index) {

                              // a=int.parse(dataList[index].raating);

                              return Icon(
                                index < ak ? Icons.star : Icons.star_border,
                              );
                              print("vc");
                            }),
                          ),
                          Text(("(")+dataList[index].raatingno+(")"),style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 13),),
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
                                  width: MediaQuery.of(context).size.width*0.30,
                                  child: Column(
                                    children: [
                                      Text("Reserve Seats",style: TextStyle(),),
                                      Text(dataList[index].reserveseats,style: TextStyle(),),
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
                                  width: MediaQuery.of(context).size.width*0.30,
                                  child: Column(
                                    children: [
                                      Text("Available Seats",style: TextStyle(),),
                                      Text(dataList[index].availableseats,style: TextStyle(),),
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
                                  width: MediaQuery.of(context).size.width*0.30,
                                  //child: T,
                                  child: Column(
                                    children: [
                                      Text("Total Seats",style: TextStyle(),),
                                      Text(dataList[index].totalseats,style: TextStyle(),),
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
                                  width: MediaQuery.of(context).size.width*0.30,
                                  child: Column(
                                    children: [
                                      // Text("Reserve Seats",style: TextStyle(),),
                                      // Text(reserve,style: TextStyle(),),
                                      // SizedBox(
                                      //   height: MediaQuery.of(context).size.width*0.02,
                                      // ),
                                      Text("Vehicle No.",style: TextStyle(),),
                                      Text(dataList[index].vahicalno,style: TextStyle(),),

                                    ],
                                  ),
                                ),
                              ),Card(
                                elevation: 8,
                                child: Container(
                                  //color: Colors.blue,
                                  height: MediaQuery.of(context).size.width*0.13,
                                  width: MediaQuery.of(context).size.width*0.30,
                                  child: Column(
                                    children: [
                                      // Text("Available Seats",style: TextStyle(),),
                                      // Text(available,style: TextStyle(),),
                                      // SizedBox(
                                      //   height: MediaQuery.of(context).size.width*0.02,
                                      // ),
                                      Text("Color",style: TextStyle(),),
                                      Text(dataList[index].vehicalcilor,style: TextStyle(),),

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
                                  width: MediaQuery.of(context).size.width*0.30,
                                  //child: T,
                                  child: Column(
                                    children: [
                                      // Text("Total Seats",style: TextStyle(),),
                                      // Text(totalseats,style: TextStyle(),),
                                      // SizedBox(
                                      //   height: MediaQuery.of(context).size.width*0.02,
                                      // ),
                                      Text("Dues",style: TextStyle(),),
                                      Text(dataList[index].dues,style: TextStyle(),),

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
                                  child: Text("Destination",style: TextStyle(color: Colors.white),),
                                )
                            ),
                          ),
                          // ElevatedButton(onPressed: (){

                          // }, child: Text("lll")),
                          Card(
                            elevation: 8,
                            child: Container(
                              //color: Colors.blue,
                                height: MediaQuery.of(context).size.width*0.132,
                                width: MediaQuery.of(context).size.width,
                                child:
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(8, 8,8, 0),
                                  child: Text(dataList[index].destination+" City : "+dataList[index].route),
                                )
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              print("llll");
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) => GooMapBox(ls: la, los: lon, le: lae, loe: lone,),));

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

                                        Text("Route Through Map",style: TextStyle(),),
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
                          SizedBox(
                            height: 10,
                          ),ElevatedButton(onPressed: (){
                            String uid=dataList[index].uid;
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) => sendRequest( title: uid,)));
                          }, child: Text("Send Request"))
                        ],
                      ),
                    );
                  }
              ),
            ),
          ],
        ),
      );

  }
  void SearchMethod(String text) {
    Query referenceData = FirebaseDatabase.instance.reference().child("Drivers");
    referenceData.once().then((DataSnapshot dataSnapshot) {
      dataList.clear();
      var keys = dataSnapshot.value.keys;
      var values = dataSnapshot.value;
      for (var key in keys) {
        Data data = Data(
          values [key]["availableseats"],
          values [key]["dues"],
          values [key]["name"],
          values [key]["phone"],
          values [key]["picUrl"],
          values [key]["reserveseats"],
          values [key]["route"],
          values [key]["totalseats"],
          values [key]["uid"],
          values [key]["vahicalno"],
          values [key]["vehicalcilor"],
          values [key]["destination"],
          values [key]["raating"],
          values [key]["raatingno"],
          values [key]["Lat"],
          values [key]["Late"],
          values [key]["Long"],
          values [key]["Longe"],
        );
        if (data.destination.contains(text.toLowerCase().toLowerCase())){
          dataList.add(data);
        }
        Timer(Duration(seconds: 1),(){
          setState(() {
          });
        });

      }

    });

  }void SearchMethod1(String text) {
    Query referenceData = FirebaseDatabase.instance.reference().child("Drivers");
    referenceData.once().then((DataSnapshot dataSnapshot) {
      dataList.clear();
      var keys = dataSnapshot.value.keys;
      var values = dataSnapshot.value;
      for (var key in keys) {
        Data data = Data(
          values [key]["availableseats"],
          values [key]["dues"],
          values [key]["name"],
          values [key]["phone"],
          values [key]["picUrl"],
          values [key]["reserveseats"],
          values [key]["route"],
          values [key]["totalseats"],
          values [key]["uid"],
          values [key]["vahicalno"],
          values [key]["vehicalcilor"],
          values [key]["destination"],
          values [key]["raating"],
          values [key]["raatingno"],
          values [key]["Lat"],
          values [key]["Late"],
          values [key]["Long"],
          values [key]["Longe"],
        );
        if (data.route.contains(text.toLowerCase().toLowerCase())){
          dataList.add(data);
        }
        Timer(Duration(seconds: 1),(){
          setState(() {
          });
        });

      }

    });

  }
}
