import 'package:flutter_screenutil/flutter_screenutil.dart';

extension NumExtension on num {
  double get w => ScreenUtil().setWidth(this);
  double get h => ScreenUtil().setHeight(this);
  double get sp => ScreenUtil().setSp(this);
  double get r => ScreenUtil().radius(this);
}

extension StringExtension on String {
  String toTitleCase() {
    return split(' ')
        .map((word) => word.isNotEmpty 
            ? word[0].toUpperCase() + word.substring(1).toLowerCase()
            : word)
        .join(' ');
  }
}