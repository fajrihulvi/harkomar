import 'dart:async';

import 'package:amr_apps/core/enum/viewstate.dart';
import 'package:amr_apps/core/model/Berita_Acara.dart';
import 'package:amr_apps/core/model/Pelanggan.dart';
import 'package:amr_apps/core/model/User.dart';
import 'package:amr_apps/core/viewmodel/pemeriksaan_ketiga_model.dart';
import 'package:amr_apps/ui/base_view.dart';
import 'package:amr_apps/ui/shared/color.dart';
import 'package:amr_apps/ui/shared/size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:progress_dialog/progress_dialog.dart';

class PemeriksaanPelangganKetigaScreen extends StatefulWidget {
  final Berita_Acara beritaAcara;
  final bool enableForm;
  final int pemeriksaanID;
  final int pelangganID;
  final List hasil_pemeriksaan;
  final List tindak_lanjut;
  final Pelanggan pelanggan;
  const PemeriksaanPelangganKetigaScreen(
      {Key key,
      this.beritaAcara,
      this.enableForm = true,
      this.pemeriksaanID,
      this.pelangganID,
      this.hasil_pemeriksaan,
      this.tindak_lanjut,
      this.pelanggan})
      : super(key: key);

  @override
  _PemeriksaanPelangganKetigaScreenState createState() =>
      _PemeriksaanPelangganKetigaScreenState();
}

class _PemeriksaanPelangganKetigaScreenState
    extends State<PemeriksaanPelangganKetigaScreen> {
  final formKodesegel = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController boxAppSblm = TextEditingController(),
      boxAppSsdh = TextEditingController(),
      kwhSblm = TextEditingController(),
      kwhSsdh = TextEditingController(),
      pembatasSblm = TextEditingController(),
      pembatasSsdh = TextEditingController();

  ProgressDialog pr;
  void _alertdialog(String str) {
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
          color: primaryColor2,
          child: new Text("OK"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );

    showDialog(context: context, child: alertDialog);
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<PemeriksaanKetigaModel>(
        onModelReady: (model) => model.getKodeSegel(
            Provider.of<User>(context).token,
            this.widget.pemeriksaanID.toString()),
        builder: (context, model, child) => SafeArea(
              child: Scaffold(
                key: _scaffoldKey,
                resizeToAvoidBottomPadding: true,
                backgroundColor: cBgColor,
                appBar: PreferredSize(
                  preferredSize: Size(screenWidth(context),
                      screenHeight(context, dividedBy: 8)),
                  child: SafeArea(
                      child: Container(
                    color: primaryColor1,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 8.0, top: 10, right: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Pemeriksaan Lanjutan',
                            style: TextStyle(color: colorWhite, fontSize: 22),
                          ),
                          Row(
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    widget.pelanggan.namaPelanggan +
                                        ' - ' +
                                        widget.pelanggan.idPel,
                                    style: TextStyle(
                                        color: colorWhite, fontSize: 14),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )),
                ),
                body: model.state == ViewState.Busy
                    ? Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Kode Segel',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Form(
                                key: this.formKodesegel,
                                child: this.getCardFormKodeSegel(model),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  RaisedButton(
                                    color: primaryColor2,
                                    onPressed: () async {
                                      pr = new ProgressDialog(
                                        context,
                                        type: ProgressDialogType.Normal,
                                      );
                                      pr.show();

                                      if (this.widget.enableForm) {
                                        if (this
                                            .formKodesegel
                                            .currentState
                                            .validate()) {
                                          var map = Map<String, dynamic>();
                                          map['hasil_pemeriksaan_id'] = this
                                              .widget
                                              .pelangganID
                                              .toString();
                                          map['boxapp_sebelum'] =
                                              this.boxAppSblm.text.toString();
                                          map['boxapp_sesudah'] =
                                              this.boxAppSsdh.text.toString();
                                          map['kwh_sebelum'] =
                                              this.kwhSblm.text.toString();
                                          map['kwh_sesudah'] =
                                              this.kwhSsdh.text.toString();
                                          map['pembatas_sebelum'] =
                                              this.pembatasSblm.text.toString();
                                          map['pembatas_sesudah'] =
                                              this.pembatasSsdh.text.toString();
                                          print(map);
                                          var result = await model.insert(
                                              Provider.of<User>(context).token,
                                              map);
                                          if (result['success'] == true) {
                                            pr.hide();
                                            print(result['msg']);
                                            _alertdialog(result['msg']);
                                            Timer(
                                                Duration(
                                                  seconds: 3,
                                                ), () {
                                              Navigator.pushNamed(context,
                                                  '/upload_foto',
                                                  arguments: {
                                                    "pelanggan":
                                                        widget.pelanggan,
                                                  });
                                             
                                            });
                                          } else {
                                            pr.hide();
                                            _alertdialog(result['msg']);
                                          }
                                        }
                                      } else {
                                        pr.hide();
                                        Navigator.pushNamed(context, '/');
                                      }
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          'Selanjutnya',
                                          style: TextStyle(color: colorWhite),
                                        ),
                                        Icon(
                                          Icons.chevron_right,
                                          color: colorWhite,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
              ),
            ));
  }

  Widget getCardFormKodeSegel(PemeriksaanKetigaModel model) {
    this.boxAppSblm.text = model.kodeSegel.boxAppSblm;
    this.boxAppSsdh.text = model.kodeSegel.boxAppSsdh;
    this.kwhSblm.text = model.kodeSegel.kwhSblm;
    this.kwhSsdh.text = model.kodeSegel.kwhSsdh;
    this.pembatasSblm.text = model.kodeSegel.pembatasSblm;
    this.pembatasSsdh.text = model.kodeSegel.pembatasSsdh;
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Box App',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            TextFormField(
              enabled: this.widget.enableForm,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Sebelum Pemeriksaan',
              ),
              initialValue: model.kodeSegel.boxAppSblm,
              validator: (value) {
                if (value.isEmpty) {
                  return "Data masih kosong";
                }
                setState(() {
                  this.boxAppSblm.text = value;
                  model.kodeSegel.boxAppSblm = value;
                });
                return null;
              },
            ),
            TextFormField(
              enabled: this.widget.enableForm,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Sesudah Pemeriksaan',
              ),
              initialValue: model.kodeSegel.boxAppSsdh,
              validator: (value) {
                if (value.isEmpty) {
                  return "Data masih kosong";
                }
                setState(() {
                  this.boxAppSsdh.text = value;
                  model.kodeSegel.boxAppSsdh = value;
                });
                return null;
              },
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'KWH Meter',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            TextFormField(
              enabled: this.widget.enableForm,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Sebelum Pemeriksaan',
              ),
              initialValue: model.kodeSegel.kwhSblm,
              validator: (value) {
                if (value.isEmpty) {
                  return "Data masih kosong";
                }
                setState(() {
                  this.kwhSblm.text = value;
                  model.kodeSegel.kwhSblm = value;
                });
                return null;
              },
            ),
            TextFormField(
              enabled: this.widget.enableForm,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Sesudah Pemeriksaan',
              ),
              initialValue: model.kodeSegel.kwhSsdh,
              validator: (value) {
                if (value.isEmpty) {
                  return "Data masih kosong";
                }
                setState(() {
                  this.kwhSsdh.text = value;
                  model.kodeSegel.kwhSsdh = value;
                });
                return null;
              },
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Pembatas',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            TextFormField(
              enabled: this.widget.enableForm,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Sebelum Pemeriksaan',
              ),
              initialValue: model.kodeSegel.pembatasSblm,
              validator: (value) {
                if (value.isEmpty) {
                  return "Data masih kosong";
                }
                setState(() {
                  this.pembatasSblm.text = value;
                  model.kodeSegel.pembatasSblm = value;
                });
                return null;
              },
            ),
            TextFormField(
              enabled: this.widget.enableForm,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Sesudah Pemeriksaan',
              ),
              initialValue: model.kodeSegel.pembatasSsdh,
              validator: (value) {
                if (value.isEmpty) {
                  return "Data masih kosong";
                }
                setState(() {
                  this.pembatasSsdh.text = value;
                  model.kodeSegel.pembatasSsdh = value;
                });
                return null;
              },
            )
          ],
        ),
      ),
    );
  }
}
