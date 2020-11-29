import 'package:amr_apps/ui/shared/color.dart';
import 'package:flutter/material.dart';

class RewardSearchBar extends StatelessWidget {
  final Function(String) onChanged;
  final Function (String)onBarcodePressed;
  final Function onDrawerPressed;
  final String titleSearch;
  final TextEditingController inputBar;
  const RewardSearchBar({
    Key key,
    @required this.onChanged,
    @required this.onBarcodePressed,
    @required this.onDrawerPressed,
    @required this.titleSearch,
    @required this.inputBar,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10),
        decoration: BoxDecoration(
            border: Border.all(
              color: primaryColor2,
            ),
            borderRadius: BorderRadius.circular(15.0)),
        child: Row(
          children: <Widget>[
//            if(!ModalRoute.of(context).canPop)IconButton(
//              icon: Icon(
//                Icons.menu,
//                color: Colors.black54,
//              ),
//              onPressed: () => onDrawerPressed(),
//            ),
//            if(ModalRoute.of(context).canPop)BackButton(
//              color: Colors.black54,
//            ),
            Expanded(
              child: TextField(
                controller: inputBar,
                onChanged: (val) => onChanged(val),
                decoration: InputDecoration(
                    hintText: titleSearch, border: InputBorder.none, hintStyle: TextStyle(color: primaryColor2)),
              ),
            ),
            IconButton(
              onPressed: ()=>
                onBarcodePressed(this.inputBar.text),
              icon: Icon(
//                CommunityMaterialIcons.feature_search,
              Icons.search,
                color: primaryColor2,
              ),
            )
          ],
        ),
      ),
    );
  }
}
