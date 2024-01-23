import 'package:flutter/material.dart';
import 'package:prism/configs/configs.dart';

part 'enums.dart';

class AppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final Color? backgroundColor;
  final double? width;
  final double? height;
  final TextStyle? textStyle;
  final ButtonType? buttonType;
  const AppButton({
    required this.label,
    required this.onPressed,
    this.height,
    this.width,
    this.backgroundColor,
    this.textStyle,
    this.buttonType = ButtonType.primary,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    App.init(context);
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: width ?? double.infinity,
        height: height ?? AppDimensions.normalize(19),
        decoration: buttonType == ButtonType.secondary
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(AppDimensions.ratio * 5),
                color: backgroundColor ?? AppTheme.c.primary,
              )
            : buttonType == ButtonType.bordered
                ? BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(AppDimensions.ratio * 100),
                    border: Border.all(
                      color: AppTheme.c.primary!,
                      width: 1,
                    ),
                  )
                : BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(AppDimensions.ratio * 100),
                    color: backgroundColor ?? AppTheme.c.primary,
                  ),
        child: Center(
          child: Text(
            'Button',
            style: textStyle ?? AppText.b1bm,
          ),
        ),
      ),
    );
  }
}
