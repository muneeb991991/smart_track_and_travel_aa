import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
class sendRequest extends StatefulWidget {
   sendRequest({Key? key, required this.title}) : super(key: key);
String title;
  @override
  State<sendRequest> createState() => _sendRequestState();
}

class _sendRequestState extends State<sendRequest> {
  late TextEditingController _parentnameController, _parentphoneController, _bookseatsController,_startpointController,_duesController,
      _destinationController;

  late DatabaseReference _reference;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _parentnameController=TextEditingController();
    _parentphoneController=TextEditingController();
    _bookseatsController=TextEditingController();
    _startpointController=TextEditingController();
    _duesController=TextEditingController();
    _destinationController=TextEditingController();
    _reference =FirebaseDatabase.instance.reference().child('ParentRequests');

  }
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {


    return  SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Request"),
        ),

        //resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [

                Column(
                  children: [

                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        controller: _parentnameController,
                        decoration: const InputDecoration(
                          labelText: 'Parent Name',
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20.0)),),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        controller: _parentphoneController,
                        decoration: const InputDecoration(
                          labelText: 'Phone Number',
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20.0)),),
                        ),
                      ),
                    ),Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        controller: _duesController,
                        decoration: const InputDecoration(
                          labelText: 'Dues per Month',
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20.0)),),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        controller: _bookseatsController,
                        decoration: const InputDecoration(
                          labelText: 'Required Seats',
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20.0)),),
                        ),
                      ),
                    ),Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        controller: _startpointController,
                        decoration: const InputDecoration(
                          labelText: 'Start Point',
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20.0)),),
                        ),
                      ),
                    ),Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        controller: _destinationController,
                        decoration: const InputDecoration(
                          labelText: 'Destination Point',
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20.0)),),
                        ),
                      ),
                    ),


                  ],
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.width*0.15
                ),


                ElevatedButton(child: Text('Send Request',style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
                ),
                  onPressed: (){
                    saveProduct();
                  },
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.width*0.15
                ),
              ],
            ),
          ),

        ),
      ),
    );

  }

  void saveProduct(){

    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user?.uid;
    String? l =uid;

    String name = _parentnameController.text;
    String phone = _parentphoneController.text;
    String totalseats = _bookseatsController.text;
    String reserveseats = _startpointController.text;
    String availableseats = _destinationController.text;
    String duespm = _duesController.text;

    String key = _reference.push().key as String;
    Map<String,String> products={
      'parentname' :name,
      'parentphone' :phone,
      'requiredseats' :totalseats,
      'startingpoint' :reserveseats,
      'key' :key,
      'endpoint' :availableseats,
      'driveruid' :widget.title,
      'parentuid' :l!,
      'Duespm' :duespm,

    };


    _reference.child(key).set(products).then((value) {
      // Navigator.of(context)
      //     .pushReplacement(MaterialPageRoute(builder: (context) => HomeDriver()));
    });
    Navigator.pop(context);
    // });

  }

}
