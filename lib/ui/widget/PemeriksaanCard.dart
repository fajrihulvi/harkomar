import 'package:amr_apps/core/model/Pelanggan.dart';
import 'package:flutter/material.dart';
import 'package:amr_apps/ui/shared/color.dart';

class PemeriksaanCard extends StatelessWidget {
  final Pelanggan pelanggan;
  final Function onTap;
  const PemeriksaanCard({this.pelanggan, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey[100],
                                    blurRadius: 5.0,
                                    offset: Offset(
                                      0,
                                      1.0,
                                    ),
                                  )
                                ],
                              ),
                              width: 60,
                              height: 60,
                              child: Container(
                                child: Image.asset('assets/images/icon.png', height: 15, width: 15,),
                              )),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Text(this.pelanggan.namaPelanggan,
                                      style: TextStyle(
                                          color: primaryColor1,
                                          fontWeight: FontWeight.w800)),
                                ),
                              ),
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Text(this.pelanggan.idPel,
                                      style: TextStyle(
                                          color: primaryColor1,
                                          fontWeight: FontWeight.w800)),
                                ),
                              ),
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Text(this.pelanggan.alamat,
                                      softWrap: true,
                                      style: TextStyle(fontSize: 12.0)),
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text(this.pelanggan.tarif +
                                          ' | ' +
                                          this.pelanggan.daya),
                                    ),
                                  ),
                                  Container(
                                    child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: (this.pelanggan.status_wo == "0")
                                            ? Text("Belum",
                                                style: TextStyle(
                                                    color: Colors.amber[700],
                                                    fontWeight: FontWeight.w700))
                                            : Text("Selesai",
                                                style: TextStyle(
                                                    color: primaryColor2,
                                                    fontWeight:
                                                        FontWeight.w700))),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
