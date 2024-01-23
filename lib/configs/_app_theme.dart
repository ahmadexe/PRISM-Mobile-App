part of 'configs.dart';

class AppTheme {
  static final _core = AppCoreTheme(
    primary: const Color.fromARGB(255, 97, 100, 242),
    accent: const Color.fromARGB(255, 36, 165, 89),
    //
    background: const Color.fromARGB(255, 0, 0, 0),
    backgroundSub: const Color.fromARGB(255, 20, 19, 23),
    fieldLight: const Color.fromARGB(255, 33, 33, 41),
    fieldDark: const Color.fromARGB(255, 15, 16, 22),
    //
    shadow: Colors.black.withOpacity(0.25),
    shadowSub: Colors.black.withOpacity(0.15),
    //
    text: const Color(0xFF6D8593),
    textGrey: const Color(0xff828282),
    textLight: const Color(0xff4F4F4F),
    lightGrey: const Color(0xffF2F2F2),
    //
    grey: const Color.fromARGB(255, 44, 45, 49),
    danger: const Color(0xffEB5757),
    yellow: const Color(0xffFFC179),
    ghostGrey: const Color(0xff333333),
    //
    white: const Color.fromARGB(255, 218, 218, 223),

    pink: const Color.fromARGB(255, 151, 150, 208),
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
