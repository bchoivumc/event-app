import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CurrentLocationMap extends StatefulWidget {
  double? latitude;
  double? longitude;
  CurrentLocationMap(this.latitude, this.longitude, {super.key});

  @override
  State<CurrentLocationMap> createState() => _CurrentLocationMapState();
}

class _CurrentLocationMapState extends State<CurrentLocationMap> {
  double pos_latitude = 19.018255973653343;
  double pos_longitude = 72.84793849278007;

  @override
  void initState() {
    super.initState();
    print('current location before Current map page lat: ${widget.latitude} and lon: ${widget.longitude}');
    if (widget.latitude != null && widget.longitude != null) {
      pos_latitude = widget.latitude!;
      pos_longitude = widget.longitude!;
    }
    print('current location after Current map page lat: $pos_latitude and lon: $pos_longitude');
  }
  // static final LatLng _kMapCenter =
  //     LatLng(19.018255973653343, 72.84793849278007);

  // static final CameraPosition _kInitialPosition =
  //     CameraPosition(target: _kMapCenter, zoom: 11.0, tilt: 0, bearing: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Current location'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
            target: LatLng(pos_latitude, pos_longitude),
            zoom: 11.0,
            tilt: 0,
            bearing: 0),
      ),
    );
  }
}
