import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class RideMap extends StatefulWidget {
  final double latitude,longitude, startLatitude, startLongitude;
  final Animation<Offset> offsetAnimation;
  final AnimationController offsetAnimationController;
  final Set<Polyline> polylines;

  RideMap(
      {this.latitude, this.longitude, this.startLatitude, this.startLongitude, this.offsetAnimation, this.offsetAnimationController,this.polylines});
  @override
  _RideMapState createState() => _RideMapState();
}

class _RideMapState extends State<RideMap> with SingleTickerProviderStateMixin {


  BitmapDescriptor _icon;




  @override
  void initState() {
    _getIcon();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SlideTransition(
        position: widget.offsetAnimation,
        child: Container(
          width: double.infinity,
          height: 350,
          child: Stack(
            children: [
              GoogleMap(
                markers: <Marker>{
                  Marker(
                    markerId: MarkerId("current_position"),
                    position: LatLng(
                      widget.latitude,
                      widget.longitude,
                    ),
                    icon: _icon,
                    infoWindow: InfoWindow(
                        title: "Current Location",
                        snippet:
                        "Lat ${widget.latitude} - Lng ${widget.longitude}"),
                  ),
                  Marker(
                    markerId: MarkerId("initial_position"),
                    position: LatLng(
                      widget.startLatitude,
                      widget.startLongitude,
                    ),
                    infoWindow: InfoWindow(
                        title: "Start Location",
                        snippet: "Your Init Location"),
                  ),
                },
                initialCameraPosition: CameraPosition(
                  target: LatLng(widget.latitude,
                      widget.longitude),
                  zoom: 16.5,
                ),
                polylines: widget.polylines,
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xff3061D7)),
                  child: IconButton(
                      icon: Icon(
                        Icons.arrow_downward_rounded,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        widget.offsetAnimationController.reverse();
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //------------| Get Icon from assets |-----------------
  Future<void> _getIcon() async {
    var icon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 3.2), "assets/images/bike.png");
    setState(() => this._icon = icon);
  }
  //====================================================

}
