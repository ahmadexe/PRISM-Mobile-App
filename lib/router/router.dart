import 'package:prism/screens/buy_coins/buy_coins.dart';
import 'package:prism/screens/generate_wallet/generate_wallet.dart';
import 'package:prism/screens/transactions/transactions.dart';
import 'package:prism/screens/transaction/transaction.dart';
import 'package:prism/screens/wallet/wallet.dart';
import 'package:prism/screens/view_applications/view_applications.dart';
import 'package:prism/screens/jobs_detail/jobs_detail.dart';
import 'package:prism/screens/create_job/create_job.dart';
import 'package:prism/screens/my_jobs/my_jobs.dart';
import 'package:prism/screens/resume_analysis/resume_analysis.dart';
import 'package:prism/screens/upload_resume/upload_resume.dart';
import 'package:prism/screens/chatbot/chatbot.dart';
import 'package:prism/screens/settings/settings.dart';
import 'package:prism/screens/chat/chat.dart';
import 'package:prism/screens/conversations/conversations.dart';
import 'package:prism/screens/create_post/create_post.dart';
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
  AppRoutes.buyCoins: (_) => const BuyCoinsScreen(),
  AppRoutes.generateWallet: (_) => const GenerateWalletScreen(),
  AppRoutes.transactions: (_) => const TransactionsScreen(),
  AppRoutes.transaction: (_) => const TransactionScreen(),
  AppRoutes.wallet: (_) => const WalletScreen(),
  AppRoutes.viewApplications: (_) => const ViewApplicationsScreen(),
  AppRoutes.jobsDetail: (_) => const JobsDetailScreen(),
  AppRoutes.createJob: (_) => const CreateJobScreen(),
  AppRoutes.resumeAnalysis: (_) => const ResumeAnalysisScreen(),
  AppRoutes.uploadResume: (_) => const UploadResumeScreen(),
  AppRoutes.chatbot: (_) => const ChatbotScreen(),
  AppRoutes.settings: (_) => const SettingsScreen(),
  AppRoutes.chat: (_) => const ChatScreen(),
  AppRoutes.conversations: (_) => const ConversationsScreen(),
  AppRoutes.createPost: (_) => const CreatePostScreen(),
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

    case AppRoutes.myJobs:
      return FadeRoute(
        settings: settings,
        child: const MyJobsScreen(),
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
