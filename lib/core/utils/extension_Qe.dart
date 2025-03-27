
import 'package:flutter/material.dart';

extension ResponsiveApp on BuildContext {
  double get wQ => MediaQuery.sizeOf(this).width;
  double get hQ => MediaQuery.sizeOf(this).height;
  double get spQ => MediaQuery.textScalerOf(this).textScaleFactor;
}
