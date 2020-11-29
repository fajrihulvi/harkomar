import 'dart:async';

import 'package:amr_apps/core/enum/viewstate.dart';
import 'package:amr_apps/core/model/Berita_Acara.dart';
import 'package:amr_apps/core/model/HasilPemeriksaan.dart';
import 'package:amr_apps/core/model/TindakLanjut.dart';
import 'package:amr_apps/core/model/User.dart';
import 'package:amr_apps/core/viewmodel/pemasangan_kedua_model.dart';
import 'package:amr_apps/core/viewmodel/pemeriksaan_ketiga_model.dart';
import 'package:amr_apps/ui/base_view.dart';
import 'package:amr_apps/ui/shared/color.dart';
import 'package:amr_apps/ui/shared/size.dart';
import 'package:amr_apps/ui/signature_pemasangan_pelanggan_view.dart';
import 'package:amr_apps/ui/widget/HasilPemeriksaanTile.dart';
import 'package:amr_apps/ui/widget/TindakLanjutTile.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class PemasanganPelangganKeduaScreen extends StatefulWidget {
  final Berita_Acara beritaAcara;
  final Map<String,dynamic> result;
  final bool enableForm;
  const PemasanganPelangganKeduaScreen({this.beritaAcara,this.result,this.enableForm=true});

  @override
  _PemasanganPelangganKeduaScreenState createState() => _PemasanganPelangganKeduaScreenState();
}

class _PemasanganPelangganKeduaScreenState extends State<PemasanganPelangganKeduaScreen> {


  bool _isChecked = false;
  bool _isCheckedPasangBaruModem1Set = false;
  bool _modem = false;
  bool _powerSupply = false;
  bool _kabelData = false;
  bool _antena = false;
  
  final formKodesegel = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController 
  boxAppSblm = TextEditingController(),
  boxAppSsdh = TextEditingController(),
  kwhSblm = TextEditingController(),
  kwhSsdh = TextEditingController(),
  pembatasSblm = TextEditingController(),
  pembatasSsdh = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseView<PemasanganKeduaModel>(
    onModelReady: (model)=>model.getData(Provider.of<User>(context).token, this.widget.beritaAcara.id.toString()),
    builder : (context,model,child)=>
    Scaffold(
      key: _scaffoldKey,
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
                        Icon(
                          CommunityMaterialIcons.chevron_double_right,
                          color: Colors.white,
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Pemasangan Pelanggan',
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
      body:model.state == ViewState.Busy ?
      Center(child: CircularProgressIndicator()) : 
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Jenis Pekerjaan',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
              Card(
                child:
                Column(
                  children: this.getTileHasilPemeriksaan(model.hasilPemeriksaan),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text('Tindak Lanjut Pekerjaan',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
              Card(
                child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: this.getTindakLanjut(model.tindakLanjut)
                ),
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 10,),
                  Text('Kode Segel',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                  SizedBox(height: 20,),
                  Form(
                    key: this.formKodesegel,
                    child: this.getCardFormKodeSegel(model),
                  ),
            Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
        RaisedButton(
        color: primaryColor2,
            onPressed: (){
              return this.insert(model);
                  },
                        child: Text('Selanjutnya'),

                      )
                      ],
            )

                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
  List<Widget> getTileHasilPemeriksaan(List<HasilPemeriksaan> hasilPemeriksaan){
    var items = new List<Widget>();
      for (var hp in hasilPemeriksaan) {
        items.add(new HasilPemeriksaanTile(
            hasilPemeriksaan: hp,
            isChecked: hp.check == null || hp.check == 0 ? false : true,
            onTap: (bool isCheck){
              if(this.widget.enableForm){
                if(isCheck == true){
                  setState(() {
                    hp.check = 1;
                  });
                }
                else{
                  setState(() {
                    hp.check = 0;
                  });
                }
              }
            }
          )
        );
      }
    return items;
  }
  List<Widget> getTindakLanjut(List<TindakLanjut> tindakLanjut){
    var items = new List<Widget>();
      for (var tl in tindakLanjut) {
        items.add(new TindakLanjutTile(
            tindakLanjut: tl,
            isChecked: tl.check == null || tl.check == 0 ? false : true,
            onTap: (bool isCheck){
              if(this.widget.enableForm){
                if(isCheck == true){
                  setState(() {
                    tl.check = 1;
                  });
                }
                else{
                  setState(() {
                    tl.check = 0;
                  });
                }
              }
            }
          )
        );
      }
    return items;
  }
  Widget getCardFormKodeSegel(PemasanganKeduaModel model){
    if(model.kodeSegel !=null){
      this.boxAppSblm.text = model.kodeSegel.boxAppSblm;
      this.boxAppSsdh.text = model.kodeSegel.boxAppSsdh;
      this.kwhSblm.text = model.kodeSegel.kwhSblm;
      this.kwhSsdh.text = model.kodeSegel.kwhSsdh;
      this.pembatasSblm.text = model.kodeSegel.pembatasSblm;
      this.pembatasSsdh.text = model.kodeSegel.pembatasSsdh;
    }
    return Card(
                  child:
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Box App',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Sebelum Pemeriksan',
                          ),
                          initialValue: model.kodeSegel.boxAppSblm != null ? model.kodeSegel.boxAppSblm : "",
                          validator: (value){
                            if(value.isEmpty){
                              return "Data masih kosong";
                            }
                            setState(() {
                              this.boxAppSblm.text = value;
                              model.kodeSegel.boxAppSblm =  value;
                            });
                            return null;
                          },
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Sesudah Pemeriksan',
                          ),
                          initialValue: model.kodeSegel.boxAppSsdh != null ? model.kodeSegel.boxAppSsdh : "",
                          validator: (value){
                            if(value.isEmpty){
                              return "Data masih kosong";
                            }
                            setState(() {
                              this.boxAppSsdh.text = value;
                              model.kodeSegel.boxAppSsdh =  value;
                            });
                            return null;
                          },
                        ),
                        SizedBox(height: 20,),
                        Text('KWH Meter',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Sebelum Pemeriksan',
                          ),
                          initialValue: model.kodeSegel.kwhSblm != null ? model.kodeSegel.kwhSblm : "",
                          validator: (value){
                            if(value.isEmpty){
                              return "Data masih kosong";
                            }
                            setState(() {
                              this.kwhSblm.text = value;
                              model.kodeSegel.kwhSblm =  value;
                            });
                            return null;
                          },
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Sesudah Pemeriksan',
                          ),
                          initialValue: model.kodeSegel.kwhSsdh != null ? model.kodeSegel.kwhSsdh : "",
                          validator: (value){
                            if(value.isEmpty){
                              return "Data masih kosong";
                            }
                            setState(() {
                              this.kwhSsdh.text = value;
                              model.kodeSegel.kwhSsdh =  value;
                            });
                            return null;
                          },
                        ),
                        SizedBox(height: 20,),
                        Text('Pembatas',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Sebelum Pemeriksan',
                          ),
                          initialValue: model.kodeSegel.pembatasSblm != null ? model.kodeSegel.pembatasSblm : "",
                          validator: (value){
                            if(value.isEmpty){
                              return "Data masih kosong";
                            }
                            setState(() {
                              this.pembatasSblm.text = value;
                              model.kodeSegel.pembatasSblm =  value;
                            });
                            return null;
                          },
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Sesudah Pemeriksan',
                          ),
                          initialValue: model.kodeSegel.pembatasSsdh != null ? model.kodeSegel.pembatasSsdh : "",
                          validator: (value){
                            if(value.isEmpty){
                              return "Data masih kosong";
                            }
                            setState(() {
                              this.pembatasSsdh.text = value;
                              model.kodeSegel.pembatasSsdh =  value;
                            });
                            return null;
                          },
                        )

                      ],
                    ),
                  ),
                );
  }
  void insert(PemasanganKeduaModel model)async{
    if(this.widget.enableForm){
      if(this.formKodesegel.currentState.validate()){
      var map = Map<String,dynamic>();
      map['hasil_pemeriksaan_id'] = this.widget.beritaAcara.id.toString();
      map['boxapp_sebelum']= this.boxAppSblm.text;
      map['boxapp_sesudah']= this.boxAppSsdh.text;
      map['kwh_sebelum']= this.kwhSblm.text;
      map['kwh_sesudah']= this.kwhSsdh.text;
      map['pembatas_sebelum']= this.pembatasSblm.text;
      map['pembatas_sesudah']= this.pembatasSsdh.text;
      print(map);
      var result = await model.insertKodeSegel(Provider.of<User>(context).token , map);
      if(result['success']==false){
        _scaffoldKey.currentState.showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              duration: Duration(seconds: 1),
              content: Text(result['msg'])));
        return;   
      }
      var tindakLanjutId = new List();
      var tindakLanjutCheck = new List();
      var modem_id = new List();
      var sim_card_id = new List();
      var meter_id = new List();
      for(var a in model.tindakLanjut){
        tindakLanjutId.add(a.id);
        tindakLanjutCheck.add(a.check);
        modem_id.add(int.parse(this.widget.result['modem_id']));
        meter_id.add(int.parse(this.widget.result['meter_id']));
        sim_card_id.add(int.parse(this.widget.result['card_id']));
      }
      var hasilPemeriksaanId = List();
      var hasilPemeriksaanCheck = List();
      for(var a in model.hasilPemeriksaan){
        hasilPemeriksaanId.add(a.id);
        hasilPemeriksaanCheck.add(a.check);
      }
      var insertHasilPemeriksaan = await model.insert(
        Provider.of<User>(context).token ,this.widget.beritaAcara.id, 
        hasilPemeriksaanId,hasilPemeriksaanCheck,
        tindakLanjutId,tindakLanjutCheck,
        modem_id,meter_id,sim_card_id
      );
      if(insertHasilPemeriksaan['success']==false){

         return;
      }
      _scaffoldKey.currentState.showSnackBar(
           SnackBar(
             backgroundColor: Colors.green,
             duration: Duration(
               seconds: 1
               ),
               content: Text(result['msg']))
               );
               Timer(
                 Duration(
                   seconds: 3,
                   ),(){
                     Navigator.pushNamed(context, '/signaturePelanggan',arguments: widget.beritaAcara);
              }
      );
      }
    }
    else{
      Navigator.pushNamed(context, '/');
    }
          
  }
}
