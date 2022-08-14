import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'check_type_two.dart';
import 'login_type.dart';

class opt extends StatefulWidget {
   opt({Key? key,required this.verification}) : super(key: key);

  final String verification;
  @override
  State<opt> createState() => _optState();
}

class _optState extends State<opt> {
  final _formKey = GlobalKey<FormState>();
  final optTextEditController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;


    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.06,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
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
                    //fontWeight: FontWeight.bold,
                    color: Colors.blue
                ),),
                const Text("& Travel",style: TextStyle(
                    fontSize: 13,
                   // fontWeight: FontWeight.bold,
                    color: Colors.blue
                ),),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text("OTP",style: TextStyle(
                          fontSize:22,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),),
                      ),
                    ),

                  ],
                ),
                OtpTextField(
                  numberOfFields: 6,
                  borderColor: Colors.blue,
                  focusedBorderColor: Colors.blue,
                  //set to true to show as box or false to show as dash
                  showFieldAsBox: true,
                  //runs when a code is typed in
                  onCodeChanged: (String code) {
                    //handle validation or checks here
                  },
                  //runs when every textfield is filled
                  onSubmit: (String verificationCode) async {
                    print(verificationCode);
                    //String optTextEditController=verificationCode;


                    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: widget.verification, smsCode: verificationCode);
                    await auth.signInWithCredential(credential).then((value){
                      print("You are logged in successfully");
                      Fluttertoast.showToast(
                          msg: "Verification Successful",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.blue,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                      Navigator.of(context)
                          .pushReplacement(MaterialPageRoute(builder: (context) => CheckType2()));
                    });
                    // showDialog(
                    //     context: context,
                    //     builder: (context){
                    //       return AlertDialog(
                    //         title: Text("Verification Code"),
                    //         content: Text('Code entered is $verificationCode'),
                    //       );
                    //     }
                    // );
                  }, // end onSubmit
                ),
                SizedBox(
                  height: MediaQuery
                      .of(context)
                      .size
                      .width * 0.25,
                ),
                Padding(
                  padding: const EdgeInsets.all(60.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                     // primary: Colors.yellow,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                      minimumSize: const Size(200, 50), //////// HERE
                    ),
                    onPressed: () async {

                        //print(optTextEditController.text);
                      // PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: widget.verification, smsCode: verificationCode);
                      // await auth.signInWithCredential(credential).then((value){
                      //   print("You are logged in successfully");
                      //   Navigator.of(context)
                      //       .pushReplacement(MaterialPageRoute(builder: (context) => LoginType()));
                      // });


                    },
                    child: const Text("Continue",
                      style: TextStyle(fontSize: 17,),),
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

