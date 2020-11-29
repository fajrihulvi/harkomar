import 'dart:async';

import 'package:amr_apps/core/enum/viewstate.dart';
import 'package:amr_apps/core/model/Berita_Acara.dart';
import 'package:amr_apps/core/model/Modem.dart';
import 'package:amr_apps/core/model/SimCard.dart';
import 'package:amr_apps/core/model/TindakLanjut.dart';
import 'package:amr_apps/core/model/User.dart';
import 'package:amr_apps/core/viewmodel/tindak_lanjut_model.dart';
import 'package:amr_apps/ui/base_view.dart';
import 'package:amr_apps/ui/shared/color.dart';
import 'package:amr_apps/ui/shared/size.dart';
import 'package:amr_apps/ui/widget/TindakLanjutTile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:amr_apps/core/model/Pelanggan.dart';
import 'package:progress_dialog/progress_dialog.dart';

class TindakLanjutScreen extends StatefulWidget {
  final int pelangganID;
  final int baID;
  final Berita_Acara beritaAcara;
  final Map<String, dynamic> result;
  final bool enableForm;
  final List<dynamic> hasil_pemeriksaan;
  final Pelanggan pelanggan;
  const TindakLanjutScreen(
      {this.pelangganID,
      this.pelanggan,
      this.hasil_pemeriksaan,
      this.baID,
      this.beritaAcara,
      this.result,
      this.enableForm = true});

  @override
  _TindakLanjutScreenState createState() => _TindakLanjutScreenState();
}

class _TindakLanjutScreenState extends State<TindakLanjutScreen> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController simCard = new TextEditingController();
  TextEditingController modem = new TextEditingController();
  List<Modem> listModem;
  List<SimCard> listsimCard;
  bool simCardVisible = false;
  bool modemVisible = false;
  int modemId;
  int simCardId;

  ProgressDialog pr;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listModem = new List<Modem>();
    listsimCard = new List<SimCard>();
  }

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
    return BaseView<TindakLanjutModel>(
        onModelReady: (model) => model.getPemeliharaan(
            Provider.of<User>(context).token,
            this.widget.beritaAcara == null
                ? ""
                : this.widget.beritaAcara.id.toString(),
            this.widget.pelanggan.pemeliharaanID,
            this.widget.pelanggan.pemeliharaanID),
        builder: (context, model, child) => Scaffold(
              key: _scaffoldKey,
              backgroundColor: cBgColor,
              appBar: PreferredSize(
                preferredSize: Size(
                    screenWidth(context), screenHeight(context, dividedBy: 8)),
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
                          'Tindak Lanjut',
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 20,
                            ),
                            Card(
                              elevation: 3,
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    'Tindak Lanjut Pemeriksaan',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: this.getTindakLanjut(
                                          model.tindakLanjut, model)),
                                ],
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
                                      var tindakLanjutId = new List();
                                      var tindakLanjutCheck = new List();
                                      var modem_id = new List();
                                      var sim_card_id = new List();
                                      var meter_id = new List();
                                      for (var a in model.tindakLanjut) {
                                        tindakLanjutId.add(a.id);
                                        tindakLanjutCheck.add(a.check);
                                        if (this.simCardId == null) {
                                          sim_card_id.add(int.parse(this
                                              .widget
                                              .pelanggan
                                              .simCardID
                                              .toString()));
                                        } else {
                                          sim_card_id.add(this.simCardId);
                                        }
                                        if (this.modemId == null) {
                                          modem_id.add(int.parse(this
                                              .widget
                                              .pelanggan
                                              .modemID
                                              .toString()));
                                        } else {
                                          modem_id.add(this.modemId);
                                        }
                                        meter_id.add(int.parse(this
                                            .widget
                                            .pelanggan
                                            .meterID
                                            .toString()));
                                      }
                                      var result =
                                          await model.insertTindakLanjut(
                                              Provider.of<User>(context).token,
                                              this.widget.pelanggan.id,
                                              this.widget.baID,
                                              tindakLanjutId,
                                              tindakLanjutCheck,
                                              modem_id,
                                              meter_id,
                                              sim_card_id);
                                      if (result['success'] == true) {
                                        pr.hide();
                                        print(result['msg']);
                                        _alertdialog(result['msg']);
                                        Timer(
                                            Duration(
                                              seconds: 3,
                                            ), () {
                                          Navigator.pushNamed(context,
                                              '/detail_pemeriksaan/second',
                                              arguments: {
                                                "hasil_pemeriksaan":
                                                    widget.hasil_pemeriksaan,
                                                "pelanggan": widget.pelanggan,
                                                "tindak_lanjut":
                                                    result['tindak_lanjut']
                                              });
                                        });
                                      } else {
                                        pr.hide();
                                        _alertdialog(result['msg']);
                                      }
                                    } else {
                                      pr.hide();
                                      Navigator.pushNamed(
                                          context, '/detail_pemeriksaan/second',
                                          arguments: widget.beritaAcara);
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
            ));
  }

  List<Widget> gantiModem(
      List<TindakLanjut> tindakLanjut, TindakLanjutModel tindakLanjutModel) {
    var items = new List<Widget>();
    var gantiModem = tindakLanjut
        .where((value) => value.pemeliharaan.startsWith("Ganti Modem"));
    items.add(new TindakLanjutTile(
        tindakLanjut: gantiModem.first,
        isChecked: gantiModem.first.check == null || gantiModem.first.check == 0
            ? false
            : true,
        onTap: (bool isCheck) {
          if (this.widget.enableForm) {
            if (isCheck == true) {
              setState(() {
                gantiModem.first.check = 1;
              });
            } else {
              setState(() {
                gantiModem.first.check = 0;
              });
            }
          }
        }));
    items.add(ListTile(
      title: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(
                  width: 200,
                  child: TextFormField(
                      controller: this.modem,
                      enabled: gantiModem.first.check == null ||
                              gantiModem.first.check == 0
                          ? false
                          : true,
                      onChanged: (val) async {
                        var resultModem = await tindakLanjutModel.cariModem(
                            Provider.of<User>(context).token, val);
                        if (resultModem != null) {
                          setState(() {
                            this.modemVisible = true;
                            this.listModem = tindakLanjutModel.modem;
                          });
                        }
                      },
                      decoration: InputDecoration(labelText: "No IMEI"),
                      validator: (val) {
                        return val;
                      })),
              Visibility(
                visible: this.modemVisible,
                child: Container(
                  width: 200,
                  child: Card(
                      child: ListView.builder(
                    itemCount: listModem.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (ctx, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            this.modem.text = listModem[index].noIMEI;
                            this.modemVisible = false;
                            this.modemId = listModem[index].id;
                          });
                        },
                        child: Container(
                          width: 200,
                          padding: EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 2.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(bottom: BorderSide(width: 1)),
                          ),
                          child: Text(listModem[index].noIMEI),
                        ),
                      );
                    },
                  )),
                ),
              ),
            ],
          )
        ],
      ),
      trailing: Checkbox(
          value: gantiModem.first.check == null || gantiModem.first.check == 0
              ? false
              : true,
          onChanged: (bool isCheck) {
            if (this.widget.enableForm) {
              if (isCheck == true) {
                setState(() {
                  gantiModem.last.check = 1;
                });
              } else {
                setState(() {
                  gantiModem.last.check = 0;
                });
              }
            }
          }),
    ));
    return items;
  }

  List<Widget> getTindakLanjut(
      List<TindakLanjut> tindakLanjut, TindakLanjutModel tindakLanjutModel) {
    var items = new List<Widget>();
    var gantiModem = this.gantiModem(tindakLanjut, tindakLanjutModel);
    var gantiSimCard = this.gantiSimCard(tindakLanjut, tindakLanjutModel);
    items.addAll(gantiModem);
    items.addAll(gantiSimCard);    
    for (var tl in tindakLanjut) {
      if (!tl.pemeliharaan.startsWith("Ganti No Sim Card") &&
          !tl.pemeliharaan.startsWith("Ganti Modem")) {
        items.add(new TindakLanjutTile(
            tindakLanjut: tl,
            isChecked: tl.check == null || tl.check == 0 ? false : true,
            onTap: (bool isCheck) {
              if (this.widget.enableForm) {
                if (isCheck == true) {
                  setState(() {
                    tl.check = 1;
                  });
                } else {
                  setState(() {
                    tl.check = 0;
                  });
                }
              }
            }));
      }
    }
    return items;
  }

  List<Widget> gantiSimCard(
      List<TindakLanjut> tindakLanjut, TindakLanjutModel tindakLanjutModel) {
    var items = new List<Widget>();
    var gantiModem = tindakLanjut
        .where((value) => value.pemeliharaan.startsWith("Ganti No Sim Card"));
    
    items.add(new TindakLanjutTile(
        tindakLanjut: gantiModem.first,
        isChecked: gantiModem.first.check == null || gantiModem.first.check == 0
            ? false
            : true,
        onTap: (bool isCheck) {
          if (this.widget.enableForm) {
            if (isCheck == true) {
              setState(() {
                gantiModem.first.check = 1;
              });
            } else {
              setState(() {
                gantiModem.first.check = 0;
              });
            }
          }
        }));
    items.add(ListTile(
      title: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(
                width: 200,
                child: TextFormField(
                    controller: this.simCard,
                    enabled: gantiModem.first.check == null ||
                            gantiModem.first.check == 0
                        ? false
                        : true,
                    onChanged: (val) async {
                      var resultModem = await tindakLanjutModel.cariSimcard(
                          Provider.of<User>(context).token, val);
                      if (resultModem != null) {
                        setState(() {
                          this.simCardVisible = true;
                          this.listsimCard = tindakLanjutModel.simcard;
                        });
                      }
                    },
                    decoration: InputDecoration(labelText: "No Sim Card"),
                    validator: (val) {
                      return val;
                    }),
              ),
              Visibility(
                visible: this.simCardVisible,
                child: Container(
                  width: 200,
                  child: Card(
                    elevation: 3,
                      child: ListView.builder(
                    itemCount: listsimCard.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (ctx, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            this.simCard.text = listsimCard[index].noSIM;
                            this.simCardVisible = false;
                            this.simCardId = listsimCard[index].id;
                          });
                        },
                        child: Container(
                          width: 200,
                          padding: EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 2.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(bottom: BorderSide(width: 1)),
                          ),
                          child: Text(listsimCard[index].noSIM),
                        ),
                      );
                    },
                  )),
                ),
              ),
            ],
          )
        ],
      ),
      trailing: Checkbox(
          value: gantiModem.first.check == null || gantiModem.first.check == 0
              ? false
              : true,
          onChanged: (bool isCheck) {
            if (this.widget.enableForm) {
              if (isCheck == true) {
                setState(() {
                  gantiModem.last.check = 1;
                });
              } else {
                setState(() {
                  gantiModem.last.check = 0;
                });
              }
            }
          }),
    ));
    return items;
  }
}
