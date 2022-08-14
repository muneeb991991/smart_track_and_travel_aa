import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_phone.dart';


class LoginSplash extends StatefulWidget {
  const LoginSplash({Key? key}) : super(key: key);
  @override
  State<LoginSplash> createState() => _LoginSplashState();
}
class _LoginSplashState extends State<LoginSplash> {
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
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.40,
                  width: MediaQuery.of(context).size.width,
                  child:Image.asset('assets/images/stlogo.jpeg'),
                ),
                // const Text("Smart Track",style: TextStyle(
                //     fontSize: 12,
                //     fontWeight: FontWeight.bold,
                //     //color: Color(0xFFF50057),
                // ),),
                // Row(
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.all(12.0),
                //       child: Padding(
                //         padding: const EdgeInsets.all(12.0),
                //         child: Text("Phone Login",style: TextStyle(
                //           fontSize:22,
                //           fontWeight: FontWeight.bold,
                //           color: Colors.white,
                //         ),),
                //       ),
                //     ),
                //
                //   ],
                // ),
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                //   child: TextFormField(
                //     style: TextStyle(color: Colors.white),
                //
                //     controller: phonenoTextEditController,
                //     keyboardType: TextInputType.number,
                //
                //     validator: (value) {
                //       if (value == null || value.isEmpty) {
                //         return 'Please enter your Phone Number';
                //       }
                //       if(value.length < 10){
                //         return 'Please enter 10 Digit Phone Number';
                //       }if(value.length > 10){
                //         return 'Please enter 10 Digit Phone Number';
                //       }
                //
                //       return null;
                //     },
                //     decoration:  const InputDecoration(
                //       focusedBorder: OutlineInputBorder(
                //         borderSide: BorderSide(color: Colors.white, width: 2.0),
                //       ),
                //
                //
                //       fillColor: Colors.white,
                //       prefix: Text("+92 ",style: TextStyle(color: Colors.white),),
                //       hoverColor: Colors.white,
                //       hintText: "Enter your Phone No.",suffixIconColor: Colors.white,
                //       labelText: 'Phone No.',
                //
                //       border: OutlineInputBorder(
                //
                //         borderRadius: BorderRadius.all(Radius.circular(20.0),),),
                //       prefixIconColor: Colors.white,
                //     ),
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(60.0),
                //   child: ElevatedButton(
                //     style: ElevatedButton.styleFrom(
                //       primary: Colors.white,
                //       elevation: 3,
                //       shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(32.0)),
                //       minimumSize: const Size(200, 50),
                //     ),
                //     onPressed: () async {
                //
                //       Navigator.of(context)
                //           .pushReplacement(MaterialPageRoute(builder: (context) => LoginPhone()));
                //     },
                //     child: const Text("Continue With Phone", style: TextStyle(fontSize: 17,color: Color(0xFFF50057)),),
                //   ),
                //
                //
                // ),

                Container(
                  height: MediaQuery.of(context).size.height*0.50,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.width*0.07,
                        ),
                        Text("Smart Track & Travel",style: TextStyle(color: Colors.white,fontSize: 25),),
                        SizedBox(
                          height: MediaQuery.of(context).size.width*0.10,
                        ),
                        Text("Welcome to Smart Track & Travel",style: TextStyle(color: Colors.white,fontSize: 19),),
                        Text("Let's Start working with us",style: TextStyle(color: Colors.white,fontSize: 19),),
                        // Text("Smart Track & Travel",style: TextStyle(color: Colors.white,fontSize: 19),),

                        SizedBox(
                          height: MediaQuery.of(context).size.width*0.10,
                        ),

                        Padding(
                          padding: const EdgeInsets.all(60.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32.0)),
                              minimumSize: const Size(200, 50), //////// HERE
                            ),
                            onPressed: ()  {
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(builder: (context) => LoginPhone()));

                            },
                            child: const Text("Continue", style: TextStyle(fontSize: 17,color: Colors.blue),),
                          ),
                        ),

                      ],
                    ),
                  ),
                  decoration: new BoxDecoration(
                    color: Colors.blue,

                    borderRadius: BorderRadius.vertical(

                        top: Radius.elliptical(
                            MediaQuery.of(context).size.width, 100.0)),

                  ),

                ),
                // Container(
                //   width: MediaQuery.of(context).size.width / 2,
                //   height: MediaQuery.of(context).size.width / 2,
                //   padding: const EdgeInsets.all(10.0),
                //   decoration: BoxDecoration(
                //     shape: BoxShape.circle,
                //     color: Colors.red,
                //     // image: DecorationImage(
                //     //   image: AssetImage(null),
                //     //   fit: BoxFit.cover,
                //     // ),
                //   ),
                //   child: Text("zzdata"),
                // ),
                // Text("data"),
                // Container(
                //     child: Text("It's text.. kugtiub huyghuj jhgjh ufh ."),
                //     decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(100),  // radius of 10
                //         color: Colors.green  // green as background color
                //     )
                // )
                // Container(
                //
                //   color: Colors.blue,
                //   height: MediaQuery.of(context).size.height*0.50,
                //   //width: MediaQuery.of(context).size.width,
                //   decoration: new BoxDecoration(
                //     color: Colors.red,
                //     borderRadius: BorderRadius.vertical(
                //         bottom: Radius.elliptical(
                //             MediaQuery.of(context).size.width, 100.0)),
                //   ),
                // ),
                // SizedBox(
                //   height: MediaQuery.of(context).size.width*0.25,
                // ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
