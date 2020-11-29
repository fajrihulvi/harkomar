import 'dart:async';
import 'dart:typed_data';

import 'package:amr_apps/core/model/Berita_Acara.dart';
import 'package:amr_apps/core/model/Pelanggan.dart';
import 'package:amr_apps/core/model/User.dart';
import 'package:amr_apps/core/viewmodel/signature_model.dart';
import 'package:amr_apps/ui/base_view.dart';
import 'package:amr_apps/ui/shared/color.dart';
import 'package:amr_apps/ui/shared/size.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signature/signature.dart';
import 'package:progress_dialog/progress_dialog.dart';

class SignaturePetugasScreen extends StatefulWidget {
  final Uint8List signaturePelanggan;
  final Berita_Acara beritaacara;
  final List hasil_pemeriksaan;
  final List tindak_lanjut;
  final Pelanggan pelanggan;
  final bool enableForm;

  const SignaturePetugasScreen(
      {this.signaturePelanggan,
      this.beritaacara,
      this.hasil_pemeriksaan,
      this.tindak_lanjut,
      this.pelanggan,
      this.enableForm = true});
  @override
  _SignaturePetugasScreenState createState() => _SignaturePetugasScreenState();
}

class _SignaturePetugasScreenState extends State<SignaturePetugasScreen> {
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
    var _signatureCanvas = Signature(
      height: 250,
      width: MediaQuery.of(context).size.width / 1.2,
      backgroundColor: cBgColor,
      onChanged: (points) {
        print(points);
      },
    );
    return BaseView<SignatureModel>(
        builder: (context, model, child) => Scaffold(
              key: _scaffoldKey,
              backgroundColor: colorWhite,
              appBar: PreferredSize(
                preferredSize: Size(
                    screenWidth(context), screenHeight(context, dividedBy: 7)),
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
                          'Tanda Tangan Petugas',
                          style: TextStyle(color: colorWhite, fontSize: 22),
                        ),
                      ],
                    ),
                  ),
                )),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                            elevation: 3,
                            color: cBgColor,
                            child: SizedBox(
//                        width: MediaQuery.of(context).size.width,
                                child: _signatureCanvas)),
                      ),
                    ],
                  ),
                ],
              ),
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                        color: Colors.grey[300],
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.refresh,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Ulangi',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                        onPressed: () async {
                          setState(() {
                            return _signatureCanvas.clear();
                          });
                        }),
                    RaisedButton(
                        color: primaryColor2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.save,
                              color: colorWhite,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Simpan',
                              style: TextStyle(color: colorWhite),
                            ),
                          ],
                        ),
                        onPressed: () async {
                          pr = new ProgressDialog(
                            context,
                            type: ProgressDialogType.Normal,
                          );
                          pr.show();
                          var ttdPetugas = await _signatureCanvas.exportBytes();
                          var ttdPelanggan = this.widget.signaturePelanggan;
                          var result = await model.updateSignature(
                            Provider.of<User>(context).token,
                            ttdPetugas,
                            ttdPelanggan,
                            widget.tindak_lanjut,
                            widget.hasil_pemeriksaan,
                            widget.pelanggan.id,
                            widget.pelanggan.woID,
                            Provider.of<User>(context).id,
                          );
                          if (result['success'] == true) {
                             pr.hide();
                            print(result['msg']);
                            _alertdialog("Pemeriksaan Pelanggan Selesai. Terimakasih.");
                            Timer(
                                Duration(
                                  seconds: 3,
                                ), () {
                              Navigator.pushNamed(context, '/');
                            });
                          } else {
                            pr.hide();
                            _alertdialog(result['msg']);
                          }
                        }),
                  ],
                ),
              ),
            ));
  }
}
