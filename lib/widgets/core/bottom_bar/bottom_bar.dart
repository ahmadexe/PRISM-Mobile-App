import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';
import 'package:prism/blocs/auth/bloc.dart';
import 'package:prism/configs/configs.dart';
import 'package:prism/router/routes.dart';
import 'package:rive/rive.dart';

part 'utils/_icon_utils.dart';
part 'utils/_assets.dart';

part 'widgets/_animated_bar.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    App.init(context);
    final currentRoute = NavigationHistoryObserver().top;
    final currentPath = currentRoute!.settings.name;

    final authBloc = BlocProvider.of<AuthBloc>(context);
    final user = authBloc.state.user!;

    final bottomNavElements = _IconUtils.getBottomNavElements(user.isBusinessAcc);

    return Padding(
      padding: Space.hf(10),
      child: Container(
        height: AppDimensions.normalize(21),
        decoration: BoxDecoration(
          color: AppTheme.c.fieldLight!.withOpacity(.75),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: Space.hf(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              bottomNavElements.length,
              (index) => GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(
                    context,
                    bottomNavElements[index].path,
                  );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _AnimatedBar(
                      isActive: bottomNavElements[index].path == currentPath,
                    ),
                    SizedBox(
                      height: AppDimensions.normalize(13),
                      width: AppDimensions.normalize(13),
                      child: Opacity(
                        opacity: currentPath == bottomNavElements[index].path
                            ? 1
                            : 0.5,
                        child: RiveAnimation.asset(
                          bottomNavElements[index].src,
                          artboard: bottomNavElements[index].artboard,
                          onInit: (artboard) {
                            StateMachineController controller =
                                _IconUtils.getController(artboard,
                                    stateMachineName: bottomNavElements[index]
                                        .stateMachineName);
                            bottomNavElements[index].input =
                                controller.findSMI('active') as SMIBool;
                            if (bottomNavElements[index].path == currentPath) {
                              bottomNavElements[index].input!.change(true);
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
