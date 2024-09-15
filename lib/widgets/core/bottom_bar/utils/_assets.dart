part of '../bottom_bar.dart';

class _Asset {
  final String artboard, stateMachineName, title, src, path;
  late SMIBool? input;

  _Asset(
    this.src, {
    required this.path,
    required this.artboard,
    required this.stateMachineName,
    required this.title,
  });

  set trigger(SMIBool value) {
    input = value;
  }
}

final bottomNavElementsRegularUsers = [
  _Asset(
    'assets/animated_icons/icons.riv',
    artboard: 'CHAT',
    stateMachineName: 'CHAT_Interactivity',
    title: 'chat',
    path: AppRoutes.home,
  ),
  _Asset(
    'assets/animated_icons/icons.riv',
    artboard: 'SEARCH',
    stateMachineName: 'SEARCH_Interactivity',
    title: 'search',
    path: AppRoutes.explore,
  ),
  _Asset(
    'assets/animated_icons/icons.riv',
    artboard: 'AUDIO',
    stateMachineName: 'AUDIO_Interactivity',
    title: 'audio',
    path: AppRoutes.shoutOuts,
  ),
  _Asset(
    'assets/animated_icons/icons.riv',
    artboard: 'BELL',
    stateMachineName: 'BELL_Interactivity',
    title: 'bell',
    path: AppRoutes.notifications,
  ),
  _Asset(
    'assets/animated_icons/icons.riv',
    artboard: 'USER',
    stateMachineName: 'USER_Interactivity',
    title: 'user',
    path: AppRoutes.profile,
  ),
];

final bottomNavElementsBusinessUser = [
    _Asset(
    'assets/animated_icons/icons.riv',
    artboard: 'CHAT',
    stateMachineName: 'CHAT_Interactivity',
    title: 'chat',
    path: AppRoutes.home,
  ),
  _Asset(
    'assets/animated_icons/icons.riv',
    artboard: 'SEARCH',
    stateMachineName: 'SEARCH_Interactivity',
    title: 'search',
    path: AppRoutes.explore,
  ),
  _Asset(
    'assets/animated_icons/icons.riv',
    artboard: 'TIMER',
    stateMachineName: 'TIMER_Interactivity',
    title: 'timer',
    path: AppRoutes.myJobs,
  ),
  _Asset(
    'assets/animated_icons/icons.riv',
    artboard: 'BELL',
    stateMachineName: 'BELL_Interactivity',
    title: 'bell',
    path: AppRoutes.notifications,
  ),
  _Asset(
    'assets/animated_icons/icons.riv',
    artboard: 'USER',
    stateMachineName: 'USER_Interactivity',
    title: 'user',
    path: AppRoutes.profile,
  ),
];
