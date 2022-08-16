import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../driver/driver_profile.dart';
class GooMap1 extends StatefulWidget {
   GooMap1({Key? key,required this.ls,required this.los,required this.data
     ,required this.a,required this.b,required this.c
     ,required this.d,required this.e,required this.f
     ,required this.g,required this.h,required this.i
     ,required this.j,required this.k,required this.l,
   }) : super(key: key);
   final String ls,los,data,a,b,c,d,e,f,g,h,i,j,k,l;
  @override
  State<GooMap1> createState() => _GoogleMapState();
}

class _GoogleMapState extends State<GooMap1> {
  final Completer<GoogleMapController> _controller= Completer();
  final Set<Polyline> _polyline={};
  final Set<Marker> _markers={};
  dynamic latstart=0.0;
  dynamic longstart=0.0;
   // dynamic latend=0.0;
   // dynamic longend=0.0;
   // List<LatLng> latlong =[
   //   LatLng(widget.latdr, longdriver),
   //   LatLng(33.567997728, 72.635997456),
   // ];

  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  late StreamSubscription<Position> positionStream;

  @override
  Widget build(BuildContext context) {

    _markers.add(
      Marker(
          markerId: MarkerId("a"),
          position: LatLng(latstart,longstart),
          infoWindow: InfoWindow(
              title: 'Start Point'
          )
      ),
    );
    // _markers.add(
    //   Marker(
    //       markerId: MarkerId("b"),
    //       position: LatLng(latend,longend),
    //       infoWindow: InfoWindow(
    //           title: 'Parent Location'
    //       )
    //   ),
    // );
    // _polyline.add(
    //   Polyline(polylineId: PolylineId("1"),
    //       points: <LatLng>[
    //         LatLng(latstart, longstart),
    //         LatLng(latend, longend),
    //       ],
    //     color: Colors.blue
    //   ),
    // );

    return SafeArea(
        child: Scaffold(
          body: GoogleMap(
            onTap: (location){


              print("location okay");
              print(location.longitude);
              print(location.latitude);
              setState(() {


              });


              latstart=location.latitude;
              longstart=location.longitude;


            },
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },

            initialCameraPosition: CameraPosition(
              target: LatLng(33.720000, 73.060000),
              zoom: 16.0,
            ),
            mapType: MapType.normal,
            markers: _markers,
            polylines: _polyline

          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 80),
            child: ElevatedButton(child: Text("Add Location"),onPressed: (){
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (context) => DriverProfile(data:widget.data,lat:latstart.toString(),long:longstart.toString(),late: widget.ls,longe: widget.los,
                a:widget.a,b:widget.b,c:widget.c,d:widget.d,e:widget.e,
                f:widget.f,g:widget.g,h:widget.h,i:widget.i,j:widget.j,
                k:widget.k,l:widget.l,
              )));

            },),
          ),

        )
    );
  }
}
