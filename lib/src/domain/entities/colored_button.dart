import 'package:flutter/material.dart';

import '../../core/utils/constants.dart';

enum ButtonColor {
  red,
  green,
  blue,
  yellow,
}

class ColoredButton {
  final ButtonColor color;
  bool willBlink;
  var button;

  ColoredButton({required this.color, required this.willBlink});
}

extension ButtonColorExtention on ButtonColor {
  Color get color {
    switch (this) {
      case ButtonColor.red:
        return Colors.red;
      case ButtonColor.green:
        return Colors.green;
      case ButtonColor.blue:
        return Colors.blue;
      case ButtonColor.yellow:
        return Colors.yellow;
    }
  }
}
