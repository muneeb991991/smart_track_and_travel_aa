import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class GooMap extends StatefulWidget {
   GooMap({Key? key,required this.duid,required this.latdr,required this.lond}) : super(key: key);
   String duid;
   double latdr,lond;
  @override
  State<GooMap> createState() => _GoogleMapState();
}

class _GoogleMapState extends State<GooMap> {
  final Completer<GoogleMapController> _controller= Completer();
  final Set<Polyline> _polyline={};
  final Set<Marker> _markers={};
  dynamic latparent=0.0;
  dynamic longparent=0.0;
   double latdriver=0.0;
   double longdriver=0.0;
   // List<LatLng> latlong =[
   //   LatLng(widget.latdr, longdriver),
   //   LatLng(33.567997728, 72.635997456),
   // ];

  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  late StreamSubscription<Position> positionStream;
  checkGps() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if(servicestatus){
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
        }else if(permission == LocationPermission.deniedForever){
          print("'Location permissions are permanently denied");
        }else{
          haspermission = true;
        }
      }else{
        haspermission = true;
      }
      if(haspermission){
        setState(() {
          //refresh the UI
        });
        getLocation();
      }
    }else{
      print("GPS Service is not enabled, turn on GPS location");
    }

    setState(() {
      //refresh the UI
    });
  }
  getLocation() async {
    position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    double long = position.longitude;
    double lat = position.latitude;
    latparent=lat;
    longparent=long;
    setState(() {
      //refresh UI
    });

    LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high, //accuracy of the location data
      distanceFilter: 100, //minimum distance (measured in meters) a
      //device must move horizontally before an update event is generated;
    );

    StreamSubscription<Position> positionStream = Geolocator.getPositionStream(
        locationSettings: locationSettings).listen((Position position) {
      print(position.longitude); //Output: 80.24599079
      print(position.latitude); //Output: 29.6593457

      double long = position.longitude;
      double lat = position.latitude;

      latparent=lat;
      longparent=long;
     // var myDouble = int.parse('123.45');

      setState(() {
        //refresh UI on update
      });
    });
  }

  @override
  void initState() {

    checkGps();
    latdriver=widget.latdr;
    longdriver=widget.lond;


      setState(() {

      });




  }

  @override
  Widget build(BuildContext context) {

    _markers.add(
      Marker(
          markerId: MarkerId("a"),
          position: LatLng(latdriver,longdriver),
          infoWindow: InfoWindow(
              title: 'Driver Location'
          )
      ),
    );_markers.add(
      Marker(
          markerId: MarkerId("b"),
          position: LatLng(latparent,longparent),
          infoWindow: InfoWindow(
              title: 'Parent Location'
          )
      ),
    );
    _polyline.add(
      Polyline(polylineId: PolylineId("1"),
          points: <LatLng>[
            LatLng(latdriver, longdriver),
            LatLng(latparent, longparent),
          ],
        color: Colors.blue
      ),
    );

    return SafeArea(
        child: Scaffold(
          body: GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },

            initialCameraPosition: CameraPosition(
              target: LatLng(widget.latdr, widget.lond),
              zoom: 16.0,
            ),
            mapType: MapType.normal,
            markers: _markers,
            polylines: _polyline

          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 80),
            child: ElevatedButton(child: Text("Update Location"),onPressed: (){
              print(widget.duid);
              print("print");
            Query referenceDat =FirebaseDatabase.instance.reference().child("DriversLocations").orderByChild("driveruid").equalTo(widget.duid);
            referenceDat.once().then((DataSnapshot event) {
              var values = event.value;
              Map<dynamic,dynamic> map = values as Map<dynamic,dynamic>;
              map.forEach((key,value){
                var lat = value['Lat'];
                var long = value['Long'];
                print("lllllllll");
                double a=double.parse(lat);
                double b=double.parse(long);
                setState(() {
                  latdriver=a;
                  longdriver=b;
                });


              });
              setState(() {

              });
            });
        },),
          ),

        )
    );
  }
}
