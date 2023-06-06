import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  final Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = LatLng(-6.21462, 106.84513);
  final Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);

    setState(() {
      _markers.add(
        const Marker(
          markerId: MarkerId('id'),
          position: _center,
          infoWindow: InfoWindow(
            title: 'Monumen Nasional',
            snippet: 'Jakarta, Indonesia',
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
