import 'package:flutter/material.dart';

class AppLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(2.11, 137.66);
    path_0.lineTo(101.52, 78.53);
    path_0.lineTo(160.32, 135.64);
    path_0.lineTo(92.47, 181.44);
    path_0.lineTo(109.43, 209.15);
    path_0.lineTo(202.16000000000003, 146.39000000000001);
    path_0.lineTo(102.68, 1.68);
    path_0.cubicTo(101.15, -0.5400000000000003, 97.88000000000001,
        -0.5700000000000001, 96.32000000000001, 1.63);
    path_0.lineTo(0.85, 136.29);
    path_0.cubicTo(0.26, 137.12, 1.23, 138.17, 2.11, 137.65);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = Color(0xff6164f2).withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(100.08, 0.05);
    path_1.cubicTo(
        98.7, -0.15999999999999998, 97.23, 0.36, 96.32, 1.6400000000000001);
    path_1.lineTo(0.85, 136.29);
    path_1.cubicTo(0.26, 137.12, 1.23, 138.17, 2.11, 137.65);
    path_1.lineTo(100.08, 79.37);
    path_1.lineTo(100.08, 0.05);
    path_1.close();

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = Color(0xff4b4f99).withOpacity(1.0);
    canvas.drawPath(path_1, paint_1_fill);

    Path path_2 = Path();
    path_2.moveTo(200.05, 187.33);
    path_2.lineTo(100.64000000000001, 246.46);
    path_2.lineTo(41.84000000000002, 189.35000000000002);
    path_2.lineTo(109.69000000000001, 143.55);
    path_2.lineTo(92.73000000000002, 115.84);
    path_2.lineTo(0, 178.62);
    path_2.lineTo(99.47, 323.31);
    path_2.cubicTo(101, 325.53000000000003, 104.27, 325.56, 105.83, 323.36);
    path_2.lineTo(201.3, 188.70000000000002);
    path_2.cubicTo(201.89000000000001, 187.87, 200.92000000000002,
        186.82000000000002, 200.04000000000002, 187.34);
    path_2.close();

    Paint paint_2_fill = Paint()..style = PaintingStyle.fill;
    paint_2_fill.color = Color(0xff6164f2).withOpacity(1.0);
    canvas.drawPath(path_2, paint_2_fill);

    Path path_3 = Path();
    path_3.moveTo(102.08, 324.95);
    path_3.cubicTo(
        103.46, 325.15999999999997, 104.92999999999999, 324.64, 105.84, 323.36);
    path_3.lineTo(201.31, 188.70000000000002);
    path_3.cubicTo(201.9, 187.87, 200.93, 186.82000000000002, 200.05, 187.34);
    path_3.lineTo(102.08000000000001, 245.62);
    path_3.lineTo(102.08000000000001, 324.95);
    path_3.close();

    Paint paint_3_fill = Paint()..style = PaintingStyle.fill;
    paint_3_fill.color = Color(0xff4b4f99).withOpacity(1.0);
    canvas.drawPath(path_3, paint_3_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
