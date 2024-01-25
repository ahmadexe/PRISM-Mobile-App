import 'package:flutter/material.dart';

class AllLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(6.83, 446.61);
    path_0.lineTo(329.34, 254.76000000000002);
    path_0.lineTo(520.12, 440.03000000000003);
    path_0.lineTo(299.99, 588.62);
    path_0.lineTo(355.02, 678.51);
    path_0.lineTo(655.8599999999999, 474.89);
    path_0.lineTo(333.14, 5.46);
    path_0.cubicTo(328.18, -1.75, 317.56, -1.83, 312.5, 5.31);
    path_0.lineTo(2.76, 442.19);
    path_0.cubicTo(
        0.8399999999999999, 444.9, 3.9799999999999995, 448.3, 6.84, 446.61);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = const Color(0xff6164f2).withOpacity(1.0);
    canvas.drawPath(path_0, paint0Fill);

    Path path_1 = Path();
    path_1.moveTo(324.68, 0.15);
    path_1.cubicTo(320.2, -0.53, 315.42, 1.17, 312.49, 5.300000000000001);
    path_1.lineTo(2.76, 442.17);
    path_1.cubicTo(0.8399999999999999, 444.88, 3.9799999999999995,
        448.28000000000003, 6.84, 446.59000000000003);
    path_1.lineTo(324.69, 257.51);
    path_1.lineTo(324.69, 0.15);
    path_1.close();

    Paint paint1Fill = Paint()..style = PaintingStyle.fill;
    paint1Fill.color = const Color(0xff4b4f99).withOpacity(1.0);
    canvas.drawPath(path_1, paint1Fill);

    Path path_2 = Path();
    path_2.moveTo(649.04, 607.78);
    path_2.lineTo(326.53, 799.63);
    path_2.lineTo(135.74999999999997, 614.36);
    path_2.lineTo(355.88, 465.77);
    path_2.lineTo(300.85, 375.88);
    path_2.lineTo(0, 579.51);
    path_2.lineTo(322.73, 1048.93);
    path_2.cubicTo(
        327.69, 1056.14, 338.31, 1056.22, 343.37, 1049.0800000000002);
    path_2.lineTo(653.11, 612.2000000000002);
    path_2.cubicTo(655.03, 609.4900000000001, 651.89, 606.0900000000001, 649.03,
        607.7800000000002);
    path_2.close();

    Paint paint2Fill = Paint()..style = PaintingStyle.fill;
    paint2Fill.color = const Color(0xff6164f2).withOpacity(1.0);
    canvas.drawPath(path_2, paint2Fill);

    Path path_3 = Path();
    path_3.moveTo(331.19, 1054.24);
    path_3.cubicTo(335.67, 1054.92, 340.45, 1053.22, 343.38, 1049.09);
    path_3.lineTo(653.12, 612.2099999999999);
    path_3.cubicTo(
        655.04, 609.4999999999999, 651.9, 606.0999999999999, 649.04, 607.79);
    path_3.lineTo(331.18999999999994, 796.87);
    path_3.lineTo(331.18999999999994, 1054.23);
    path_3.close();

    Paint paint3Fill = Paint()..style = PaintingStyle.fill;
    paint3Fill.color = const Color(0xff4b4f99).withOpacity(1.0);
    canvas.drawPath(path_3, paint3Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
