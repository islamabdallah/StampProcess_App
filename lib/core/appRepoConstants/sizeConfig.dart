// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';
//
// class SizeConfig {
//
//
//   // static MediaQueryData _mediaQueryData;
//   // static double  screenWidth;
//   // static double  screenHeight;
//   //
//   // static double  blockSizeHorizontal;
//   // static double  blockSizeVertical;
//   //
//   // static double  safeBlockHorizontal;
//   // static double  safeBlockVertical;
//   //
//   // static double  _safeAreaHorizontal;
//   // static double  _safeAreaVertical;
//
//   static double screenWidth = Get.context.orientation == Orientation.portrait ? Get.mediaQuery.size.width : Get.mediaQuery.size.height;
//   static double screenHeight = Get.context.orientation == Orientation.portrait ? Get.mediaQuery.size.height : Get.mediaQuery.size.width;
//   static double blockSizeHorizontal = screenWidth / 100;
//   static double blockSizeVertical = screenHeight / 100;
//   static double _safeAreaHorizontal = Get.mediaQuery.padding.left + Get.mediaQuery.padding.right;
//   static double _safeAreaVertical = Get.mediaQuery.padding.top + Get.mediaQuery.padding.bottom;
//   static double safeBlockHorizontal = (screenWidth - (Get.context.orientation == Orientation.portrait ? _safeAreaHorizontal : _safeAreaVertical)) / 100;
//   static double safeBlockVertical = (screenHeight - (Get.context.orientation == Orientation.portrait ? _safeAreaVertical : _safeAreaHorizontal)) / 100;
//
//
//
//   void init(BuildContext context) {
//     // _mediaQueryData = MediaQuery.of(context);
//     // screenWidth = _mediaQueryData.size.width;
//     // screenHeight = _mediaQueryData.size.height;
//     // blockSizeHorizontal = screenWidth / 100;
//     // blockSizeVertical = screenHeight / 100;
//     //
//     // _safeAreaHorizontal = _mediaQueryData.padding.left + _mediaQueryData.padding.right;
//     // _safeAreaVertical = _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
//     // safeBlockHorizontal = (screenWidth - (context.orientation == Orientation.portrait ? _safeAreaHorizontal : _safeAreaVertical)) / 100;
//     // safeBlockVertical = (screenHeight - (context.orientation == Orientation.portrait ? _safeAreaVertical : _safeAreaHorizontal)) / 100;
//   }
//
//   static BorderRadius defaultButtonCornerRadius = BorderRadius.circular(SizeConfig.safeBlockHorizontal * 6);
//   static BorderRadius defaultTextControllerRadius = BorderRadius.circular(SizeConfig.safeBlockHorizontal * 2);
//   static double drawerIconSize = SizeConfig.safeBlockHorizontal * 9;
//   static BorderRadius circleCornerRadius = BorderRadius.circular(SizeConfig.safeBlockHorizontal * 100);
//
//
//
//   static double fontSize8 = safeBlockHorizontal * 1;
//   static double fontSize10 = safeBlockHorizontal * 2;
//   static double fontSize11 = safeBlockHorizontal * 2.5;
//   static double fontSize12 = safeBlockHorizontal * 3;
//   static double fontSize13 = safeBlockHorizontal * 3.5;
//   static double fontSize14 = safeBlockHorizontal * 4;
//   static double fontSize15 = safeBlockHorizontal * 4.5;
//   static double fontSize16 = safeBlockHorizontal * 5;
//   static double fontSize17 = safeBlockHorizontal * 5.5;
//   static double fontSize18 = safeBlockHorizontal * 6;
//   static double fontSize20 = safeBlockHorizontal * 7;
//   static double fontSize22 = safeBlockHorizontal * 8;
//   static double fontSize23 = safeBlockHorizontal * 8.5;
//   static double fontSize25 = safeBlockHorizontal * 9.5;
//   static double fontSize26 = safeBlockHorizontal * 10;
//   static double fontSize30 = safeBlockHorizontal * 12;
//   static double fontSize40 = safeBlockHorizontal * 17;
//
// }
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

class SizeConfig {

  static late double  screenWidth;
  static late double  screenHeight;
  static late double  blockSizeHorizontal;
  static late  double  blockSizeVertical;
  static late double  safeBlockHorizontal;
  static late double  safeBlockVertical;
  static late double  _safeAreaHorizontal;
  static late double  _safeAreaVertical;


  void init(BuildContext context) {
    screenWidth = 100.w;
    screenHeight = 100.h;

    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
    _safeAreaHorizontal = 0.5.w;
    _safeAreaVertical = 0.10.h;
    safeBlockHorizontal = (screenWidth - (SizerUtil.orientation == Orientation.portrait ? _safeAreaHorizontal : _safeAreaVertical)) / 100;
    safeBlockVertical = (screenHeight - (SizerUtil.orientation == Orientation.portrait ? _safeAreaVertical : _safeAreaHorizontal)) / 100;
  }
  static BorderRadius defaultButtonCornerRadius = BorderRadius.circular(SizeConfig.safeBlockHorizontal * 6);
  static BorderRadius defaultTextControllerRadius = BorderRadius.circular(SizeConfig.safeBlockHorizontal * 2);
  static double drawerIconSize = SizeConfig.safeBlockHorizontal * 9;
  static BorderRadius circleCornerRadius = BorderRadius.circular(SizeConfig.safeBlockHorizontal * 100);



  static double fontSize8 = safeBlockHorizontal * 1;
  static double fontSize10 = safeBlockHorizontal * 2;
  static double fontSize11 = safeBlockHorizontal * 2.5;
  static double fontSize12 = safeBlockHorizontal * 3;
  static double fontSize13 = safeBlockHorizontal * 3.5;
  static double fontSize14 = safeBlockHorizontal * 4;
  static double fontSize15 = safeBlockHorizontal * 4.5;
  static double fontSize16 = safeBlockHorizontal * 5;
  static double fontSize17 = safeBlockHorizontal * 5.5;
  static double fontSize18 = safeBlockHorizontal * 6;
  static double fontSize20 = safeBlockHorizontal * 7;

  static double fontSize22 = safeBlockHorizontal * 8;
  static double fontSize23 = safeBlockHorizontal * 8.5;
  static double fontSize25 = safeBlockHorizontal * 9.5;
  static double fontSize26 = safeBlockHorizontal * 10;
  static double fontSize30 = safeBlockHorizontal * 12;
  static double fontSize40 = safeBlockHorizontal * 17;

}