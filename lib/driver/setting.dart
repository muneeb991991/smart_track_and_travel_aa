import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  late TextEditingController _usernameController, _passwordController;
  late DatabaseReference _reference;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _usernameController=TextEditingController();
    _passwordController=TextEditingController();
    _reference =FirebaseDatabase.instance.reference().child('applock');
  }
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    inputDat();
    return SingleChildScrollView(

      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width*0.10,
                ),
                Text("APP Lock",style: TextStyle(fontSize: 27,color: Colors.blue),),

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
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Password';
                      }
                      return null;
                    },
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20.0)),),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
                height: MediaQuery.of(context).size.width*0.15
            ),


            ElevatedButton(
              child: Text('Save Lock',style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
            ),
              onPressed: (){
              print(_passwordController.text);
              print(_usernameController.text);
              print(quan.tity);

                String uid = quan.tity+"Driver"+_passwordController.text+_usernameController.text;
                String key = _reference.push().key as String;
                Map<String,String> products={
                  'uid' :uid,
                };
                _reference.child(quan.tity).set(products).then((value) {
                  Fluttertoast.showToast(
                      msg: "Enable your App Lock",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.blue,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );
                });

              },
            ),
            SizedBox(
                height: MediaQuery.of(context).size.width*0.15
            ),
            ElevatedButton(
              child: Text('Disable App Lock',style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              ),
              onPressed: (){
                String uid = quan.tity+"Driver";
                String key = _reference.push().key as String;
                Map<String,String> products={
                  'uid' :uid,
                };
                _reference.child(quan.tity).set(products).then((value) {
                  setState(() {
                    _usernameController.text='';
                    _passwordController.text='';
                    Fluttertoast.showToast(
                        msg: "Disable your App Lock",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.blue,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  });
                });
              },
            ),
          ],
        ),
      ),
    );
  }
  void inputDat() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user?.uid;
    String? l =uid;
    quan.tity=l!;
   }
}
class quan{
  static String tity='';
}
