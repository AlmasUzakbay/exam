import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'dart:math';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  LatLng? _currentPosition;
  LatLng? _selectedPosition;
  late GoogleMapController _mapController;
  double _distance = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(0, 0),
              zoom: 15,
            ),
            mapType: MapType.normal,
            myLocationEnabled: true,
            markers: _markers,
            polylines: _polylines,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              _mapController = controller;
              _getCurrentLocation();
            },
            onTap: _onMapTap,
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Distance: $_distance meters',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    _calculateDistance();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    backgroundColor: Colors.black,
                  ),
                  child: Text(
                    'Calculate Distance',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onMapTap(LatLng position) {
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
          markerId: MarkerId('Current Location'),
          position: _currentPosition!,
        ),
      );
      _markers.add(
        Marker(
          markerId: MarkerId('Selected Location'),
          position: position,
        ),
      );
      _selectedPosition = position;

      if (_currentPosition != null && _selectedPosition != null) {
        _calculateDistance();
      }
    });
  }

  Future<void> _calculateDistance() async {
    if (_currentPosition == null || _selectedPosition == null) {
      return;
    }

    double distanceInMeters = await _getDistance(
      _currentPosition!.latitude,
      _currentPosition!.longitude,
      _selectedPosition!.latitude,
      _selectedPosition!.longitude,
    );

    setState(() {
      _distance = distanceInMeters;
    });

    _polylines.clear();
    _polylines.add(
      Polyline(
        polylineId: PolylineId('route'),
        color: Colors.blue,
        width: 3,
        points: [
          _currentPosition!,
          _selectedPosition!,
        ],
      ),
    );

    _mapController.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: LatLng(
            min(_currentPosition!.latitude, _selectedPosition!.latitude),
            min(_currentPosition!.longitude, _selectedPosition!.longitude),
          ),
          northeast: LatLng(
            max(_currentPosition!.latitude, _selectedPosition!.latitude),
            max(_currentPosition!.longitude, _selectedPosition!.longitude),
          ),
        ),
        50.0,
      ),
    );
  }

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
      _markers.add(
        Marker(
          markerId: MarkerId('Current Location'),
          position: _currentPosition!,
        ),
      );
    });
  }

  Future<double> _getDistance(
      double startLat, double startLng, double endLat, double endLng) async {
    const double pi = 3.1415926535897932;
    const double earthRadius = 6371000;

    double dLat = (endLat - startLat) * (pi / 180);
    double dLng = (endLng - startLng) * (pi / 180);
    double a = (sin(dLat / 2) * sin(dLat / 2)) +
        (cos(startLat * (pi / 180)) *
            cos(endLat * (pi / 180)) *
            sin(dLng / 2) *
            sin(dLng / 2));
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = earthRadius * c;

    return distance;
  }
}
