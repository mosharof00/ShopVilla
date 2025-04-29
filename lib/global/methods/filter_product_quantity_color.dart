import 'package:flutter/material.dart';

class FilterProductQuantityColor {
  static Color getColor({required int count}) {
    if (count < 100) {
      return Colors.red;
    } else if (count >= 100 && count < 200) {
      return Colors.yellow;
    } else {
      return Colors.black;
    }
  }
}
