import 'package:flutter/cupertino.dart';

class CustomContainerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_1 = Path();
    path_1.moveTo(0, 0);
    path_1.lineTo(size.width * 0.0050000, size.height * 1.0100000);
    path_1.lineTo(size.width * 0.2110000, size.height * 1.0020000);
    path_1.lineTo(size.width * 0.2469500, size.height * 0.8820000);
    path_1.lineTo(size.width * 0.2900000, size.height * 1.0040000);
    path_1.lineTo(size.width, size.height);
    path_1.lineTo(size.width, size.height * -0.0100000);
    path_1.lineTo(size.width * 0.2950000, size.height * 0.0060000);
    path_1.lineTo(size.width * 0.2510000, size.height * 0.1120000);
    path_1.lineTo(size.width * 0.2150500, size.height * 0.0101000);
    path_1.lineTo(0, 0);
    path_1.close();
    path_1.lineTo(size.width, 0);
    return path_1;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
