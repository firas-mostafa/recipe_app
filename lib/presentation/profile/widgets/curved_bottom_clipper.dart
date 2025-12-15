import 'package:flutter/material.dart' show CustomClipper, Path, Size;

class CurvedBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    double w = size.width;
    double h = size.height;
    path.lineTo(0, h * .6); //p2
    path.quadraticBezierTo(
      w * .25,
      h, //p3
      w * .5,
      h * .5, //p4
    );
    path.quadraticBezierTo(
      w * .75,
      0, //p5
      w,
      h * .6, //p6
    );

    path.lineTo(w, 0); //p7
    // path.lineTo(h, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
