import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const primaryColor = Color(0xffF6F7EB);
const darkblue = Color(0xff1D1D4E);
const darkblueLoading = Color(0xff373795);
const cerulean = Color(0xff7A9CC6);
const ceruleanHeading = Color(0xff5480B6);
const ceruleanSelect = Color(0xffBCD6F4);
const cyanDark = Color(0xff3E8989);
const cyanSuccessVarntLight = Color(0xff9CD3D3);
const bittersweet = Color(0xffF87060);

final kLoadingIndicator = SpinKitPulse(
  size: 60,
  color: darkblue.withOpacity(0.5),
);

InputDecoration kinputDecorationtextFieldTheme = InputDecoration(
    border: OutlineInputBorder(
      borderSide: const BorderSide(width: 1, color: Colors.black12),
      borderRadius: BorderRadius.circular(15),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(width: 1, color: Colors.black12),
      borderRadius: BorderRadius.circular(15),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(width: 1.5, color: cerulean),
      borderRadius: BorderRadius.circular(15),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(width: 1.5, color: bittersweet),
      borderRadius: BorderRadius.circular(15),
    ));
BoxShadow kBoxShadow1 = BoxShadow(
    color: Colors.black.withAlpha(20),
    blurRadius: 8,
    offset: const Offset(2, 2));
const kBorderRadius = BorderRadius.all(Radius.circular(10));
const kHeading1Style = TextStyle(fontWeight: FontWeight.w500, fontSize: 27);
const kLightTextStyle =
    TextStyle(fontWeight: FontWeight.w300, fontSize: 12, color: Colors.black54);
List kAestheticColors = [
  'B9DFDF',
  'F4CDD0',
  'CDCCE0',
  'FFE099',
  'BAFF99',
  '99FFDA',
  'D899FF'
];
