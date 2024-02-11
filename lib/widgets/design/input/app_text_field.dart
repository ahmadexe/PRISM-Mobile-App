import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:prism/configs/configs.dart';

class AppTextField extends StatefulWidget {
  final String name;
  final TextEditingController? controller;
  final String? hint;
  final bool? isPass;
  final bool? enabled;
  final double? width;
  final String? label;

  final bool? autoFocus;
  final FocusNode? node;

  final bool readOnly;

  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? initialValue;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;

  final String? errorText;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  final void Function()? onEditComplete;
  final List<TextInputFormatter>? inputformatters;
  final bool isDarkField;
  final void Function()? onTap;

  final int? maxLines;

  const AppTextField({
    Key? key,
    this.node,
    this.label,
    this.controller,
    this.enabled,
    this.errorText,
    this.autoFocus,
    this.prefixIcon,
    this.onChanged,
    this.onEditComplete,
    this.initialValue,
    this.validator,
    this.suffixIcon,
    this.onTap,
    required this.name,
    this.hint,
    this.readOnly = false,
    this.isPass = false,
    this.textInputType,
    this.inputformatters,
    this.width = double.infinity,
    this.textInputAction = TextInputAction.done,
    this.textCapitalization = TextCapitalization.sentences,
    this.isDarkField = false,
    this.maxLines,
  }) : super(key: key);

  @override
  AppTextFieldState createState() => AppTextFieldState();
}

class AppTextFieldState extends State<AppTextField> {
  bool show = false;

  @override
  void initState() {
    show = widget.isPass!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    App.init(context);
    ScreenUtil.init(context, designSize: const Size(428, 926));

    final textColor = AppTheme.c.white!;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: AppText.b2!.cl(
              AppTheme.c.white!,
            ),
          ),
          Space.y!,
        ],
        FormBuilderTextField(
          maxLines: widget.maxLines ?? 1,
          controller: widget.controller,
          inputFormatters: widget.inputformatters,
          style: AppText.b2!.cl(textColor),
          cursorColor: AppTheme.c.white,
          onTap: widget.onTap,
          textCapitalization: widget.textCapitalization,
          enabled: widget.enabled ?? true,
          initialValue: widget.initialValue,
          name: widget.name,
          autofocus: widget.autoFocus ?? false,
          textInputAction: widget.textInputAction,
          keyboardType: widget.textInputType,
          focusNode: widget.node,
          readOnly: widget.readOnly,
          obscureText: show,
          decoration: InputDecoration(
            errorText: widget.errorText,
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.suffixIcon ??
                (widget.isPass!
                    ? IconButton(
                        splashRadius: AppDimensions.normalize(8),
                        onPressed: () {
                          setState(() {
                            show = !show;
                          });
                        },
                        icon: Icon(
                          show ? Icons.visibility_off : Icons.visibility,
                          size: AppDimensions.normalize(7),
                        ),
                      )
                    : null),
            filled: true,
            fillColor: widget.isDarkField
                ? AppTheme.c.fieldDark
                : AppTheme.c.fieldLight,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
            hintText: widget.hint,
            hintStyle: AppText.b2!.cl(AppTheme.c.textGrey!),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                width: 0,
                color: Colors.transparent,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: widget.isDarkField
                    ? AppTheme.c.grey!
                    : AppTheme.c.backgroundSub!,
                width: AppDimensions.normalize(.5),
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.red.withAlpha(200),
                width: AppDimensions.normalize(0.5),
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.red.withAlpha(200),
                width: AppDimensions.normalize(0.5),
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                width: AppDimensions.normalize(0.75),
                color: AppTheme.c.textLight!.withAlpha(100),
              ),
            ),
          ),
          validator: widget.validator,
          onChanged: widget.onChanged,
          onEditingComplete: widget.onEditComplete,
        ),
      ],
    );
  }
}
