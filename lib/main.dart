import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';
import 'package:prism/blocs/auth/bloc.dart';
import 'package:prism/configs/configs.dart';
import 'package:prism/firebase_options.dart';
import 'package:prism/router/router.dart';
import 'package:prism/router/routes.dart';
import 'configs/configs.dart' as theme;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
      ],
      child: MaterialApp(
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
      ),
    );
  }
}
