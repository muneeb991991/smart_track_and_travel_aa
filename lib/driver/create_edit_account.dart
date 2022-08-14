import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../data.dart';
import 'home_driver.dart';
class CreateEditAccount extends StatefulWidget {
  const CreateEditAccount({Key? key,required this.data}) : super(key: key);
  final Data data;
  @override
  _CreateEditAccountState createState() => _CreateEditAccountState();
}
class _CreateEditAccountState extends State<CreateEditAccount> {
  late String fileUrl;
  int c =0;
  late TextEditingController _nameController, _phoneController, _totalseatsController,_reserveseatsController,
      _routeController,_vehicalnoController,_vehicalcolorController,_DuesController,_availableseatsController,_desController;
  late File imgFile;
  late DatabaseReference _reference;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController=TextEditingController(text: widget.data.DriverName);
    _phoneController=TextEditingController(text: widget.data.phoneno);
    _totalseatsController=TextEditingController(text: widget.data.totalseats);
    _reserveseatsController=TextEditingController(text: widget.data.reserve);
    _routeController=TextEditingController(text: widget.data.route);
    _vehicalnoController=TextEditingController(text: widget.data.vehicalno);
    _vehicalcolorController=TextEditingController(text: widget.data.vehicalcolor);
    _DuesController=TextEditingController(text: widget.data.dues);
    _availableseatsController=TextEditingController(text: widget.data.available);
    _desController=TextEditingController(text: widget.data.destination);
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
                  child:c==0 ? SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.width*0.25,
                    child: Container(
                      //height: MediaQuery.of(context).size.width*0.25,
                      alignment: const Alignment(0.0,2.5),
                      child:  CircleAvatar(
                        backgroundColor: Colors.black12,
                        child:
                        CircleAvatar(
                          // backgroundColor: Colors.black12,
                          radius: 65,
                          //backgroundImage: AssetImage('assets/bottombar/loading.gif'),
                          child: CircleAvatar(
                            radius: 65,
                            backgroundColor: Colors.transparent,
                            backgroundImage: NetworkImage(widget.data.image),
                          ),
                        ),
                        radius: 80.0,
                      ),
                    ),
                  ):
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
                    ),Padding(
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
                        controller: _desController,
                        decoration: const InputDecoration(
                          labelText: 'Destination',
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


    String name = _nameController.text;
    String phone = _phoneController.text;
    String totalseats = _totalseatsController.text;
    String reserveseats = _reserveseatsController.text;
    String availableseats = _availableseatsController.text;
    String route = _routeController.text;
    String vahicalno = _vehicalnoController.text;
    String vehicalcilor = _vehicalcolorController.text;
    String dues = _DuesController.text;
    String dest = _desController.text;
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
      'destination' :dest,
      'picUrl' :fileUrl,
      'uid' : widget.data.uoid
    };


    _reference.child(widget.data.uoid).set(products).then((value) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => HomeDriver()));
    });
    //Navigator.pop(context);
    // });

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
