import 'package:amr_apps/core/model/WorkOrder.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:amr_apps/ui/shared/color.dart';

class WoCard extends StatelessWidget {
  final WorkOrder workOrder;
  final Function onTap;
  final String title;
  const WoCard({this.workOrder, this.onTap, this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.assignment, size: 40, color: primaryColor1,),
                      title: AutoSizeText(workOrder.nomorWO, style: TextStyle(color: primaryColor1, fontWeight: FontWeight.w500),),
                      subtitle: AutoSizeText(workOrder.tanggal),
                      onTap: onTap,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
