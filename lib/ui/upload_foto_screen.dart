import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math' as Math;
import 'package:amr_apps/core/model/Berita_Acara.dart';
import 'package:amr_apps/core/model/Pelanggan.dart';
import 'package:amr_apps/core/model/User.dart';
import 'package:amr_apps/core/service/ApiSetting.dart';
import 'package:amr_apps/ui/base_view.dart';
import 'package:amr_apps/ui/shared/color.dart';
import 'package:amr_apps/ui/shared/size.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:image/image.dart' as Img;
import 'package:provider/provider.dart';
import 'package:amr_apps/core/viewmodel/signature_model.dart';
import 'package:http/http.dart' as http;

class UploadFotoScreen extends StatefulWidget {
  final Berita_Acara beritaAcara;
  final bool enableForm;
  final int pemeriksaanID;
  final int pelangganID;
  final List hasil_pemeriksaan;
  final List tindak_lanjut;
  final Pelanggan pelanggan;

  const UploadFotoScreen(
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
  _UploadFotoScreenState createState() => _UploadFotoScreenState();
}

class _UploadFotoScreenState extends State<UploadFotoScreen> {
  ProgressDialog pr;
  File _image;
  String base64;
  var dataImage = [];
  var dataImageBase64 = [];
  var jsonn = [];
  File data;

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

  Future _getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;

    Img.Image gambar = Img.decodeImage(image.readAsBytesSync());
    Img.Image smallGambar = Img.copyResize(gambar, width: 600);

    int random = new Math.Random().nextInt(1000000);
    var compress = new File("$path/image$random.jpg")
      ..writeAsBytesSync(Img.encodeJpg(smallGambar, quality: 95));
    setState(() {
      _image = compress;
      List<int> imageBytes = _image.readAsBytesSync();
      print(imageBytes);
      base64 = base64Encode(imageBytes);
      print("base64 $base64");
      dataImage.add(_image);
      dataImageBase64.add(base64);
      jsonn = dataImageBase64;
      print("imageJson ${json.encode(jsonn)}");
      for (int i = 0; i < dataImage.length; i++) {
        data = dataImage[i];
      }

      for (int i = 0; i < dataImageBase64.length; i++) {
        dataImageBase64[i];
        print("imagebase64 ${dataImageBase64[i]}");
      }
    });
  }

  Future<String> postFoto() async {
    final token = Provider.of<User>(context).token;
    pr = new ProgressDialog(context);
    pr.show();
    var apiSetting = new ApiSetting.initial();
    final responseLogin = await http.post(
      apiSetting.host + apiSetting.postfix + "/pelanggan/upload_foto",
      headers: {"Authorization": token, "Accept": "application/json"},
      body: {
        "id": widget.pelanggan.id.toString(),
        "foto": json.encode(jsonn),
      },
    );
    print("Respon : ${responseLogin.body}");
    var dataResponse = json.decode(responseLogin.body);
    Future.delayed(Duration(seconds: 1)).then((onValue) {
      if (pr.isShowing()) pr.hide();
      if (dataResponse["success"] == true) {
        pr.hide();
        _alertdialog(dataResponse['msg']);
        Navigator.pushNamed(context, '/signaturePelanggan', arguments: {
          "berita_acara": this.widget.beritaAcara,
          "result": null,
          "enableForm": this.widget.enableForm,
          "pelanggan": widget.pelanggan,
          "hasil_pemeriksaan": widget.hasil_pemeriksaan,
          "tindak_lanjut": widget.tindak_lanjut
        });
      } else {
        pr.hide();
        _alertdialog(dataResponse['msg']);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<SignatureModel>(
        builder: (context, model, child) => Scaffold(
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
                          'Upload Foto',
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
              body: formContent(context),
              floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
              floatingActionButton: FloatingActionButton(
                elevation: 3,
                onPressed: _getImage,
                tooltip: 'Ambil Image',
                child: Icon(Icons.add_a_photo, color: colorWhite),
                backgroundColor: Colors.teal[400],
              ),
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                    color: primaryColor1,
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
                      postFoto();
                    }),
              ),
            ));
  }

  Widget formContent(BuildContext context) {
    return _image == null
        ? Center(child: Text('No image selected.', style: TextStyle(fontSize: 16.0))) 
        : Container(
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: dataImage == null ? 0 : dataImage.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return Container(
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: <Widget>[
                        Image.file(
                          dataImage[index],
                          width: 200,
                        ),
                        Container(
                          color: primaryColor1.withOpacity(0.7),
                          height: 30,
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              "Gambar - ${index + 1}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'Regular'),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }),
          );
  }
}
