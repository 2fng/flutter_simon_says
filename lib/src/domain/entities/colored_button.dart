import 'package:flutter/material.dart';

import '../../core/utils/constants.dart';

enum ButtonColor {
  red,
  green,
  blue,
  yellow,
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

  ElevatedButton get button {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: color,
          fixedSize: const Size(buttonWidth, buttonHeight)),
      onPressed: () {
        print('Button $color pressed!');
      },
      child: null,
    );
  }
}
