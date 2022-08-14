import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'lata.dart';
class StudentDetail extends StatefulWidget {
   StudentDetail({Key? key,required this.title}) : super(key: key);
 String title;
  @override
  State<StudentDetail> createState() => _StudentDetailState();
}

class _StudentDetailState extends State<StudentDetail> {
  List<Lata> lataList = [];

  @override
  void initState() {
    // final FirebaseAuth auth = FirebaseAuth.instance;
    // final User? user = auth.currentUser;
    // final uid = user?.uid;
    // String? l =uid;
    // TODO: implement initState
    super.initState();
    Query referenceData = FirebaseDatabase.instance.reference().child("ApprovedRequests").orderByChild("driveruid").equalTo(widget.title);
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
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Student Detail"),
          ),
          body: Column(
            children: [
              lataList.isEmpty?
              Container(
                child: const Center(
                    child: CupertinoActivityIndicator()
                ),
              ) :
                  Container(
                  height: MediaQuery.of(context).size.height*0.70,
                         width: MediaQuery.of(context).size.width,
                         child: ListView.builder(
                           itemCount: lataList.length,

                           itemBuilder: (_, index) {
                             return Card(
                             child: Container(
                             color: Colors.white,
                             height: MediaQuery.of(context).size.width*0.20,
                             width: MediaQuery.of(context).size.width,
                             child:
                             Padding(
                             padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                             child: Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Column(
                             children: [
                             Row(
                             children: [
                             Text(lataList[index].parentname,style: TextStyle(color: Colors.red),),
                                   const Expanded(child: SizedBox()),
                                       Text("dues per month"),
                                     ],
                                     ),
                                    Row(
                                children: [
                                Text(lataList[index].startpoint,style: TextStyle(color: Colors.red),),
                                    const Expanded(child: SizedBox()),
                               Text(lataList[index].Duespm,style: TextStyle(color: Colors.red),),
                                 ],
                                        ),
                                     Row(
                                      children: [
                                        Text(lataList[index].parentphone,style: TextStyle(color: Colors.red),),

    ],
    ),
    ],
    ),
    ),
    )
    ),
    );
    }
                  ))

            ],
          ),
        )
    );
  }
}
