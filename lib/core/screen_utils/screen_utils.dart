import 'package:flutter/cupertino.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sizer/sizer.dart';

class ScreensHelper {
  static  double width =  100.w;
  static  double height = 100.h;

  ScreensHelper(BuildContext context) {

  }

  static fromWidth(double percent) {
    print(width);
    assert( percent >= 0.0 && percent <= 100.0);
    if(width != null) return (percent/100.0) * width;
  }

  static fromHeight(double percent) {
    assert( percent >= 0.0 && percent <= 100.0);
   if(height != null) return (percent/100.0) * height;
  }

  static scaleText(double fontSize, {bool? allowFontScalingSelf}) {
    return fontSize.sp;
  }
}
