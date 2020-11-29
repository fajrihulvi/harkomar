import 'package:amr_apps/core/model/Tegangan.dart';
import 'package:flutter/material.dart';

class FormTegangan extends StatelessWidget {
  final TextEditingController vr;
  final TextEditingController vs;
  final TextEditingController vt;
  final int pemeriksaanID;
  final Tegangan tegangan;
  final bool enableEdit;
  FormTegangan(
      {this.vr,
      this.vs,
      this.vt,
      this.pemeriksaanID,
      this.tegangan,
      this.enableEdit = true});
  @override
  Widget build(BuildContext context) {
    // TextEditingController _vr =
    //     new TextEditingController(text: this.tegangan.vr);
    // TextEditingController _vs =
    //     new TextEditingController(text: this.tegangan.vs);
    // TextEditingController _vt =
    //     new TextEditingController(text: this.tegangan.vt);
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              enabled: this.enableEdit,
              controller: vr,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value.isEmpty) {
                  return 'data VR masih kosong';
                }

                this.vr.text = value;
                return null;
              },
              decoration: InputDecoration(
                labelText: 'VR',
              ),
            ),
            TextFormField(
              controller: vs,
              enabled: this.enableEdit,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value.isEmpty) {
                  return 'data VS masih kosong';
                }

                this.vs.text = value;
                return null;
              },
              decoration: InputDecoration(
                labelText: 'VS',
              ),
            ),
            TextFormField(
              enabled: this.enableEdit,
              controller: vt,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value.isEmpty) {
                  return 'data VT masih kosong';
                }
                this.vt.text = value;
                return null;
              },
              decoration: InputDecoration(
                labelText: 'VT',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
