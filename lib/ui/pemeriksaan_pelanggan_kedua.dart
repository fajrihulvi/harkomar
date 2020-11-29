import 'dart:async';

import 'package:amr_apps/core/enum/viewstate.dart';
import 'package:amr_apps/core/model/Berita_Acara.dart';
import 'package:amr_apps/core/model/Pelanggan.dart';
import 'package:amr_apps/core/model/User.dart';
import 'package:amr_apps/core/viewmodel/arus_model.dart';
import 'package:amr_apps/core/viewmodel/pemeriksaan_kedua.model.dart';
import 'package:amr_apps/core/viewmodel/stand_meter_model.dart';
import 'package:amr_apps/core/viewmodel/tegangan_model.dart';
import 'package:amr_apps/ui/base_view.dart';
import 'package:amr_apps/ui/shared/color.dart';
import 'package:amr_apps/ui/shared/size.dart';
import 'package:amr_apps/ui/widget/form_arus.dart';
import 'package:amr_apps/ui/widget/form_stand_meter.dart';
import 'package:amr_apps/ui/widget/form_tegangan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:progress_dialog/progress_dialog.dart';

class PemeriksaanPelangganKeduaScreen extends StatefulWidget {
  final int pemeriksaanID;
  final int pelangganID;
  final Berita_Acara beritaAcara;
  final bool enableForm;
  final List hasil_pemeriksaan;
  final List tindak_lanjut;
  final Pelanggan pelanggan;
  
  const PemeriksaanPelangganKeduaScreen(
      {this.pemeriksaanID,
      this.pelangganID,
      this.beritaAcara,
      this.hasil_pemeriksaan,
      this.tindak_lanjut,
      this.pelanggan,
      this.enableForm = true});

  @override
  _PemeriksaanPelangganKeduaScreenState createState() =>
      _PemeriksaanPelangganKeduaScreenState();
}

class _PemeriksaanPelangganKeduaScreenState
    extends State<PemeriksaanPelangganKeduaScreen> {
  TextEditingController ls = new TextEditingController(),
      lr = TextEditingController(),
      lt = TextEditingController(),
      vt = TextEditingController(),
      vr = TextEditingController(),
      vs = TextEditingController(),
      lwbp = TextEditingController(),
      wbp = TextEditingController(),
      kvarh = TextEditingController(),
      noImei = TextEditingController(),
      tipeModem = TextEditingController(),
      merkModem = TextEditingController(),
      noSeri = TextEditingController(),
      tipeMeter = TextEditingController(),
      merkMeter = TextEditingController(),
      noSim = TextEditingController();
  final formArus = GlobalKey<FormState>();
  final formTegangan = GlobalKey<FormState>();
  final formStandMeter = GlobalKey<FormState>();
  final formMeter = GlobalKey<FormState>();
  final formModem = GlobalKey<FormState>();
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
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
    return BaseView<PemeriksaanKeduaModel>(
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
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Stand Meter',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        BaseView<StandMeterModel>(
                          onModelReady: (modelStandMeter) =>
                              modelStandMeter.getStandMeterByBA(
                                  Provider.of<User>(context).token,
                                  this.widget.pemeriksaanID.toString()),
                          builder: (context, modelStandMeter, child) =>
                              modelStandMeter.state == ViewState.Busy
                                  ? Center(child: CircularProgressIndicator())
                                  : Form(
                                      key: this.formStandMeter,
                                      child: FormStandMeter(
                                        enableEdit: this.widget.enableForm,
                                        lwbp: this.lwbp,
                                        wbp: this.wbp,
                                        kvarh: this.kvarh,
                                        pemeriksaanID:
                                            modelStandMeter.standMeter.baID,
                                        standMeter: modelStandMeter.standMeter,
                                      ),
                                    ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Tegangan (V)',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        BaseView<TeganganModel>(
                          onModelReady: (modelTegangan) =>
                              modelTegangan.getTeganganByBA(
                                  Provider.of<User>(context).token,
                                  this.widget.pemeriksaanID.toString()),
                          builder: (context, modelTegangan, child) =>
                              modelTegangan.state == ViewState.Busy
                                  ? Center(child: CircularProgressIndicator())
                                  : Form(
                                      key: this.formTegangan,
                                      child: FormTegangan(
                                        enableEdit: this.widget.enableForm,
                                        vr: this.vr,
                                        vs: this.vs,
                                        vt: this.vt,
                                        pemeriksaanID:
                                            modelTegangan.tegangan.baID,
                                        tegangan: modelTegangan.tegangan,
                                      ),
                                    ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Arus (A)',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        BaseView<ArusModel>(
                          onModelReady: (modelArus) => modelArus.getArusByBA(
                              Provider.of<User>(context).token,
                              this.widget.pemeriksaanID.toString()),
                          builder: (context, modelArus, child) =>
                              modelArus.state == ViewState.Busy
                                  ? Center(child: CircularProgressIndicator())
                                  : Form(
                                      key: this.formArus,
                                      child: FormArus(
                                        enableEdit: this.widget.enableForm,
                                        lr: this.lr,
                                        ls: this.ls,
                                        lt: this.lt,
                                        pemeriksaanID: modelArus.arus.baID,
                                        arus: modelArus.arus,
                                      ),
                                    ),
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
                                          .formTegangan
                                          .currentState
                                          .validate() &&
                                      this.formArus.currentState.validate() &&
                                      this
                                          .formStandMeter
                                          .currentState
                                          .validate()) {
                                    Map<String, dynamic> result =
                                        await model.insertAll(
                                      Provider.of<User>(context).token,
                                      {
                                        "nilai_vs": this.vs.text.toString(),
                                        "nilai_vr": this.vr.text.toString(),
                                        "nilai_vt": this.vt.text.toString(),
                                        "hasil_pemeriksaan_id": this.widget.pelanggan.id.toString(),
                                      },
                                      {
                                        "nilai_ls": this.ls.text.toString(),
                                        "nilai_lr": this.lr.text.toString(),
                                        "nilai_lt": this.lt.text.toString(),
                                        "hasil_pemeriksaan_id": this.widget.pelanggan.id.toString(),
                                      },
                                      {
                                        "nilai_lwbp": this.lwbp.text.toString(),
                                        "nilai_wbp": this.wbp.text.toString(),
                                        "nilai_kvarh": this.kvarh.text.toString(),
                                        "hasil_pemeriksaan_id": this.widget.pelanggan.id.toString(),
                                      },
                                    );
                                    if (result['success'] == true) {
                                      pr.hide();
                                      _alertdialog(result['msg']);
                                      Timer(
                                          Duration(
                                            seconds: 3,
                                          ), () {
                                        Navigator.pushNamed(context,
                                            '/detail_pemeriksaan/third',
                                            arguments: {
                                              "berita_acara":
                                                  this.widget.beritaAcara,
                                              "hasil_pemeriksaan":
                                                  widget.hasil_pemeriksaan,
                                              "tindak_lanjut":
                                                  widget.tindak_lanjut,
                                              "pelanggan": widget.pelanggan
                                            });
                                      });
                                    } else {
                                      pr.hide();
                                      _alertdialog(result['msg']);
                                    }
                                  }
                                } else {
                                  pr.hide();
                                  Navigator.pushNamed(
                                      context, '/view/detail_pemeriksaan/third',
                                      arguments: {
                                        "berita_acara": this.widget.beritaAcara,
                                        "result": null,
                                        "enableForm": this.widget.enableForm
                                      });
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
}
