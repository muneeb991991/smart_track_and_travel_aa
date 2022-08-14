

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:smart_track_and_travel/driver/parents_requests.dart';
import 'package:smart_track_and_travel/driver/sata.dart';

class ApproveDisapproveRequest extends StatefulWidget {
  const ApproveDisapproveRequest({Key? key ,required this.sata}) : super(key: key);
 final Sata sata;
  @override
  State<ApproveDisapproveRequest> createState() => _ApproveDisapproveRequestState();
}

class _ApproveDisapproveRequestState extends State<ApproveDisapproveRequest> {
  late DatabaseReference _reference;
  late DatabaseReference reference;
  void initState() {
    // TODO: implement initState
    super.initState();
    reference =FirebaseDatabase.instance.reference().child('ParentRequests');
    _reference =FirebaseDatabase.instance.reference().child('ApprovedRequests');
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(title: Text("Request Detail"),),
          body:Column(
            children: [

              SizedBox(
                height: MediaQuery.of(context).size.width*0.50,
              ),
              Center(child: Text(widget.sata.parentname,style: TextStyle(fontSize: 27),),),
              Center(child: Text(widget.sata.startingpoint)),
              Center(child: Text(" to ")),
              Center(child: Text(widget.sata.endpoint)),
              Center(child: Text("Require Seats "+widget.sata.requiredseats)),
              Center(child: Text(widget.sata.parentphone)),
              Center(child: Text("Dues per Month "+widget.sata.Duespm)),

              SizedBox(
                height: MediaQuery.of(context).size.width*0.20,
              ),
              ElevatedButton(onPressed: (){
                String dn = widget.sata.drivername;
                String dl = widget.sata.driverlocation;
                String dpi = widget.sata.driverpicture;
                String dph = widget.sata.parentphone;
                String pn = widget.sata.parentname;
                String pph = widget.sata.parentphone;
                String puid = widget.sata.parentuid;
                String startpoint = widget.sata.startingpoint;
                String duid = widget.sata.driveruid;
                String dues = widget.sata.Duespm;

                String key = _reference.push().key as String;
                Map<String,String> products={
                  'drivername' :dn,
                  'driverlocation' :dl,
                  'driverpicture' :dpi,
                  'parentphone' :dph,
                  'parentname' :pn,
                  'parentphone' :pph,
                  'parentuid' :puid,
                  'key' :key,
                  'startpoint' :startpoint,
                  'driveruid' :duid,
                  'Duespm' :dues,
                };
                _reference.child(key).set(products).then((value) {
                  setState(() {
                    reference.child(widget.sata.key).remove().whenComplete(() {

                      Navigator.of(context)
                          .pushReplacement(MaterialPageRoute(builder: (context) =>
                          ParentRequest(drivername: dn,Driverphone:dph,driverlocation:"location",driverpicture:dpi)));
                    });


                  });


                });
              }, child: Text("Approve")),
              SizedBox(
                height: MediaQuery.of(context).size.width*0.02,
              ),

            ],
          ),
        )
    );
  }
}
