import 'package:amr_apps/core/enum/viewstate.dart';
import 'package:amr_apps/core/model/Pelanggan.dart';
import 'package:amr_apps/core/model/User.dart';
import 'package:amr_apps/core/model/WorkOrder.dart';
import 'package:amr_apps/core/viewmodel/detail_pemasangan_model.dart';
import 'package:amr_apps/ui/base_view.dart';
import 'package:amr_apps/ui/shared/color.dart';
import 'package:amr_apps/ui/shared/size.dart';
import 'package:amr_apps/ui/widget/PemeriksaanCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailWoPemasanganScreen extends StatefulWidget {
  final WorkOrder workOrder;
  int jenis;

  DetailWoPemasanganScreen({this.workOrder, this.jenis});
  
  @override
  _DetailWoPemasanganScreenState createState() =>
      _DetailWoPemasanganScreenState();
}

class _DetailWoPemasanganScreenState extends State<DetailWoPemasanganScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseView<DetailPemasanganModel>(
        onModelReady: (model) => model.getPelangganByWO(
            Provider.of<User>(context).token, this.widget.workOrder.nomorWO, this.widget.jenis),
        builder: (context, model, child) => Scaffold(
              appBar: PreferredSize(
                preferredSize: Size(
                    screenWidth(context), screenHeight(context, dividedBy: 8)),
                child: SafeArea(
                    child: Container(
                  color: primaryColor2,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, top: 10, right: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.assignment,
                              color: Colors.white,
                              size: 30.0,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Detail Pasang Baru',
                                  style: TextStyle(
                                      color: colorWhite, fontSize: 18),
                                ),
                                Text(
                                  'No ' + widget.workOrder.nomorWO,
                                  style: TextStyle(
                                      color: colorWhite, fontSize: 16),
                                ),
                                Text(
                                  widget.workOrder.tanggal,
                                  style: TextStyle(
                                      color: colorWhite, fontSize: 16),
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
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView(
                          children: this.getPemasanganUI(model.pelanggan)),
                    ),
            ));
  }

  List<Widget> getPemasanganUI(List<Pelanggan> pelanggan) {
    var items = new List<Widget>();
    items.add(Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Data Pelanggan',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ],
    ));
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
                "Tidak  Ada Data",
                style: TextStyle(color: Colors.grey[300], fontSize: 20),
              )
            ],
          ),
        ),
      );
    } else {
      for (var pel in pelanggan) {
        items.add(new PemeriksaanCard(
            pelanggan: pel,
            onTap: () {
              Navigator.pushNamed(context, '/detail_pemeriksaan/first',
                  arguments: pel);
            }));
      }
    }
    return items;
  }
}
