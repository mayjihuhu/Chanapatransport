// ignore_for_file: prefer_const_constructors, avoid_print, unnecessary_null_comparison, prefer_collection_literals

import 'dart:io';

import 'package:chanatran/utility/my_dialog.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetLocationShowMap extends StatefulWidget {
  const GetLocationShowMap({Key? key}) : super(key: key);

  @override
  State<GetLocationShowMap> createState() => _GetLocationShowMapState();
}

class _GetLocationShowMapState extends State<GetLocationShowMap> {
  double? lat, lng;
  bool load = true;

  @override
  void initState() {
    super.initState();
    findLatLong();
  }

  Future<void> findLatLong() async {
    bool locationEnable;
    LocationPermission locationPermission;

    locationEnable = await Geolocator.isLocationServiceEnabled();
    if (locationEnable) {
      //Enable Location Service

      locationPermission = await Geolocator.checkPermission();
      if (locationPermission == LocationPermission.deniedForever) {
        MyDialog(context: context).normalDialog(
            title: 'Denyed Forever',
            subTitle: 'Please Open Permission',
            pressFunc: () {
              exit(0);
            });
      }
      if (locationPermission == LocationPermission.denied) {
        await Geolocator.requestPermission();
      } else {
        //Alway
        print('Locaion Can Find');

        Position position = await findPosition();
        if (position != null) {
          lat = position.latitude;
          lng = position.longitude;
          print('lat = $lat, lng = $lng');
          load = false;
          setState(() {});
        }
      }
    } else {
      MyDialog(context: context).normalDialog(
          title: 'None Location Service',
          subTitle: 'Please Open Service',
          pressFunc: () {
            exit(0);
          });
    }
  }

  Future<Position> findPosition() async {
    Position? position;
    try {
      position = await Geolocator.getCurrentPosition();
    } catch (e) {
      position = null;
    }
    return position!;
  }

  Set<Marker> myMarker(){
    return <Marker>[
      Marker(
        markerId: MarkerId('id'),
        position: LatLng(lat!, lng!)
      ),
        ].toSet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: load
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(lat!, lng!),
                zoom: 16,
              ),
              onMapCreated: (Value){},
              markers: myMarker(),
            ),
    );
  }
}
