import 'package:amr_apps/ui/home_dashboard.dart';
import 'package:amr_apps/ui/shared/color.dart';
import 'package:amr_apps/ui/shared/size.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class SignaturePemasanganPetugasScreen extends StatefulWidget {
  @override
  _SignaturePemasanganPetugasScreenState createState() => _SignaturePemasanganPetugasScreenState();
}

class _SignaturePemasanganPetugasScreenState extends State<SignaturePemasanganPetugasScreen> {




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
        Size(screenWidth(context), screenHeight(context, dividedBy: 8)),
        child: SafeArea(
            child: Container(
              color: primaryColor1,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 10, right: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Pemasangan',
                      style: TextStyle(color: colorWhite, fontSize: 22),
                    ),
                    Row(
                      children: <Widget>[
                        Text('AMR', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: colorWhite),),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(
                                  CommunityMaterialIcons.chevron_double_right,
                                  color: Colors.white,
                                ),
                                Text(
                                  'Pemasangan Pelanggan',
                                  style: TextStyle(color: colorWhite, fontSize: 14),
                                )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Icon(
                                  CommunityMaterialIcons.chevron_double_right,
                                  color: Colors.white,
                                ),
                                Text(
                                  'Tandatangan Petugas',
                                  style: TextStyle(color: colorWhite, fontSize: 14),
                                )
                              ],
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
color: cBgColor,
                    child: SizedBox(
//                        width: MediaQuery.of(context).size.width,
                        child: _signatureCanvas)),
              ),
              Positioned(
                right: 10,
                child:
              IconButton(
                icon: const Icon(Icons.clear),
                color: Colors.blue,
                onPressed: () {
                  setState(() {
                    return _signatureCanvas.clear();
                  });
                },
              ),)
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
                color: primaryColor2,
                child: Text('Simpan'),
                onPressed: (){
                  Navigator.pushNamed(context,'/');
                }),
          )
        ],
      ),
    );
  }

}