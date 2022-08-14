import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_track_and_travel/driver/sata.dart';


import 'approve_request.dart';
import 'mata.dart';
class ParentRequest extends StatefulWidget {
   ParentRequest({Key? key,required this.drivername,required this.Driverphone,required this.driverlocation,required this.driverpicture}) : super(key: key);

   String drivername;
   String Driverphone;
   String driverlocation;
   String driverpicture;
  @override
  State<ParentRequest> createState() => _ParentRequestState();
}

class _ParentRequestState extends State<ParentRequest> {
  List<Mata> mataList = [];
  late DatabaseReference reference;

  @override
  void initState() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user?.uid;
    String? l =uid;
    // TODO: implement initState
    super.initState();
    reference =FirebaseDatabase.instance.reference().child('ParentRequests');
    print("lllllllllllllllllll");
    print(l);
    print("lllllllllllllllllll");
    Query referenceData = FirebaseDatabase.instance.reference().child("ParentRequests").orderByChild("driveruid").equalTo(l);
    referenceData.once().then((DataSnapshot dataSnapshot) {
      mataList.clear();
      var keys = dataSnapshot.value.keys;
      var values = dataSnapshot.value;
      for (var key in keys) {
        Mata data = Mata(

          values [key]["driveruid"],
          values [key]["endpoint"],
          values [key]["parentname"],
          values [key]["parentphone"],
          values [key]["parentuid"],
          values [key]["requiredseats"],
          values [key]["startingpoint"],
          values [key]["key"],
          values [key]["Duespm"],

        );
        mataList.add(data);
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
          //backgroundColor: Colors.black26,
          appBar: AppBar(
            title: Text("Parent Requests"),
          ),
          body: Container(
            color: Colors.black12,
            child: Column(
              children: [
                mataList.isEmpty?
                Container(
                  child: const Center(
                      child: CupertinoActivityIndicator()
                  ),
                ) :
                    Container(
                      height: MediaQuery.of(context).size.height*0.88,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                            itemCount: mataList.length,

                            itemBuilder: (_, index) {
                              return Card(
                                child: InkWell(
                                  onTap: (){
                                    Navigator.of(context)
                                        .pushReplacement(MaterialPageRoute(builder: (context) => ApproveDisapproveRequest(sata: Sata(mataList[index].driveruid ,
                                        mataList[index].endpoint,mataList[index].parentname,mataList[index].parentphone,
                                        mataList[index].parentuid, mataList[index].requiredseats, mataList[index].startingpoint,
                                        widget.drivername,widget.Driverphone,widget.driverlocation,widget.driverpicture,mataList[index].key,index.toString(),mataList[index].Duespm))),


                                    );
                                    // //mataList.removeAt(index);
                                    // setState(() {
                                    //   print("kkkk chawal");
                                    //   mataList.removeAt(index);
                                    //   print("kkkk chawal");
                                    //
                                    // });
                                  },
                                  child: Container(
                                      color: Colors.white,
                                      height: MediaQuery.of(context).size.width*0.20,
                                      width: MediaQuery.of(context).size.width,
                                      child:
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                        child: Row(
                                          children: [

                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text("You have new Parent Requests ",style: TextStyle(color: Colors.red),),
                                                      Text("to take child from "+mataList[index].startingpoint,style: TextStyle(color: Colors.red),),
                                                      Text("to "+mataList[index].endpoint,style: TextStyle(color: Colors.red),),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),

                                            const Expanded(child: SizedBox()),
                                            Align(alignment: Alignment.topRight,
                                                child: Padding(
                                                  padding: const EdgeInsets.fromLTRB(8, 25, 12, 0),
                                                  child: InkWell(
                                                    onTap: (){
                                                      print("kkkkkkk");

                                                      reference.child(mataList[index].key).remove().whenComplete(()

                                                      {
                                                        print(index);
                                                        setState(() {
                                                          mataList.removeAt(index);
                                                        });

                                                      }

                                                      );

                                                    },
                                                      child: Icon(Icons.delete)
                                                  ),
                                                )
                                            ),
                                          ],

                                        ),
                                      )
                                  ),
                                ),
                              );
                          }
                      ),
                    )


              ],
            ),
          ),
        )
    );
  }
  _showDeleteDialog({required String productKey,required int indexno}){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: const Text('Delete '),
        content: const Text('Are you sure to Delete'),
        actions: [
          FlatButton(onPressed: (){
            Navigator.pop(context);
          },
              child: const Text('cancel')),
          FlatButton(onPressed: () async{
            setState(() {
              mataList.removeAt(indexno);
              reference.child(productKey).remove().whenComplete(() => Navigator.pop(context));
            });

          },
              child: const Text('delete')
          ),
        ],
      );
    }
    );
  }
}
