import 'dart:math';

import 'package:flutter_screenutil/flutter_screenutil.dart';

extension ScreenUtilsExt on num {
  double get wMin => min(w, toDouble());
  double get wMax => max(w, toDouble());

  double get hMin => min(h, toDouble());
  double get hMax => max(h, toDouble());

  double get rMin => min(r, toDouble());
  double get rMax => max(r, toDouble());
}
