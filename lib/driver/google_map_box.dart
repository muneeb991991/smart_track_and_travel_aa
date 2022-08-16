import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class GooMapBox extends StatefulWidget {
  GooMapBox({Key? key,required this.ls,required this.los,required this.le,required this.loe}) : super(key: key);

   double ls,los,le,loe;
  @override
  State<GooMapBox> createState() => _GoogleMapState();
}

class _GoogleMapState extends State<GooMapBox> {
  final Completer<GoogleMapController> _controller= Completer();
  final Set<Polyline> _polyline={};
  final Set<Marker> _markers={};





  @override
  void initState() {




  }

  @override
  Widget build(BuildContext context) {
    print(widget.ls);
    setState(() {
      _markers.add(
        Marker(
            markerId: MarkerId("a"),
            position: LatLng(widget.ls,widget.los),
            infoWindow: InfoWindow(
                title: 'Start Point'
            )
        ),
      );_markers.add(
        Marker(
            markerId: MarkerId("b"),
            position: LatLng(widget.le,widget.loe),
            infoWindow: InfoWindow(
                title: 'Destination Point'
            )
        ),
      );
      _polyline.add(
        Polyline(polylineId: PolylineId("1"),
            points: <LatLng>[
              LatLng(widget.ls,widget.los),
              LatLng(widget.le,widget.loe),
            ],
            color: Colors.blue
        ),
      );

    });



    return
      GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },

        initialCameraPosition: CameraPosition(
          target: LatLng(widget.ls,widget.los),
          zoom: 16.0,
        ),
        mapType: MapType.normal,
        markers: _markers,
        polylines: _polyline




    );
  }
}
