// create extension responsive sizedbox
import 'package:flutter/widgets.dart';

extension ResponsiveSized on double {
  SizedBox get wS => SizedBox(width: toDouble());
  SizedBox get hS => SizedBox(height: toDouble());

}