part of 'configs.dart';

const fontFamily = 'Poppins';

final themeLight = ThemeData(
  fontFamily: fontFamily,
  primaryColor: AppTheme.light.primary,
  brightness: Brightness.light,
  splashColor: Colors.transparent,
  scaffoldBackgroundColor: Colors.white,
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  ),
  colorScheme: ThemeData.light().colorScheme.copyWith(
        primary: AppTheme.light.primary,
        background: AppTheme.light.background,
        secondary: AppTheme.dark.primary,
      ),
);
