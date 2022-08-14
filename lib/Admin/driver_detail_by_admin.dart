import 'package:flutter/material.dart';

import '../driver/parents_requests.dart';
import '../driver/students_detail.dart';
class DriverDetailByAdmin extends StatefulWidget {
  const DriverDetailByAdmin({Key? key}) : super(key: key);

  @override
  State<DriverDetailByAdmin> createState() => _DriverDetailByAdminState();
}

class _DriverDetailByAdminState extends State<DriverDetailByAdmin> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(title: Text("Driver Detail"),),
          body: Column(
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
                  child: const CircleAvatar(
                    backgroundColor: Colors.black12,
                    child: Icon(Icons.person,size: 80,color: Colors.black12,),
                    radius: 60.0,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(" Driver Name ",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 17),),
              SizedBox(
                height: MediaQuery.of(context).size.width*0.06,
              ),
              Row(
                children: [
                  Card(
                    elevation: 8,
                    child: Container(
                      //color: Colors.blue,
                      height: MediaQuery.of(context).size.width*0.25,
                      width: MediaQuery.of(context).size.width*0.31,
                      child: Column(
                        children: [
                          Text("Reserve Seats",style: TextStyle(),),
                          Text("4",style: TextStyle(),),
                          SizedBox(
                            height: MediaQuery.of(context).size.width*0.02,
                          ),
                          Text("Vehicle No.",style: TextStyle(),),
                          Text("LE 7055",style: TextStyle(),),

                        ],
                      ),
                    ),
                  ),Card(
                    elevation: 8,
                    child: Container(
                      //color: Colors.blue,
                      height: MediaQuery.of(context).size.width*0.25,
                      width: MediaQuery.of(context).size.width*0.31,
                      child: Column(
                        children: [
                          Text("Available Seats",style: TextStyle(),),
                          Text("3",style: TextStyle(),),
                          SizedBox(
                            height: MediaQuery.of(context).size.width*0.02,
                          ),
                          Text("Color",style: TextStyle(),),
                          Text("Red",style: TextStyle(),),

                        ],
                      ),
                      //child: T,
                    ),
                  ),
                  Card(
                    elevation: 8,
                    child: Container(
                      //color: Colors.blue,
                      height: MediaQuery.of(context).size.width*0.25,
                      width: MediaQuery.of(context).size.width*0.31,
                      //child: T,
                      child: Column(
                        children: [
                          Text("Total Seats",style: TextStyle(),),
                          Text("7",style: TextStyle(),),
                          SizedBox(
                            height: MediaQuery.of(context).size.width*0.02,
                          ),
                          Text("Dues",style: TextStyle(),),
                          Text("7000",style: TextStyle(),),

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
                      child: Text("Johar Town Block A, Block B, Block D,Block E, Block F, Block G To University of Punjab"
                        ,style: TextStyle(),),
                    )
                ),
              ),
              // Card(
              //   elevation: 8,
              //   child: Container(
              //     //color: Colors.blue,
              //       height: MediaQuery.of(context).size.width*0.15,
              //       width: MediaQuery.of(context).size.width,
              //       child:
              //       Padding(
              //         padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
              //         child: Row(
              //           children: [
              //
              //             Text("Location",style: TextStyle(),),
              //             const Expanded(child: SizedBox()),
              //             Align(alignment: Alignment.topRight, child: Switch(
              //               value: isSwitched,
              //               activeColor: Colors.blue,
              //               inactiveThumbColor: Colors.black,
              //               onChanged: (value) {
              //                 setState(() {
              //                   isSwitched = value;
              //                 });
              //               },
              //             ),),
              //           ],
              //
              //         ),
              //       )
              //   ),
              // ),
              InkWell(
                onTap: (){
                  print("llll");
                  // Navigator.of(context)
                  //     .push(MaterialPageRoute(builder: (context) => ParentRequest()));

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
                  // Navigator.of(context)
                  //     .push(MaterialPageRoute(builder: (context) => StudentDetail()));
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
        )
    );
  }
}
