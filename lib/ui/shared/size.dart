import 'package:flutter/material.dart';

const double baseHeight = 650.0;
const double spaceHeight = 12.0;
const double paddingSpace = 25.0;
const double fontSizeNormal = 14.0;

Size screenSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

double screenHeight(BuildContext context,
    {double dividedBy = 1, double reducedBy = 0.0}) {
  return (MediaQuery.of(context).size.height - reducedBy) / dividedBy;
}

double screenWidth(BuildContext context,
    {double dividedBy = 1, double reducedBy = 0.0}) {
  return (MediaQuery.of(context).size.width - reducedBy) / dividedBy;
}

double deviceRatio(BuildContext context){
  final size = MediaQuery.of(context).size;
  return size.width / size.height;
}

double screenHeightExcludingToolbar(BuildContext context,
    {double dividedBy = 1}) {
  return screenHeight(context, dividedBy: dividedBy, reducedBy: kToolbarHeight);
}

bool isKeyboardUp(BuildContext context){
  return MediaQuery.of(context).viewInsets.bottom == 0.0;
}

double screenAwareSize(double size, BuildContext context) {
  return size * MediaQuery.of(context).size.height / baseHeight;
}


double marginScreenHorizontal(BuildContext context){
  return MediaQuery.of(context).size.width/25;
}

double moreMarginScreenHorizontal(BuildContext context){
  return MediaQuery.of(context).size.width/10;
}

double marginScreenVertical(BuildContext context){
  return MediaQuery.of(context).size.height/40;
}

double imageHeight(BuildContext context){
  return MediaQuery.of(context).size.height/5;
}

bool isNoKeyboardOnScreen(BuildContext context){
  return MediaQuery.of(context).viewInsets.bottom == 0.0;
}
