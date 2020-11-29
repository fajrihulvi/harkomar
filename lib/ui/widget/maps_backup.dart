import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'menu.dart';

class MapsScreen extends StatefulWidget {
  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  GoogleMapController _controller;
  Geolocator _geolocator;
  LatLng _currentPosition;
  double _currentZoom;
  String _textToDisplay;
  StreamSubscription<Position> _positionStream;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  bool _shouldRecenterMap = true;
  Timer _mapDragTimer;

  @override
  void initState() {
    super.initState();

    _textToDisplay = "Sedang melacak posisi kamu..";
    _currentPosition = LatLng(-2.157354, 106.142579);
    _currentZoom = 17.5;

    _initLocationService();

  }

  Future<void> _initLocationService() async {
    _geolocator = Geolocator();

    var locationOptions = LocationOptions(accuracy: LocationAccuracy.best);

    try {
      _currentPosition = LatLng(-2.157354, 106.142579); ///latitude dan longitude di dapat dari database.

      _positionStream =
          _geolocator.getPositionStream(locationOptions).listen((position) {
            if (position != null) {
              _updateCurrentPosition(_currentPosition);
            }
          });
    } on PlatformException catch (_) {
      print("Permission denied");
    }
  }

  @override
  void dispose() {
    _positionStream.cancel();
    super.dispose();
  }

  void _updateCurrentPosition(LatLng position) {
    _currentPosition = LatLng(position.latitude, position.longitude);

    _moveMarker(position);
    _refreshCameraPosition();
    _geocodeCurrentPosition();
  }

  void _moveMarker(LatLng position) {
    var markerId = MarkerId("currentPos");
    setState(() {
      markers[markerId] =
          Marker(markerId: markerId, position: _currentPosition);
    });
  }

  void _refreshCameraPosition() {
    if (_controller != null && _shouldRecenterMap) {
      _controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: _currentPosition, zoom: _currentZoom),
      ));
    }
  }

  void _geocodeCurrentPosition() async {

    var resultList = await _geolocator.placemarkFromCoordinates(
        _currentPosition.latitude, _currentPosition.longitude,
        localeIdentifier: "id-ID");

    if (resultList.length > 0) {
      Placemark firstResult = resultList[0];

      String textResult = firstResult.thoroughfare +
          " " +
          firstResult.subThoroughfare +
          ", " +
          firstResult.locality;

      setState(() {
        print('''aasssuuuk''');
        _textToDisplay = textResult;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            GoogleMap(
              initialCameraPosition:
              CameraPosition(target: _currentPosition, zoom: _currentZoom),
              mapType: MapType.normal,
              onMapCreated: (controller) {
                _controller = controller;
              },
              onCameraMove: (cameraPosition) {
                _currentZoom = cameraPosition.zoom;

                //disable recenter, reenable after 3 second
                _shouldRecenterMap = false;
                if (_mapDragTimer != null && _mapDragTimer.isActive) {
                  _mapDragTimer.cancel();
                }
                _mapDragTimer = Timer(Duration(seconds: 3), () {
                  _shouldRecenterMap = true;
                });
              },
              markers: Set<Marker>.of(markers.values),
            ),
            SafeArea(
              child: Container(
                padding: EdgeInsets.all(8.0),
                width: double.infinity,
                child: Card(
                  child: Container(
                    height: 60.0,
                    padding: EdgeInsets.all(16.0),
                    child: Center(
                      child: Text(_textToDisplay),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
