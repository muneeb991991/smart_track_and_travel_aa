import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:smart_track_and_travel/parent/home_parent.dart';
import 'package:smart_track_and_travel/phone_login_two_type_user/check_type.dart';


import 'driver/home_driver.dart';
class UserPassword extends StatefulWidget {
  const UserPassword({Key? key}) : super(key: key);

  @override
  State<UserPassword> createState() => _UserPasswordState();
}

class _UserPasswordState extends State<UserPassword> {
  late TextEditingController _userznameController, _passwordzController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userznameController=TextEditingController();
    _passwordzController=TextEditingController();

  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child:Form(
              key: _formKey,
              child:Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.06,
                    width: MediaQuery.of(context).size.width,
                  ),
                  Card(
                    //color: Colors.cyanAccent,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.width*0.30,
                      width: MediaQuery.of(context).size.width*0.30,
                      child:Image.asset('assets/images/stlogo.jpeg'),
                    ),
                  ),
                  const Text("Smart Track",style: TextStyle(
                    fontSize: 13,
                    color: Colors.blue,
                    //fontWeight: FontWeight.bold,
                  ),),
                  const Text("& Travel",style: TextStyle(
                      fontSize: 13,
                      //fontWeight: FontWeight.bold,
                      color: Colors.blue
                  ),),
                  SizedBox(
                    height: MediaQuery.of(context).size.width*0.10,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter User Name';
                        }
                        return null;
                      },
                      controller: _userznameController,
                      decoration: const InputDecoration(
                        labelText: 'User Name',
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20.0)),),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Password';
                        }
                        return null;
                      },
                      controller: _passwordzController,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20.0)),),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(60.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        //primary: Colors.yellow,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                        minimumSize: const Size(200, 50), //////// HERE
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {


                          String equal=q.r+"Parent"+_passwordzController.text+_userznameController.text;
                          Query referenceData =FirebaseDatabase.instance.reference().child("applock").orderByChild('uid').equalTo(equal);
                          referenceData.once().then((DataSnapshot event) {
                            var values = event.value;
                            if (values == null) {

                              String equal1=q.r+"Driver"+_passwordzController.text+_userznameController.text;
                              print(q.r);
                              Query referenceDat =FirebaseDatabase.instance.reference().child("applock").orderByChild('uid').equalTo(equal1);
                              referenceDat.once().then((DataSnapshot event) {
                                print("llln");
                                var values = event.value;
                                if (values == null) {
                                  print("jjj");
                                  Navigator.of(context)
                                      .pushReplacement(
                                      MaterialPageRoute(builder: (context) => UserPassword()));
                                }
                                else {
                                  Navigator.of(context)
                                      .pushReplacement(
                                      MaterialPageRoute(builder: (context) => HomeDriver()));
                                }
                                setState(() {});
                              });

                            }
                            else {
                              Navigator.of(context)
                                  .pushReplacement(
                                  MaterialPageRoute(builder: (context) => HomeParent()));
                            }
                            setState(() {});
                          });


                        }
                      },
                      child: const Text("Continue", style: TextStyle(fontSize: 17,),),
                    ),
                  ),
                ],
              ),
            )

          ),
        )
    );
  }
}
