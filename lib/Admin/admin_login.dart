import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../phone_login_two_type_user/login_phone.dart';
import 'admin_home.dart';
class AdminLogin extends StatefulWidget {
  const AdminLogin({Key? key}) : super(key: key);

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  bool _isObscure = true;

  final _formKey = GlobalKey<FormState>();
  final _usernameController = new TextEditingController();
  final _passwordController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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
                          child: Text("Admin Login",style: TextStyle(
                            fontSize:22,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),),
                        ),
                      ),

                    ],
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
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'User Name',
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20.0)),),
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(20.0),
                  //   child: TextFormField(
                  //     validator: (value) {
                  //       if (value == null || value.isEmpty) {
                  //         return 'Please enter Password';
                  //       }
                  //       return null;
                  //     },
                  //     controller: _passwordController,
                  //     obscureText: _isObscure,
                  //     decoration: const InputDecoration(
                  //       suffixIcon: IconButton(
                  //         icon: Icon(
                  //           _isObscure ? Icons.visibility : Icons.visibility_off,
                  //         ),
                  //         onPressed: () {
                  //           setState(() {
                  //             _isObscure = !_isObscure;
                  //           });
                  //         },
                  //       ),
                  //
                  //       labelText: 'Password',
                  //       border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20.0)),),
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: _isObscure,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if(value.length < 5){
                          return 'Please enter more than 6 character password';
                        }

                        return null;
                      },
                      decoration:  InputDecoration(

                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscure ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                        ),
                        hintText: "Enter your Password",
                        labelText: 'Password',
                        border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20.0)),),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width*0.15,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
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
                           print(_usernameController.text);
                           print(_passwordController.text);
                           late DatabaseReference _reference;
                           _reference =FirebaseDatabase.instance.reference().child("Admin");
                           _reference.once().then((DataSnapshot event) {
                             var values = event.value;
                             Map<dynamic,dynamic> map = values as Map<dynamic,dynamic>;


                             map.forEach((key,value){

                               var user = value['username'];
                               var long = value['password'];
                               print(long);
                               print(user);
                               String a=_usernameController.text+_passwordController.text;
                               String b=user+long;
                               if(a==b){
                                 Navigator.of(context)
                                     .pushReplacement(MaterialPageRoute(builder: (context) => AdminHome()));
                                 Fluttertoast.showToast(
                                     msg: "Admin Login Successfully",
                                     toastLength: Toast.LENGTH_SHORT,
                                     gravity: ToastGravity.BOTTOM,
                                     timeInSecForIosWeb: 1,
                                     backgroundColor: Colors.blue,
                                     textColor: Colors.white,
                                     fontSize: 16.0
                                 );
                               }
                               else{
                                print("wrong user name or password");
                                Fluttertoast.showToast(
                                    msg: "Wrong User Name or Password",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.blue,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                               }

                             });
                           });
                          //
                          // //

                        }
                      },
                      child: const Text("Continue", style: TextStyle(fontSize: 17,),),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.of(context)
                          .pushReplacement(MaterialPageRoute(builder: (context) => LoginPhone()));
                    },
                    child:

                    Column(
                      children: [
                        Text("User Login",style: TextStyle(color: Colors.blue),),
                        Text("Click Here",),
                      ],
                    ),
                  ),


                ],
              ),
            ),
          ),
        )
    );
  }
}
