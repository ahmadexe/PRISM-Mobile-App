import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';
import 'package:prism/blocs/auth/bloc.dart';
import 'package:prism/blocs/comments/bloc.dart';
import 'package:prism/blocs/posts/bloc.dart';
import 'package:prism/configs/configs.dart';
import 'package:prism/firebase_options.dart';
import 'package:prism/providers/media_provider.dart';
import 'package:prism/router/router.dart';
import 'package:prism/router/routes.dart';
import 'package:provider/provider.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MediaProvider>(
            create: (context) => MediaProvider()),
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => PostsBloc()),
        BlocProvider(create: (context) => CommentsBloc()),
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
