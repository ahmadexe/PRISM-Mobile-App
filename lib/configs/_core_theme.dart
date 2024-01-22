part of 'configs.dart';

const fontFamily = 'Poppins';

final themeDark = ThemeData(
  appBarTheme: AppBarTheme(
    backgroundColor: AppTheme.dark.background,
    // color: AppTheme.dark.background,
    foregroundColor: AppTheme.dark.white,
    elevation: 0,
    iconTheme: IconThemeData(color: AppTheme.dark.white),
  ),
  primarySwatch: ThemeUtils.getMaterialColor(AppTheme.dark.primary!),
  primaryColor: AppTheme.dark.primary,
  brightness: Brightness.dark,
  splashColor: Colors.transparent,
  scaffoldBackgroundColor: AppTheme.dark.background,
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  ),
  colorScheme: ThemeData.dark().colorScheme.copyWith(
        background: AppTheme.light.background,
        secondary: AppTheme.dark.primary,
      ),
);
