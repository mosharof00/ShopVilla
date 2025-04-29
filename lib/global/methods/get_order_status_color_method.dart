import 'package:flutter/material.dart';

class GetOrderStatusColorMethod {
  static Color getColor(String status) {
    if (status == 'Pending') {
      return const Color(0xFF7b2cbf);
    } else if (status == 'Confirmed') {
      return const Color(0xFF03045e);
    } else if (status == 'Canceled') {
      return Colors.red.shade900;
    } else if (status == 'Ongoing') {
      return Colors.orange;
    } else if (status == 'Delivered') {
      return Colors.green;
    } else if (status == 'Rejected') {
      return const Color(0xFFff477e);
    }
    return Colors.grey;
  }
}
