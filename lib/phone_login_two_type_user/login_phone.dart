import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Admin/admin_login.dart';
import 'opt.dart';
class LoginPhone extends StatefulWidget {
  const LoginPhone({Key? key}) : super(key: key);
  @override
  State<LoginPhone> createState() => _LoginPhoneState();
}
class _LoginPhoneState extends State<LoginPhone> {
  final _formKey = GlobalKey<FormState>();
  final phonenoTextEditController = new TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
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
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text("Phone Login",style: TextStyle(
                          fontSize:22,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),),
                      ),
                    ),

                  ],
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                  child: TextFormField(

                     controller: phonenoTextEditController,
                    keyboardType: TextInputType.number,

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Phone Number';
                      }
                      if(value.length < 10){
                        return 'Please enter 10 Digit Phone Number';
                      }if(value.length > 10){
                        return 'Please enter 10 Digit Phone Number';
                      }

                      return null;
                    },
                    decoration:  const InputDecoration(
                      prefix: Text("+92 "),
                      hintText: "Enter your Phone No.",
                      labelText: 'Phone No.',
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20.0),),),
                      prefixIconColor: Colors.amber,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width*0.25,
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
                        print(phonenoTextEditController.text);

                        await auth.verifyPhoneNumber(
                          phoneNumber: '+92'+phonenoTextEditController.text,
                          verificationCompleted: (PhoneAuthCredential credential) async {
                            print('The provided phone number ,,,,,,,,,,,,,,,,,is not valid.');
                            await auth.signInWithCredential(credential);
                            print('The provided phone number ,,,,,,,,,,,,,,,,,is not valid.');
                          },
                          verificationFailed: (FirebaseAuthException error) {
                            if (error.code == 'invalid-phone-number') {
                              Fluttertoast.showToast(
                                  msg: "Verification Failed",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.blue,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                              print('The provided phone number is not valid.');
                              print('The provided phone number is not valid.');

                            }
                            },
                          codeSent: (String verificationId, int? forceResendingToken) {
                            print(verificationId);
                            print(verificationId);
                            print('The provided phone mmmmm number is not valid.');

                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(builder: (context) => opt(verification:verificationId)));
                            },
                          codeAutoRetrievalTimeout: (String verificationId) { print("12");
                            },

                        );
                      }
                    },
                    child: const Text("Continue", style: TextStyle(fontSize: 17,),),
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(builder: (context) => AdminLogin()));
                  },
                  child:

                  Column(
                    children: [
                      Text("Admin Login",style: TextStyle(color: Colors.blue),),
                      Text("Click Here",),
                    ],
                  ),
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
