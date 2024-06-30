import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map/helper/location.dart';

class Map extends StatefulWidget {
  const Map({super.key});

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  Completer<GoogleMapController> _controller=Completer();
  final CameraPosition cameraPosition=CameraPosition(
    bearing: 0.0,
    target: LatLng(position!.latitude,position!.longitude),
    tilt: 0,
    zoom: 17
    );
  static Position? position;

  Future<void>getLocation()async{
    await LocationHelper.getCurntLocation();
    position=await Geolocator.getLastKnownPosition().whenComplete((){
      setState(() {
        
      });
    });

  }
  Widget Map(){
    return GoogleMap(
      mapType: MapType.normal,
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      initialCameraPosition: cameraPosition,
      onMapCreated: (GoogleMapController controller){
        _controller.complete(controller);
      },
      );
  }
  Future<void> goToMyLocation()async{
    GoogleMapController controller=await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Stack(
      children: [
        position !=null?Map():Center(child: CircularProgressIndicator(),)
      ],
    ),
    floatingActionButton: Container(
      margin: EdgeInsets.fromLTRB(0, 0, 8, 30),
      child: FloatingActionButton(onPressed: (){},child:Icon(Icons.place),),
    ),
    );
  }
}