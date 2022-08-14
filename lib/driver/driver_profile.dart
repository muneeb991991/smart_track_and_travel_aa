import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smart_track_and_travel/phone_login_two_type_user/check_type.dart';
import 'home_driver.dart';
class DriverProfile extends StatefulWidget {
  const DriverProfile({Key? key,required this.data}) : super(key: key);

  final String data;
  @override
  _CreateEditAccountState createState() => _CreateEditAccountState();
}
class _CreateEditAccountState extends State<DriverProfile> {
  late String fileUrl;
  int c =0;
  late TextEditingController _nameController, _phoneController, _totalseatsController,_reserveseatsController,
      _routeController,_vehicalnoController,_vehicalcolorController,_DuesController,_availableseatsController,_destinationController,_cnicController;
  late File imgFile;
  late DatabaseReference _reference;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController=TextEditingController();
    _phoneController=TextEditingController();
    _totalseatsController=TextEditingController();
    _reserveseatsController=TextEditingController();
    _routeController=TextEditingController();
    _vehicalnoController=TextEditingController();
    _vehicalcolorController=TextEditingController();
    _DuesController=TextEditingController();
    _availableseatsController=TextEditingController();
    _destinationController=TextEditingController();
    _cnicController=TextEditingController();
    _reference =FirebaseDatabase.instance.reference().child('Drivers');
  }
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {


    return  SafeArea(
      child: Scaffold(

        //resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  height: 70,
                  width: 70,
                  child:c==0 ? Icon(Icons.person,size: 70,color: Colors.blue,):
                  Image.file(
                    imgFile,
                    height: 200,
                    width: double.infinity,
                  ),
                ),
                RaisedButton(
                    child: Text('Upload image',style: TextStyle(color: Colors.white),),
                    color: Colors.blue,

                    onPressed: (){
                       uploadImage();
                    }),
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
                         controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Driver Name',
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
                        controller: _phoneController,
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
                        controller: _cnicController,
                        decoration: const InputDecoration(
                          labelText: 'CNIC Number',
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
                        controller: _totalseatsController,
                        decoration: const InputDecoration(
                          labelText: 'Total Seats',
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
                         controller: _reserveseatsController,
                        decoration: const InputDecoration(
                          labelText: 'Resrve Seats',
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
                        controller: _availableseatsController,
                        decoration: const InputDecoration(
                          labelText: 'Available Seats',
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
                         controller: _routeController,
                        minLines: 2,
                        maxLines: 5,
                        decoration: const InputDecoration(
                          labelText: 'Route',
                          // hintText: 'description',
                          hintStyle: TextStyle(
                              color: Colors.grey
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          ),
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
                        minLines: 2,
                        maxLines: 5,
                        decoration: const InputDecoration(
                          labelText: 'Destination',
                          // hintText: 'description',
                          hintStyle: TextStyle(
                              color: Colors.grey
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          ),
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
                         controller: _vehicalnoController,
                        decoration: const InputDecoration(
                          labelText: 'Vehicle Number',
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
                        controller: _vehicalcolorController,
                        decoration: const InputDecoration(
                          labelText: 'Vehicle Color',
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
                         controller: _DuesController,
                        decoration: const InputDecoration(
                          labelText: 'Dues per Month',
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20.0)),),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.width*0.15
                ),


                ElevatedButton(child: Text('Save Product',style: TextStyle(
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


    String name = _nameController.text;
    String phone = _phoneController.text;
    String totalseats = _totalseatsController.text;
    String reserveseats = _reserveseatsController.text;
    String availableseats = _availableseatsController.text;
    String route = _routeController.text;
    String vahicalno = _vehicalnoController.text;
    String vehicalcilor = _vehicalcolorController.text;
    String dues = _DuesController.text;
    String destination = _destinationController.text;
    String cnic = _cnicController.text;
    String key = _reference.push().key as String;
    Map<String,String> products={
      'name' :name,
      'phone' :phone,
      'totalseats' :totalseats,
      'reserveseats' :reserveseats,
      'availableseats' :availableseats,
      'route' :route,
      'vahicalno' :vahicalno,
      'vehicalcilor' :vehicalcilor,
      'dues' :dues,
      'raating' :5.toString(),
      'raatingno' :0.toString(),
      'picUrl' :fileUrl,
      'destination' :destination,
      'uid' : l!,
      'status' : "Active",
      'Cnic' : cnic,

    };


    _reference.child(widget.data).set(products).then((value) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => HomeDriver()));
    });


  }
  Future<void> uploadImage() async {

    final _fireStorage = FirebaseStorage.instance;
    final image = ImagePicker();
    PickedFile pickedFile;

    // Request Photos Permission
    await Permission.photos.request();
    var permissionStatus = await Permission.photos.status;

    // Checking Permission
    if (permissionStatus.isGranted) {
      pickedFile = (await image.getImage(source: ImageSource.gallery))!;
      if (pickedFile != null) {
        imgFile = File(pickedFile.path);
        setState(() {
          c=1;
        });
        var file = imgFile;
        // Getting File Path
        String fileName = file.uri.path.split('/').last;

        // Uploading Image to FirebaseStorage
        var filePath = await _fireStorage
            .ref()
            .child('demo/$fileName')
            .putFile(file)
            .then((value) {
          return value;
        });
        // Getting Uploaded Image Url
        String downloadUrl = await filePath.ref.getDownloadURL();
        fileUrl = downloadUrl;
        setState(() {});
      } else {
        print('No Image Selected');
      }
    } else {
      print('Provider Permission');
    }
  }
}


