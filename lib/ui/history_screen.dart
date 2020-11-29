import 'dart:convert';
import 'package:amr_apps/core/model/Pelanggan.dart';
import 'package:amr_apps/core/model/User.dart';
import 'package:amr_apps/core/service/ApiSetting.dart';
import 'package:amr_apps/ui/base_view.dart';
import 'package:amr_apps/ui/shared/color.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:flushbar/flushbar.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:amr_apps/core/viewmodel/detail_pemasangan_model.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with TickerProviderStateMixin {
  List<Tab> tabList = List();
  TabController _tabController;

  ProgressDialog pr;

  bool pemerikasaan;
  var tgl_a, tgl_b;

  @override
  void initState() {
    super.initState();
    tabList.add(new Tab(
      text: 'Pemeriksaan',
    ));
    tabList.add(new Tab(
      text: 'Pasang Baru',
    ));
    _tabController = new TabController(vsync: this, length: tabList.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future getBA(String id) async {
    final token = Provider.of<User>(context).token;
    pr = new ProgressDialog(context);
    pr.show();
    var apiSetting = new ApiSetting.initial();
    final responseLogin = await http.post(
      apiSetting.host + apiSetting.postfix + "/berita_acara/download",
      headers: {"Authorization": token, "Accept": "application/json"},
      body: {
        "id_pel": id,
      },
    );
    print("Respon : ${responseLogin.body}");
    var dataResponse = json.decode(responseLogin.body);

    if (dataResponse["success"] == true) {
      pr.hide();
      launch(dataResponse["link"]);
    } else {
      pr.hide();
      Flushbar(
        icon: Icon(Icons.info, color: colorWhite),
        title: "Informasi",
        message: "Gagal download berita acara.",
        duration: Duration(seconds: 3),
      ).show(context);
    }
  }

  void _alertdialog(String str, String id) {
    if (str.isEmpty) return;
    AlertDialog alertDialog = new AlertDialog(
      elevation: 5,
      title: new Text(
        "Informasi",
        style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
      ),
      content: new Text(
        str,
        style: new TextStyle(fontSize: 16.0),
      ),
      actions: <Widget>[
        new RaisedButton(
          color: Colors.grey[200],
          child: new Text("Batal"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        new RaisedButton(
          color: primaryColor1,
          child: new Text("Download", style: TextStyle(color: colorWhite)),
          onPressed: () {
            getBA(id);
          },
        ),
      ],
    );

    showDialog(context: context, child: alertDialog);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: cBgColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: primaryColor1,
          title: Text(
            'History Pekerjaan',
            style: TextStyle(color: colorWhite),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search, color: Colors.white),
              onPressed: (){
               Navigator.pushNamed(context, '/search_history');
              },
            )
          ],
          bottom: TabBar(
              labelColor: Colors.white,
              controller: _tabController,
              indicatorColor: primaryColor2,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: tabList),
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            ///Pemeliharaan AMR
            Container(
                padding: const EdgeInsets.all(8.0),
                child: BaseView<DetailPemasanganModel>(
                  onModelReady: (model) => model.pelangganByWO(
                    Provider.of<User>(context).token,
                    4,
                  ),
                  builder: (context, model, child) => ListView(
                      scrollDirection: Axis.vertical,
                      children: this
                          .historyCard(model.pelanggan, "Pemeliharaan AMR")),
                )),

            ///Pemasangan AMR
            Container(
                padding: const EdgeInsets.all(8.0),
                child: BaseView<DetailPemasanganModel>(
                  onModelReady: (model) => model.pelangganByWO(
                    Provider.of<User>(context).token,
                    3,
                  ),
                  builder: (context, model, child) => ListView(
                      scrollDirection: Axis.vertical,
                      children:
                          this.historyCard(model.pelanggan, "Pasang Baru AMR")),
                )),
          ],
        ));
  }

  List<Widget> historyCard(
      List<Pelanggan> pelanggan, String jenisPemeliharaan) {
    var items = new List<Widget>();
    if (pelanggan == null) {
      items.add(Container(
        margin: EdgeInsets.all(8.0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 1.7,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.description,
                color: Colors.grey[300],
                size: 70.0,
              ),
              Text(
                "Tidak Ada Data",
                style: TextStyle(color: Colors.grey[300], fontSize: 20),
              )
            ],
          ),
        ),
      ));
      return items;
    }
    for (var ba in pelanggan) {
      items.add(this.card(ba, jenisPemeliharaan));
    }
    return items;
  }

  Widget card(Pelanggan pelanggan, String jenisPemeliharaan) {
    return InkWell(
      onTap: () {
        (pelanggan.status_wo == "0")
            ? Navigator.pushNamed(context, '/detail_pemeriksaan/first',
                arguments: pelanggan)
            : _alertdialog("Apakah anda yakin download Berita Acara ?",
                pelanggan.id.toString());
      },
      child: Card(
        elevation: 3,
        child: Container(
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.only(left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 12),
                  Text(pelanggan.nomorWO,
                      style: TextStyle(
                          color: primaryColor1b,
                          fontSize: 14,
                          fontWeight: FontWeight.w700)),
                  SizedBox(height: 10),
                  Text(pelanggan.namaPelanggan,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  SizedBox(height: 5),
                  Text(pelanggan.idPel,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  SizedBox(height: 5),
                  Text(pelanggan.alamat,
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  (pelanggan.status_wo == "0")
                      ? Text(
                          "Belum",
                          style: TextStyle(
                              color: Colors.amber[700],
                              fontWeight: FontWeight.w700),
                        )
                      : Text(
                          "Selesai",
                          style: TextStyle(
                              color: primaryColor1,
                              fontWeight: FontWeight.w700),
                        ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
