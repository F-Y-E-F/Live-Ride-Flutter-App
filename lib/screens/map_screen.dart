import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatelessWidget {
  final String title;
  final LatLng startPosition;
  final LatLng endPosition;
  final Set<Polyline> polylines;

  MapScreen({this.title, this.startPosition, this.endPosition,this.polylines});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: GoogleMap(
        polylines: polylines,
        initialCameraPosition: CameraPosition(
          target: LatLng((startPosition.latitude+endPosition.latitude)/2,(startPosition.longitude+endPosition.longitude)/2),
          zoom: 13,
        ),
        markers: {
          Marker(
            markerId: MarkerId("start_loc"),
            position: startPosition,
            infoWindow: InfoWindow(
                title: "Start Location",
                snippet:
                    "Lat ${startPosition.latitude} - Lng ${startPosition.longitude}"),
          ),
          Marker(
            markerId: MarkerId("end_loc"),
            position: endPosition,
            infoWindow: InfoWindow(
                title: "End Location",
                snippet:
                "Lat ${endPosition.latitude} - Lng ${endPosition.longitude}"),
          ),
        },
      ),
    );
  }
}
