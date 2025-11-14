import 'package:flutter/widgets.dart';

class Breakpoints {
  static const double small = 600;  // phones
  static const double medium = 900; // tablets
}

extension MediaQueryX on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  bool get isSmall => screenWidth < Breakpoints.small;
  bool get isMedium => screenWidth >= Breakpoints.small && screenWidth < Breakpoints.medium;
  bool get isLarge => screenWidth >= Breakpoints.medium;

  double get horizontalPad => isLarge ? 80.0 : (isSmall ? 20.0 : 40.0);
}
