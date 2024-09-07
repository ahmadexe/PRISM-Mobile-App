part of 'configs.dart';

const fontFamily = 'Poppins';

final themeDark = ThemeData(
  appBarTheme: AppBarTheme(
    backgroundColor: AppTheme.dark.background,
    foregroundColor: AppTheme.dark.white,
    elevation: 0,
    iconTheme: IconThemeData(color: AppTheme.dark.white),
  ),
  primaryColor: AppTheme.dark.background,
  brightness: Brightness.dark,
  splashColor: Colors.transparent,
  scaffoldBackgroundColor: AppTheme.dark.background,
  primaryColorDark: AppTheme.dark.background,
  floatingActionButtonTheme:
      FloatingActionButtonThemeData(foregroundColor: AppTheme.dark.white),
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  ),

  colorScheme: ThemeData.dark().colorScheme.copyWith(
        secondary: AppTheme.dark.primary,
        surface: AppTheme.dark.background,
        onSurface: AppTheme.dark.white,
        primary: AppTheme.dark.primary,
      ),
);
