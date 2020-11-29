import 'package:amr_apps/core/model/Berita_Acara.dart';
import 'package:amr_apps/core/model/Pelanggan.dart';
import 'package:amr_apps/ui/widget/maps.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
 final LatLng pelangganPosition;
  final LatLng myPosition;
  final Pelanggan beritaAcara;
  const MapScreen({this.pelangganPosition,this.myPosition,this.beritaAcara});
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: SingleChildScrollView(
    child: Column(
    mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Flexible(
            fit: FlexFit.loose,
            child:
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: MapsScreen(
                beritaAcara: this.widget.beritaAcara,
                myPosition: this.widget.myPosition,
                pelangganPosition: this.widget.pelangganPosition,
                ),
            )),
      ],
    ),
    ),
    ));
  }
}
