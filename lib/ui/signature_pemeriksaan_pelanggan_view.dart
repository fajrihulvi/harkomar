import 'package:amr_apps/core/model/Berita_Acara.dart';
import 'package:amr_apps/core/model/Pelanggan.dart';
import 'package:amr_apps/ui/shared/color.dart';
import 'package:amr_apps/ui/shared/size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';
import 'package:progress_dialog/progress_dialog.dart';

class SignatureView extends StatefulWidget {
  final Berita_Acara beritaacara;
  final List hasil_pemeriksaan;
  final List tindak_lanjut;
  final Pelanggan pelanggan;
  final bool enableForm;

  const SignatureView(
      {this.beritaacara,
      this.hasil_pemeriksaan,
      this.tindak_lanjut,
      this.pelanggan,
      this.enableForm = true});

  @override
  _SignatureViewState createState() => _SignatureViewState();
}

class _SignatureViewState extends State<SignatureView> {
  ProgressDialog pr;

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

    // TODO: implement build
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: PreferredSize(
        preferredSize:
            Size(screenWidth(context), screenHeight(context, dividedBy: 7)),
        child: SafeArea(
            child: Container(
          color: primaryColor1,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 10, right: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Tanda Tangan Pelanggan',
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
                          style: TextStyle(color: colorWhite, fontSize: 14),
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
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
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
                          // height: MediaQuery.of(context).size.height,
                          child: _signatureCanvas)),
                ),
              ],
            ),
          ],
        ),
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
                  var signaturePelanggan = await _signatureCanvas.exportBytes();
                  print(
                      "Signature Pelanggan :" + signaturePelanggan.toString());
                  if (signaturePelanggan != null) {
                    pr.hide();
                    Navigator.pushNamed(context, '/signaturePetugas',
                        arguments: {
                          "berita_acara": this.widget.beritaacara,
                          "signature_pelanggan": signaturePelanggan,
                          "enableForm": this.widget.enableForm,
                          "pelanggan": widget.pelanggan,
                          "hasil_pemeriksaan": widget.hasil_pemeriksaan,
                          "tindak_lanjut": widget.tindak_lanjut
                        });
                  }
                }),
          ],
        ),
      ),
    );
  }

//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      home: Builder(
//        builder: (context) => Scaffold(
//          body: Column(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              //SIGNATURE CANVAS
//              _signatureCanvas,
//              //OK AND CLEAR BUTTONS
//              Container(
//                  decoration: const BoxDecoration(
//                    color: Colors.black,
//                  ),
//                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                    mainAxisSize: MainAxisSize.max,
//                    children: <Widget>[
//                      //SHOW EXPORTED IMAGE IN NEW ROUTE
//                      IconButton(
//                        icon: const Icon(Icons.check),
//                        color: Colors.blue,
//                        onPressed: () async {
//                          if (_signatureCanvas.isNotEmpty) {
//                            var data = await _signatureCanvas.exportBytes();
//                            Navigator.of(context).push(
//                              MaterialPageRoute(
//                                builder: (BuildContext context) {
//                                  return Scaffold(
//                                    appBar: AppBar(),
//                                    body: Container(
//                                      color: Colors.grey[300],
//                                      child: Image.memory(data),
//                                    ),
//                                  );
//                                },
//                              ),
//                            );
//                          }
//                        },
//                      ),
//                      //CLEAR CANVAS
//                      IconButton(
//                        icon: const Icon(Icons.clear),
//                        color: Colors.blue,
//                        onPressed: () {
//                          setState(() {
//                            return _signatureCanvas.clear();
//                          });
//                        },
//                      ),
//                    ],
//                  )),
//            ],
//          ),
//        ),
//      ),
//    );
//  }
}
