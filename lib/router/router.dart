import 'package:prism/screens/edit_profile/edit_profile.dart';
import 'package:prism/screens/forgot_password/forgot_password.dart';
import 'package:prism/screens/register/register.dart';
import 'package:prism/screens/login/login.dart';
import 'package:prism/screens/splash/splash.dart';
import 'package:prism/screens/profile/profile.dart';
import 'package:prism/screens/notifications/notifications.dart';
import 'package:prism/screens/shout_outs/shout_outs.dart';
import 'package:prism/screens/explore/explore.dart';

import 'package:flutter/material.dart';
import 'package:prism/router/routes.dart';
import 'package:prism/screens/home/home.dart';

final Map<String, Widget Function(dynamic)> appRoutes = {
  AppRoutes.editProfile: (_) => const EditProfileScreen(),
  AppRoutes.forgotPassword: (_) => const ForgotPasswordScreen(),
  AppRoutes.register: (_) => const RegisterScreen(),
  AppRoutes.login: (_) => const LoginScreen(),
  AppRoutes.splash: (_) => const SplashScreen(),
};

Route<dynamic>? onGenerateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.home:
      return FadeRoute(
        settings: settings,
        child: const HomeScreen(),
      );

    case AppRoutes.explore:
      return FadeRoute(
        settings: settings,
        child: const ExploreScreen(),
      );

    case AppRoutes.shoutOuts:
      return FadeRoute(
        settings: settings,
        child: const ShoutOutsScreen(),
      );

    case AppRoutes.notifications:
      return FadeRoute(
        settings: settings,
        child: const NotificationsScreen(),
      );

    case AppRoutes.profile:
      return FadeRoute(
        settings: settings,
        child: const ProfileScreen(),
      );
    default:
      return null;
  }
}

class FadeRoute extends PageRouteBuilder {
  final Widget child;

  @override
  final RouteSettings settings;

  FadeRoute({required this.child, required this.settings})
      : super(
          settings: settings,
          pageBuilder: (context, ani1, ani2) => child,
          transitionsBuilder: (context, ani1, ani2, child) {
            return FadeTransition(
              opacity: ani1,
              child: child,
            );
          },
        );
}
