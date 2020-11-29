import 'package:flutter/material.dart';
import 'package:amr_apps/core/model/Arus.dart';

class FormArus extends StatelessWidget {
  final TextEditingController lr;
  final TextEditingController ls;
  final TextEditingController lt;
  final int pemeriksaanID;
  final Arus arus;
  final bool enableEdit;
  FormArus(
      {this.lr,
      this.ls,
      this.lt,
      this.pemeriksaanID,
      this.arus,
      this.enableEdit = true});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              enabled: this.enableEdit,
              controller: lr,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value.isEmpty) {
                  return 'data IR masih kosong';
                }
                this.lr.text = value;
                return null;
              },
              decoration: InputDecoration(
                labelText: 'IR',
              ),
            ),
            TextFormField(
              enabled: this.enableEdit,
              controller: ls,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value.isEmpty) {
                  return 'data IS masih kosong';
                }

                this.ls.text = value;
                return null;
              },
              decoration: InputDecoration(
                labelText: 'IS',
              ),
            ),
            TextFormField(
              enabled: this.enableEdit,
              controller: lt,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value.isEmpty) {
                  return 'data IT masih kosong';
                }
                this.lt.text = value;
                return null;
              },
              decoration: InputDecoration(
                labelText: 'IT',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
