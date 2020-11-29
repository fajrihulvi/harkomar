import 'dart:async';

import 'package:amr_apps/core/model/Pelanggan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'menu.dart';

class MapsScreen extends StatefulWidget {
  final LatLng pelangganPosition;
  final LatLng myPosition;
  final Pelanggan beritaAcara;

  const MapsScreen({this.pelangganPosition,this.myPosition,this.beritaAcara});
  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  GoogleMapController _controller;
  Geolocator _geolocator;
  LatLng _currentPosition;
  double _currentZoom;
  String _textToDisplay;
  String _posisiPelanggan;
  StreamSubscription<Position> _positionStream;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  final Set<Marker> _markers = {};
  bool _shouldRecenterMap = true;
  Timer _mapDragTimer;

  @override
  void initState() {
    super.initState();

    _textToDisplay = "Sedang melacak posisi..";
    _posisiPelanggan = "Sedang melacak posisi pelanggan";
    _currentPosition = this.widget.myPosition;

    _currentZoom = 14;

    _initLocationService();

  }

  Future<void> _initLocationService() async {
    _geolocator = Geolocator()..forceAndroidLocationManager;

    var locationOptions = LocationOptions(accuracy: LocationAccuracy.best);

    try {
      _currentPosition = this.widget.myPosition;// LatLng(-2.070556, 106.077080); ///latitude dan longitude di dapat dari database.

      _positionStream =
          _geolocator.getPositionStream(locationOptions).listen((position) {
            if (position != null) {
              _currentPosition = LatLng(position.latitude,position.longitude);
              _updateCurrentPosition(_currentPosition);
              _updatePelangganPosition(this.widget.pelangganPosition,this.widget.beritaAcara);
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

  void _updateCurrentPosition(LatLng position) async{
    _currentPosition = LatLng(position.latitude, position.longitude);

    _moveMarker(position);
    _refreshCameraPosition();
    _geocodeCurrentPosition();
  }
  void _updatePelangganPosition(LatLng position,Pelanggan beritaAcara) async{
    var markerId = MarkerId("Posisi "+beritaAcara.namaPelanggan);
    setState(() {
      _markers.add(Marker(
        markerId: markerId,
        position: position,
        icon:BitmapDescriptor.defaultMarker,
      ));
      
      _geocodeCurrentPosition();
      //markers[markerId] =
          //Marker(markerId: markerId, position: _currentPosition);
    });
  }

  void _moveMarker(LatLng position) {
    var markerId = MarkerId("Posisi Saya");
    setState(() {
      _markers.add(Marker(
        markerId: markerId,
        position: position,
        icon:BitmapDescriptor.defaultMarker,
      ));
      //markers[markerId] =
          //Marker(markerId: markerId, position: _currentPosition);
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

    print('Lokasi Saya >>>>>>>>>>>>>>>>>>>>> $_currentPosition');
    print('Lokasi Saya >>>>>>>>>>>>>>>>>>>>> ${_currentPosition.longitude } + " " + ${_currentPosition.latitude} ');
    var resultList = await _geolocator.placemarkFromCoordinates(
        _currentPosition.latitude, _currentPosition.longitude,
        localeIdentifier: "Posisi Saya");
    print('''aasssuuura''');

    if (resultList.length > 0) {
      print('''aasssuuu''');
      Placemark firstResult = resultList[0];

      String textResult = firstResult.thoroughfare +
          " " +
          firstResult.subThoroughfare +
          ", " +
          firstResult.locality;

      setState(() {
        _textToDisplay = textResult;
      });
    }
    print('Lokasi Saya >>>>>>>>>>>>>>>>>>>>> ${this.widget.pelangganPosition.longitude } + " " + ${this.widget.pelangganPosition.latitude} ');
    resultList = await _geolocator.placemarkFromCoordinates(
        this.widget.pelangganPosition.latitude, this.widget.pelangganPosition.longitude,
        localeIdentifier: "Posisi Saya");

    if (resultList.length > 0) {
      Placemark firstResult = resultList[0];

      String textResult = firstResult.thoroughfare +
          " " +
          firstResult.subThoroughfare +
          ", " +
          firstResult.locality;

      setState(() {
        _posisiPelanggan = textResult;
      });
    }
  }
  Widget _zoomminusfunction() {

    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: IconButton(
            icon: Icon(Icons.zoom_out,color:Color(0xff6200ee)),
            onPressed: () {
              this._currentZoom--;
             _minus( this._currentZoom--);
            }),
      )
    );
 }
 Widget _zoomplusfunction() {
   
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: IconButton(
            icon: Icon(Icons.zoom_in,color:Color(0xff6200ee)),
            onPressed: () {
              this._currentZoom++;
              _plus(this._currentZoom++);
            }),
      )
    );
 }

 void _minus(double zoomVal) {
    _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: _currentPosition, zoom: zoomVal)));
  }
 void _plus(double zoomVal) {
    _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: _currentPosition, zoom: zoomVal)));
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
              markers: this._markers,
            ),
            SafeArea(
              child: Container(
                padding: EdgeInsets.all(8.0),
                width: double.infinity,
                child: Column(
                  children: <Widget>[ 
                    Card(
                      child: Container(
                        height: 60.0,
                        padding: EdgeInsets.all(16.0),
                        child: Center(
                          child: Text(_textToDisplay),
                        ),
                      ),
                    ),
                    Card(
                      child: Container(
                        height: 60.0,
                        padding: EdgeInsets.all(16.0),
                        child: Center(
                          child: Text(_posisiPelanggan),
                        ),
                      ),
                    ),
                ],
                )
              ),
            ),
                    _zoomminusfunction(),
                    _zoomplusfunction(),
          ],
        ),
      ),
    );
  }
}
