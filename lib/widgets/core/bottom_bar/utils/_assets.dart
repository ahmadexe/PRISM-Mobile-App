// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../bottom_bar.dart';

class _Asset {
  final String artboard, stateMachineName, title, src;
  late SMIBool? input;

  _Asset(
    this.src, {
    required this.artboard,
    required this.stateMachineName,
    required this.title,
  });

  set trigger(SMIBool value) {
    input = value;
  }
}

final bottomNavElements = [
  _Asset('assets/animated_icons/icons.riv',
      artboard: 'CHAT', stateMachineName: 'CHAT_Interactivity', title: 'chat'),
  _Asset('assets/animated_icons/icons.riv',
      artboard: 'SEARCH',
      stateMachineName: 'SEARCH_Interactivity',
      title: 'search'),
  _Asset('assets/animated_icons/icons.riv',
      artboard: 'AUDIO',
      stateMachineName: 'AUDIO_Interactivity',
      title: 'audio'),
  _Asset('assets/animated_icons/icons.riv',
      artboard: 'BELL', stateMachineName: 'BELL_Interactivity', title: 'bell'),
  _Asset('assets/animated_icons/icons.riv',
      artboard: 'USER', stateMachineName: 'USER_Interactivity', title: 'user'),
];
