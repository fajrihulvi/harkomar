import 'package:amr_apps/core/enum/viewstate.dart';
import 'package:amr_apps/core/model/User.dart';
import 'package:amr_apps/core/model/WorkOrder.dart';
import 'package:amr_apps/core/viewmodel/home_model.dart';
import 'package:amr_apps/ui/detail_wo_pemasangan_screen.dart';
import 'package:amr_apps/ui/detail_wo_pemeriksaan_screen.dart';
import 'package:amr_apps/ui/shared/color.dart';
import 'package:amr_apps/ui/shared/fadeAnimation.dart';
import 'package:amr_apps/ui/shared/image.dart';
import 'package:amr_apps/ui/shared/size.dart';
import 'package:amr_apps/ui/widget/WoCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'base_view.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<Null> _refresh() async {
    setState(() {});
  }

  Widget _shimmer(double height, double width, {Color color = Colors.white}) {
    return SizedBox(
      width: height,
      height: width,
      child: Shimmer.fromColors(
        baseColor: Colors.white24,
        highlightColor: color,
        child: Text(
          'Shimmer',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 40.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeModel>(
      onModelReady: (model) =>
          model.getWorkOrder(Provider.of<User>(context).token),
      builder: (context, model, child) => Scaffold(
        body: SingleChildScrollView(
          child: RefreshIndicator(
            onRefresh: _refresh,
            child: Column(
              children: <Widget>[
                PreferredSize(
                  preferredSize: Size(screenWidth(context),
                      screenHeight(context, dividedBy: 8)),
                  child: SafeArea(
                    child: Container(
                      height: 300,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/background.png'),
                              fit: BoxFit.fill)),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 250,
                            child: Container(
                              child: Container(
                                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                          'assets/images/logo.png',
                                          width: 50.0,
                                        ),
                                        Text(
                                          "Selamat Datang",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),
                                        Text("   ")
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(
                                          width: 20,
                                        ),
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Container(
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey[200],
                                                    blurRadius: 5.0,
                                                    offset: Offset(
                                                      0,
                                                      1.0,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              width: 70,
                                              height: 70,
                                              child: Container(
                                                child: Icon(
                                                  Icons.person,
                                                  size: 40.0,
                                                  color: primaryColor1,
                                                ),
                                              )),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              SelectableText(
                                                Provider.of<User>(context)
                                                    .full_name,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w800),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              SelectableText(
                                                Provider.of<User>(context)
                                                    .email,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white),
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Container(
                                                width: 80,
                                                decoration: BoxDecoration(
                                                    color: primaryColor1,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Container(
                                                  margin: EdgeInsets.all(2),
                                                  child: Center(
                                                    child: Text(
                                                      "VENDOR",
                                                      style: TextStyle(
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 180),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                FadeAnimation(
                                  2,
                                  InkWell(
                                    onTap: () => Navigator.pushNamed(
                                        context, '/cari_pemeriksaan'),
                                    child: Card(
                                      elevation: 3,
                                      child: Container(
                                        height: 150,
                                        width: 150,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            SizedBox(
                                                height: 50,
                                                width: 50,
                                                child: Image.asset(
                                                    checkPelanggan)),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text('Pemeliharaan AMR',
                                                style: TextStyle(
                                                    color: primaryColor1,
                                                    fontWeight:
                                                        FontWeight.w700)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                FadeAnimation(
                                  2,
                                  InkWell(
                                    onTap: () => Navigator.pushNamed(
                                        context, '/cari_pasang_baru'),
                                    child: Card(
                                      elevation: 3,
                                      child: Container(
                                        height: 150,
                                        width: 150,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            SizedBox(
                                                height: 50,
                                                width: 50,
                                                child:
                                                    Image.asset(addPelanggan)),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text('Pasang Baru AMR',
                                                style: TextStyle(
                                                    color: primaryColor1,
                                                    fontWeight:
                                                        FontWeight.w700)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      'PEMELIHARAAN AMR',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '5 Terbaru',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                model.state == ViewState.Busy
                    ? _shimmer(13.0, 50.0)
                    : Card(
                        child: Column(
                          children: getPemeliharaanUi(model.workOrder),
                        ),
                      ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      'PASANG BARU AMR',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '5 Terbaru',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                model.state == ViewState.Busy
                    ? _shimmer(13.0, 50.0)
                    : Card(
                        child: Column(
                          children: getPelangganBaruUi(model.workOrder),
                        ),
                      ),
              ],
            ),
          ),
        ),
        backgroundColor: cBgColor,
      ),
    );
  }

  List<Widget> getPemeliharaanUi(List<WorkOrder> workOrder) {
    var items = new List<Widget>();
    if (workOrder == null) {
      items.add(
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.description,
                color: Colors.grey[300],
                size: 50.0,
              ),
              Text(
                "No Data",
                style: TextStyle(color: Colors.grey[300], fontSize: 20),
              )
            ],
          ),
        ),
      );
    } else {
      for (var wo in workOrder) {
        if (wo.pemeliharaan.contains("Pemeliharaan AMR")) {
          items.add(new WoCard(
            workOrder: wo,
            title: "WO Pemeriksaan",
            onTap: () {
              print("NOMOR WO " + wo.nomorWO);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailWoPemeriksaanScreen(
                            workOrder: wo,
                            jenis: 4,
                          )));
            },
          ));
        }
      }
    }
    return items;
  }

  List<Widget> getPelangganBaruUi(List<WorkOrder> workOrder) {
    var items = new List<Widget>();
    if (workOrder == null) {
      items.add(
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.description,
                color: Colors.grey[300],
                size: 50.0,
              ),
              Text(
                "No Data",
                style: TextStyle(color: Colors.grey[300], fontSize: 20),
              )
            ],
          ),
        ),
      );
    } else {
      for (var wo in workOrder) {
        if (wo.pemeliharaan.contains("Pasang Baru AMR")) {
          items.add(new WoCard(
            workOrder: wo,
            title: "WO Pemasangan Baru",
            onTap: () {
              print("NOMOR WO " + wo.nomorWO);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailWoPemasanganScreen(
                            workOrder: wo,
                            jenis: 3,
                          )));
            },
          ));
        }
      }
    }
    return items;
  }
}
