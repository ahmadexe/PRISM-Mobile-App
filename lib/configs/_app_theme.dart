part of 'configs.dart';

class AppTheme {
  static final _core = AppCoreTheme(
    primary: const Color(0xff1D3F4C),
    accent: const Color(0xFF71C3CB),
    //
    background: const Color(0xFFF9F9F9),
    backgroundSub: const Color(0xFFF3FBFE),
    //
    shadowSub: const Color(0xFFD9D9D9),
    shadow: Colors.black.withOpacity(0.25),
    //
    text: const Color(0xFF6D8593),
    textGrey: const Color(0xff828282),
    textLight: const Color(0xff4F4F4F),
    lightGrey: const Color(0xffF2F2F2),
    //
    grey: const Color(0xff828282),
    danger: const Color(0xffEB5757),
    yellow: const Color(0xffFFC179),
    ghostGrey: const Color(0xff333333),
  );

  static AppCoreTheme light = _core;
  static AppCoreTheme dark = _core;

  static late AppCoreTheme c;

  // Init
  static init(BuildContext context) {
    c = isDark(context) ? dark : light;
  }

  static bool isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;
}
