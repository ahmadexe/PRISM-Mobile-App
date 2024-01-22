part of 'configs.dart';

class Space {
  static Widget? x;
  static Widget? y;
  static Widget? x1;
  static Widget? y1;
  static Widget? x2;
  static Widget? y2;
  static Widget? xm;
  static Widget? ym;

  static EdgeInsets? z;
  static EdgeInsets? h;
  static EdgeInsets? v;
  static EdgeInsets? h1;
  static EdgeInsets? v1;
  static EdgeInsets? h2;
  static EdgeInsets? v2;

  static Widget? top;
  static Widget? bottom;

  static void init(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(428, 926));

    x = SizedBox(width: 8.w);
    y = SizedBox(height: 8.h);

    x1 = SizedBox(width: 15.w);
    y1 = SizedBox(height: 15.h);

    x2 = SizedBox(width: 20.w);
    y2 = SizedBox(height: 20.h);

    z = EdgeInsets.zero;
    h = EdgeInsets.symmetric(horizontal: 8.w);
    v = EdgeInsets.symmetric(vertical: 8.h);

    h1 = EdgeInsets.symmetric(horizontal: 15.w);
    v1 = EdgeInsets.symmetric(vertical: 15.h);

    h2 = EdgeInsets.symmetric(horizontal: 20.w);
    v2 = EdgeInsets.symmetric(vertical: 20.h);

    xm = ym = const Spacer();

    top = SizedBox(height: UI.padding!.top);
    bottom = SizedBox(height: UI.padding!.bottom);
  }

  static Widget xf([double no = 5]) => SizedBox(width: no.w);
  static Widget yf([double no = 5]) => SizedBox(height: no.h);

  static EdgeInsets hf([double no = 8]) =>
      EdgeInsets.symmetric(horizontal: no.w);
  static EdgeInsets vf([double no = 8]) => EdgeInsets.symmetric(vertical: no.h);

  static EdgeInsets all([double h = 15, double? v]) => EdgeInsets.symmetric(
        vertical: v != null ? v.w : h.w,
        horizontal: h.w,
      );
}
