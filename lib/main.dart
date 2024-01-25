import 'package:flutter/material.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';
import 'package:prism/configs/configs.dart';
import 'package:prism/router/router.dart';
import 'package:prism/router/routes.dart';
import 'configs/configs.dart' as theme;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final navigatorKey = GlobalKey<NavigatorState>();
  final List<NavigatorObserver> observers = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      navigatorObservers: [
        ...observers,
        NavigationHistoryObserver(),
      ],
      theme: theme.themeDark,
      initialRoute: AppRoutes.splash,
      builder: (context, child) {
        App.init(context);
        return child!;
      },
      debugShowCheckedModeBanner: false,
      onGenerateRoute: onGenerateRoutes,
      routes: appRoutes,
    );
  }
}
