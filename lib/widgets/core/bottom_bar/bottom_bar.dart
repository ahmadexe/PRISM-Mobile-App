import 'package:flutter/material.dart';
import 'package:prism/configs/configs.dart';
import 'package:rive/rive.dart';

part 'utils/_icon_utils.dart';
part 'utils/_assets.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    App.init(context);
    return Padding(
      padding: Space.hf(10),
      child: Container(
        height: AppDimensions.normalize(21),
        decoration: BoxDecoration(
          color: AppTheme.c.fieldLight,
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
                  bottomNavElements[index].input!.change(true);
                  Future.delayed(const Duration(seconds: 1), () {
                    bottomNavElements[index].input!.change(false);
                  });
                },
                child: SizedBox(
                  height: AppDimensions.normalize(14),
                  width: AppDimensions.normalize(14),
                  child: RiveAnimation.asset(
                    bottomNavElements[index].src,
                    artboard: bottomNavElements[index].artboard,
                    onInit: (artboard) {
                      StateMachineController controller =
                          _IconUtils.getController(artboard,
                              stateMachineName:
                                  bottomNavElements[index].stateMachineName);
                      bottomNavElements[index].input =
                          controller.findSMI('active') as SMIBool;
                    },
                  ),
                ),
              ),
            ),

            // [

            // ],
          ),
        ),
      ),
    );
    // );
  }
}
