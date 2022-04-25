import 'package:flutter/material.dart';

class KnobBackgroundPainter extends CustomPainter {
  final Paint grey = createPaintForColor(Colors.grey[400]!);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 120, grey);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

///
Paint createPaintForColor(Color color) {
  return Paint()
    ..color = color
    ..strokeCap = StrokeCap.round
    ..style = PaintingStyle.fill;
}
