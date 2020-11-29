import 'package:flutter/material.dart';

class FormDaya extends StatelessWidget {
  final TextEditingController daya;
  final TextEditingController tarif;
  final String dy;
  final String tar;
  final bool enableEdit;

  FormDaya(
      {this.daya,
      this.tarif,
      this.dy,
      this.tar,
      this.enableEdit = false});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  'Data Daya/Tarif',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  ' (Di Ambil Dari Data Pelanggan)',
                  style: TextStyle(color: Colors.red, fontSize: 14),
                ),
              ],
            ),
            TextFormField(
              enabled: false,
              controller: daya,
              keyboardType: TextInputType.text,
              initialValue: this.dy,
              decoration: InputDecoration(
                labelText: 'Daya',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return "daya masih kosong";
                }
                this.daya.text = value;
                return null;
              },
            ),
            TextFormField(
              enabled: false,
              keyboardType: TextInputType.text,
              initialValue: this.tar,
              controller: tarif,
              decoration: InputDecoration(
                labelText: 'Tarif',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return "tipe meter masih kosong";
                }
                this.tarif.text = value;
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
