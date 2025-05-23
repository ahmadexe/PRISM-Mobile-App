import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';
import 'package:prism/blocs/auth/bloc.dart';
import 'package:prism/blocs/chats/bloc.dart';
import 'package:prism/blocs/comments/bloc.dart';
import 'package:prism/blocs/jobs/bloc.dart';
import 'package:prism/blocs/lens/bloc.dart';
import 'package:prism/blocs/blockchain/bloc.dart';
import 'package:prism/blocs/notifications/bloc.dart';
import 'package:prism/blocs/posts/bloc.dart';
import 'package:prism/blocs/text_recognition/bloc.dart';
import 'package:prism/blocs/transaction/transaction_bloc.dart';
import 'package:prism/blocs/wallet/wallet_bloc.dart';
import 'package:prism/configs/configs.dart';
import 'package:prism/firebase_options.dart';
import 'package:prism/providers/job_provider.dart';
import 'package:prism/providers/media_provider.dart';
import 'package:prism/router/router.dart';
import 'package:prism/router/routes.dart';
import 'package:prism/services/notifications/base.dart';
import 'package:provider/provider.dart';
import 'configs/configs.dart' as theme;
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  //
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  NotificationBase.init(flutterLocalNotificationsPlugin);
  //
  final publishableKey = dotenv.env['STRIPE_PUBLISHABLE_KEY'];
  if (publishableKey == null || publishableKey.isEmpty) {
    throw Exception('Stripe publishable key not found');
  }
  Stripe.publishableKey = publishableKey;
  //
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
        ChangeNotifierProvider(create: (context) => JobProvider()),
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => PostsBloc()),
        BlocProvider(create: (context) => CommentsBloc()),
        BlocProvider(create: (context) => ChatsBloc()),
        BlocProvider(create: (context) => LensBloc()),
        BlocProvider(create: (context) => TextRecognitionBloc()),
        BlocProvider(create: (context) => JobsBloc()),
        BlocProvider(create: (context) => NotificationsBloc()),
        BlocProvider(create: (context) => WalletBloc()),
        BlocProvider(create: (create) => TransactionBloc()),
        BlocProvider(create: (create) => BlockchainBloc()),
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
          final notificationService = NotificationBase();
          notificationService.listenNotifications(context);
          return child!;
        },
        debugShowCheckedModeBanner: false,
        onGenerateRoute: onGenerateRoutes,
        routes: appRoutes,
      ),
    );
  }
}
