import 'dart:convert';
import 'package:flushbar/flushbar.dart';
import 'package:http/http.dart' as http;
import 'package:amr_apps/core/enum/viewstate.dart';
import 'package:amr_apps/core/model/User.dart';
import 'package:amr_apps/core/service/ApiSetting.dart';
import 'package:amr_apps/core/viewmodel/cari_data.dart';
import 'package:amr_apps/ui/shared/color.dart';
import 'package:amr_apps/ui/shared/size.dart';
import 'package:flutter/material.dart';
import 'package:amr_apps/core/model/Pelanggan.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _tglawal = TextEditingController();
  TextEditingController _tglakhir = TextEditingController();

  Widget body = Container(
    child: Text("Silahkan Cari Data"),
  );
  CariDataModel model = new CariDataModel();
  ProgressDialog pr;

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

  String _month(month) {
    switch (month) {
      case 1:
        month = "01";
        break;
      case 2:
        month = "02";
        break;
      case 3:
        month = "03";
        break;
      case 4:
        month = "04";
        break;
      case 5:
        month = "05";
        break;
      case 6:
        month = "06";
        break;
      case 7:
        month = "07";
        break;
      case 8:
        month = "08";
        break;
      case 9:
        month = "09";
        break;
      case 10:
        month = "10";
        break;
      case 11:
        month = "11";
        break;
      case 12:
        month = "12";
        break;
    }
    return month;
  }

  Widget _datePicker(String str) {
    showDatePicker(
      initialDatePickerMode: DatePickerMode.day,
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2300),
    ).then((data) {
      setState(() {
        String month;
        month = _month(data.month);
        String dateSlug =
            "${data.day.toString()}-${month.toString()}-${data.year.toString().padLeft(2, '0')}";
        if (str == "awal") {
          _tglawal.text = dateSlug;
        } else {
          _tglakhir.text = dateSlug;
        }
      });
    });
  }

  void setBody(BuildContext context, String tglAwal, String tglAkhir) async {
    await model.getData(Provider.of<User>(context).token, tglAwal, tglAkhir);
    setState(() {
      this.body = (model.state == ViewState.Busy)
          ? Center(child: CircularProgressIndicator())
          : Container(
          child: Column(
            children: this.getData(model.pelanggan),
          ),
        );
    });
  }

  List<Widget> getData(List<Pelanggan> pelanggan) {
    var items = new List<Widget>();
    if (pelanggan == null) {
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
                "Tidak Ada Data",
                style: TextStyle(color: Colors.grey[300], fontSize: 20),
              )
            ],
          ),
        ),
      );
      return items;
    } else {
      items.add(Column(
        children: <Widget>[
          Text("${pelanggan.length} Data Ditemukan", style: TextStyle(fontWeight: FontWeight.w700)),
          Divider(
            color: Colors.grey[200],
          )
        ],
      ));
      for (var pel in pelanggan) {
        items.add(this.getSingleUserBar(pel));
      }
      if (items.length == 0) {
        items.add(Center(
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
        ));
      }
    }
    return items;
  }

  Widget getSingleUserBar(Pelanggan pelanggan) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size(screenWidth(context), screenHeight(context, dividedBy: 11)),
        child: SafeArea(
            child: Container(
          color: primaryColor2,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 10, right: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 25.0,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Cari Data History",
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        )),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _tglawal,
                decoration: InputDecoration(
                  labelText: "Tanggal Awal",
                  hintText: "yyyy-mm-dd",
                  prefixIcon: Icon(Icons.calendar_today),
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                ),
                onTap: () {
                  _datePicker('awal');
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                controller: _tglakhir,
                decoration: InputDecoration(
                  labelText: "Tanggal Akhir",
                  hintText: "yyyy-mm-dd",
                  prefixIcon: Icon(Icons.calendar_today),
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                ),
                onTap: () {
                  _datePicker('akhir');
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                  padding: const EdgeInsets.all(8.0),
                  textColor: Colors.white,
                  color: primaryColor2,
                  onPressed: () {
                    setState(() {
                      setBody(context, _tglawal.text, _tglakhir.text);
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.search),
                      Text("Cari Data"),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              this.body,
            ],
          ),
        ),
      ),
    );
  }
}
