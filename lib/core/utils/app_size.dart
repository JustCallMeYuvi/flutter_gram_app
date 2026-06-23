import 'package:flutter/material.dart';

class AppSize {
  static double width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double height(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double wp(
    BuildContext context,
    double percent,
  ) {
    return MediaQuery.of(context).size.width * percent;
  }

  static double hp(
    BuildContext context,
    double percent,
  ) {
    return MediaQuery.of(context).size.height * percent;
  }
}
