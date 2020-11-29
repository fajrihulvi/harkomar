import 'package:amr_apps/core/enum/viewstate.dart';
import 'package:amr_apps/core/model/Pelanggan.dart';
import 'package:amr_apps/core/model/User.dart';
import 'package:amr_apps/core/viewmodel/cari_member_model.dart';
import 'package:amr_apps/ui/map_screen.dart';
import 'package:amr_apps/ui/shared/color.dart';
import 'package:amr_apps/ui/widget/maps.dart';
import 'package:amr_apps/ui/widget/search_bar.dart';
import 'package:amr_apps/ui/shared/size.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class CariMemberPasangBaruScreen extends StatefulWidget {
  @override
  _CariMemberPasangBaruScreenState createState() =>
      _CariMemberPasangBaruScreenState();
}

class _CariMemberPasangBaruScreenState
    extends State<CariMemberPasangBaruScreen> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  var items = List<Widget>();
  String query;
  Widget body;
  CariMemberModel model = new CariMemberModel();
  TextEditingController inputBar = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    query = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize:
            Size(screenWidth(context), screenHeight(context, dividedBy: 4.5)),
        child: Container(
          color: ticketColor,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 3, right: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      if (ModalRoute.of(context).canPop)
                        BackButton(
                          color: Colors.black54,
                        ),
                      Text('Pasang Baru'),
                    ],
                  ),
                ),
                RewardSearchBar(
                  titleSearch: 'Cari ID member atau Nama',
                  inputBar: inputBar,
                  onBarcodePressed: (val) {
                    setState(() {
                      this.setBody(context, val);
                    });
                  },
                  onDrawerPressed: () {
                    print('A');
                  },
                  onChanged: (val) {
                    setState(() {
                      this.setBody(context, val);
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: this.body,
    );
  }

  void setBody(BuildContext context, String query) async {
    await model.getberitaAcara(
        Provider.of<User>(context).token, "Pasang Baru", query);
    setState(() {
      this.body = model.state == ViewState.Busy
          ? CircularProgressIndicator()
          : Container(
              child: SingleChildScrollView(
                child: Column(
                  children: this.getUserBar(model.pelanggan),
                ),
              ),
            );
    });
  }

  List<Widget> getUserBar(List<Pelanggan> beritaAcara) {
    print(beritaAcara);
    var items = new List<Widget>();
    if (beritaAcara == null) {
      items.add(
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.description,
                color: Colors.grey[300],
                size: 70.0,
              ),
              Text(
                "Tidak  Ada Data",
                style: TextStyle(color: Colors.grey[300], fontSize: 20),
              )
            ],
          ),
        ),
      );
      return items;
    } else {
      for (var ba in beritaAcara) {
        items.add(this.getSingleUserBar(ba));
      }
      if (items.length == 0) {
        items.add(
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.description,
                  color: Colors.grey[300],
                  size: 70.0,
                ),
                Text(
                  "Tidak  Ada Data",
                  style: TextStyle(color: Colors.grey[300], fontSize: 20),
                )
              ],
            ),
          ),
        );
      }
    }
    return items;
  }

  Widget getSingleUserBar(Pelanggan beritaAcara) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MapScreen(
                    beritaAcara: beritaAcara,
                    myPosition: LatLng(
                        double.parse("-2.742588"), double.parse("107.661691")),
                    pelangganPosition:
                        beritaAcara.lat == null || beritaAcara.long == null
                            ? LatLng(double.parse("-2.742588"),
                                double.parse("107.661691"))
                            : LatLng(double.parse(beritaAcara.lat),
                                double.parse(beritaAcara.long)),
                  ))),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ExpansionTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AutoSizeText(beritaAcara.namaPelanggan),
                    AutoSizeText('ID Pel : ' + beritaAcara.idPel),
                  ],
                ),
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2,
                    child: MapsScreen(
                      beritaAcara: beritaAcara,
                      myPosition: LatLng(double.parse("-2.742588"),
                          double.parse("107.661691")),
                      pelangganPosition:
                          beritaAcara.lat == null || beritaAcara.long == null
                              ? LatLng(double.parse("-2.742588"),
                                  double.parse("107.661691"))
                              : LatLng(double.parse(beritaAcara.lat),
                                  double.parse(beritaAcara.long)),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      RaisedButton(
                          color: appBarTextColor,
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.location_on, color: colorWhite),
                              Text('Petunjuk Arah',
                                  style: TextStyle(color: colorWhite)),
                            ],
                          ),
                          onPressed: () async {
                            String googleUrl =
                                'https://www.google.com/maps/search/?api=1&query=${beritaAcara.lat},${beritaAcara.long}';
                            if (await canLaunch("comgooglemaps://")) {
                              print('launching google maps');
                              await launch(googleUrl);
                            } else {
                              throw 'Could not launch url';
                            }
                          }),
                      RaisedButton(
                          color: primaryColor1,
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.assignment, color: colorWhite),
                              Text('Pasang Sekarang',
                                  style: TextStyle(color: colorWhite)),
                            ],
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                                context, "/detail_pemasangan/first",
                                arguments: beritaAcara);
                          }),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
