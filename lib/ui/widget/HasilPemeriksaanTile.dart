import 'package:amr_apps/core/model/HasilPemeriksaan.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class HasilPemeriksaanTile extends StatelessWidget {
  final HasilPemeriksaan hasilPemeriksaan;
  final Function onTap;
  final bool isChecked;
  const HasilPemeriksaanTile(
      {this.hasilPemeriksaan, this.onTap, this.isChecked});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Flexible(
            flex: 2,
            child: AutoSizeText(hasilPemeriksaan.pemeliharaan)),
          Column(
            children: <Widget>[],
          )
        ],
      ),
      trailing: Checkbox(value: this.isChecked, onChanged: onTap),
    );
  }
}
