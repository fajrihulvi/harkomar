import 'package:amr_apps/core/model/TindakLanjut.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class TindakLanjutTile extends StatelessWidget {
  final TindakLanjut tindakLanjut;
  final Function onTap;
  final bool isChecked;
  const TindakLanjutTile({this.tindakLanjut, this.onTap, this.isChecked});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: <Widget>[
          AutoSizeText(
            tindakLanjut.pemeliharaan,
          ),
          Column(
            children: <Widget>[],
          )
        ],
      ),
      trailing: Checkbox(value: this.isChecked, onChanged: onTap),
    );
  }
}
