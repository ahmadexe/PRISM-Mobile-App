part of '../bottom_bar.dart';

class _IconUtils {
  static StateMachineController getController(Artboard artboard,
      {stateMachineName = 'State Machine 1'}) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, stateMachineName);
    artboard.addController(controller!);
    return controller;
  }

  static List<_Asset> getBottomNavElements(bool isBusinessUser) {
    return isBusinessUser
        ? bottomNavElementsBusinessUser
        : bottomNavElementsRegularUsers;
  }
}
