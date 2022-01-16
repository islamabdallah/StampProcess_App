import 'package:flutter/material.dart';
import 'package:inventory/core/screen_utils/screen_utils.dart';

import 'global_colors.dart';

class GlobalStyles {
  static TextStyle textFieldStyle = TextStyle(
      // decorationThickness: 0,
      decorationColor: Colors.grey,
      color: GlobalColors.darkGrey,
      fontSize: ScreensHelper.scaleText(16.0),
    fontWeight: FontWeight.w400,

    // height: ScreensHelper.fromHeight(0.09)
  );

  static TextStyle defaultTextStyle = TextStyle(
      fontSize: ScreensHelper.scaleText(40),
      color: Colors.black87,
      fontFamily: 'Almarai');

  static InputDecoration pidgeInputDecoration(
      {required labelText, IconData? suffix,
  Function? suffixPressed, IconData? prefix }) {
    return InputDecoration(
      suffixIcon: suffix != null ? IconButton(onPressed:() => suffixPressed, icon: Icon(suffix,
      color:  GlobalColors.primaryGreen,),) : null,
      prefixIcon: prefix != null ? Icon(prefix, color:  GlobalColors.darkGreen,): null,
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ScreensHelper.fromWidth(1.5)),
          borderSide: BorderSide(color: GlobalColors.primaryGreen)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ScreensHelper.fromWidth(1.5)),
          borderSide: BorderSide(color: GlobalColors.primaryGreen)),
      focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(ScreensHelper.fromWidth(1.5)),
    borderSide: BorderSide(color: GlobalColors.primaryGreen)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ScreensHelper.fromWidth(1.5)),
          borderSide: BorderSide(color: Colors.red[200]!)),
      fillColor: Color.fromRGBO(228, 237, 240, 1),
      filled: true,
      labelText: labelText,
      labelStyle: TextStyle(
          fontSize: ScreensHelper.scaleText(16),
          fontWeight: FontWeight.w500,
          color: GlobalColors.darkGreen,
          fontFamily: 'Almarai'),
        isDense: true,
        contentPadding: EdgeInsets.all(5)
    );
  }


}
