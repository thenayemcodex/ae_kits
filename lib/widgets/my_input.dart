
import 'package:ae_kits/theme/app_color.dart';
import 'package:ae_kits/theme/my_text_styles.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyInput extends StatelessWidget {
  final double? height;
  final double? width;
  final TextEditingController controller;
  final String? label;
  final TextStyle? labelStyle;
  final TextStyle? style;
  final String? placeholder;
  final bool? isEnabled;
  final bool? isReadOnly;
  final bool? isObscure;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final double? borderWidth;
  final Color? borderColer;
  final Color? fillColor;
  final Color? textColor;
  final TextInputType? inputType;
  final int? maxLine;

  final BorderRadius? borderRadius;
  Function(String text) onChange;
  Function()? onEditingComplete;
  MyInput({
    super.key,
    required this.controller,
    this.height,
    this.width,
    this.label,
    this.labelStyle,
    this.style,
    this.placeholder,
    this.isEnabled,
    this.isReadOnly,
    this.isObscure,
    this.suffixIcon,
    this.prefixIcon,
    this.borderWidth,
    this.borderColer = Colors.grey,
    this.fillColor,
    this.textColor,
    this.inputType,
    this.maxLine,
    this.borderRadius,
    required this.onChange,
    this.onEditingComplete,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextField(
        controller: controller,
        autofocus: true,
        cursorColor: AppColor.primary,
        enabled: isEnabled,
        readOnly: isReadOnly ?? false,
        maxLines: maxLine ?? 1,
        obscureText: isObscure ?? false,
        enableSuggestions: true,
        obscuringCharacter: "#",
        textCapitalization: TextCapitalization.sentences,
        keyboardType: inputType,
        onChanged: (value) {
          onChange(controller.text);
        },
        onEditingComplete: onEditingComplete,
        style: style ?? MyTextStyles.body.copyWith(color: textColor ?? AppColor.primaryText),
        decoration: InputDecoration(
          filled: true,
          fillColor: fillColor,
          hintText: placeholder,
          hintStyle: labelStyle,
          labelText: label,
          labelStyle: labelStyle,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          errorBorder: OutlineInputBorder(
            borderRadius: borderRadius ?? BorderRadius.zero,
            borderSide: BorderSide(
              width: borderWidth ?? 1.0,
              color: AppColor.failed,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: borderRadius ?? BorderRadius.zero,
            borderSide: BorderSide(
              width: borderWidth ?? 1.0,
              color: borderColer ?? AppColor.grey,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: borderRadius ?? BorderRadius.zero,
            borderSide: BorderSide(
              width: borderWidth ?? 1.0,
              color: borderColer ?? AppColor.grey,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: borderRadius ?? BorderRadius.zero,
            borderSide: BorderSide(
              width: borderWidth ?? 1.0,
              color: borderColer ?? AppColor.grey,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: borderRadius ?? BorderRadius.zero,
            borderSide: BorderSide(
              width: borderWidth ?? 1.0,
              color: (borderColer ?? Colors.transparent).withOpacity(.5),
            ),
          ),
        ),
      ),
    );
  }
}
