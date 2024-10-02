import 'package:appkickoff/vendor/utils/constants/app_colors.dart';
import 'package:appkickoff/vendor/utils/constants/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.alignment,
    this.width,
    this.boxDecoration,
    this.scrollPadding,
    this.controller,
    this.focusNode,
    this.autofocus = false,
    this.textStyle,
    this.obscureText = false,
    this.readOnly = false,
    this.onTap,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.maxLines,
    this.hintText,
    this.hintStyle,
    this.prefix,
    this.prefixConstraints,
    this.suffix,
    this.suffixConstraints,
    this.contentPadding,
    this.borderDecoration,
    this.fillColor,
    this.filled = false,
    this.validator,
    this.isDense = false,
    this.label,
  });

  final Alignment? alignment;
  final double? width;
  final BoxDecoration? boxDecoration;
  final TextEditingController? scrollPadding;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool? autofocus;
  final TextStyle? textStyle;
  final bool? obscureText;
  final bool? readOnly;
  final VoidCallback? onTap;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final int? maxLines;
  final String? hintText;
  final TextStyle? hintStyle;
  final Widget? prefix;
  final BoxConstraints? prefixConstraints;
  final Widget? suffix;
  final BoxConstraints? suffixConstraints;
  final EdgeInsets? contentPadding;
  final InputBorder? borderDecoration;
  final Color? fillColor;
  final bool? filled;
  final FormFieldValidator<String>? validator;
  final bool isDense;
  final Widget? label;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: textFormFieldWidget)
        : textFormFieldWidget;
  }

  ///
  Widget get textFormFieldWidget => Container(
        // color: Colors.amber,
        // height: 50.h,
        width: width ?? double.maxFinite,
        decoration: boxDecoration,
        child: TextFormField(
          // scrollPadding: EdgeInsets.only(
          //     bottom: MediaQuery.of(Get.context!).viewInsets.bottom),
          controller: controller,
          focusNode: focusNode,
          onTapOutside: (event) {
            if (focusNode != null) {
              focusNode?.unfocus();
            } else {
              FocusManager.instance.primaryFocus?.unfocus();
            }
          },
          autofocus: autofocus!,
          // style: textStyle ?? Theme.of(Get.context!).textTheme.labelLarge,
          style: textStyle ??
              Theme.of(Get.context!).textTheme.labelLarge!.copyWith(
                    fontFamily: 'Inter',
                    fontSize: 15.h,
                  ),

          obscureText: obscureText!,
          readOnly: readOnly!,
          onTap: () {
            onTap?.call();
          },
          textInputAction: textInputAction,
          keyboardType: textInputType,
          maxLines: maxLines ?? 1,
          decoration: decoration,
          validator: validator,
        ),
      );

  ///
  InputDecoration get decoration => InputDecoration(
        hintText: hintText ?? "",
        hintStyle: hintStyle ?? Theme.of(Get.context!).textTheme.titleSmall,
        prefixIcon: prefix,
        prefixIconConstraints: prefixConstraints,
        suffixIcon: suffix,
        suffixIconConstraints: suffixConstraints,
        // isDense: true,
        isDense: isDense,
        contentPadding: contentPadding ?? EdgeInsets.all(10.h),
        fillColor: fillColor ?? AppColors.gray50,
        filled: filled,

        errorStyle: TextStyle(
          color: Colors.redAccent,
          fontSize: 12.h,
        ),
        //

        border: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.h),
              borderSide: BorderSide(
                color: AppColors.onPrimaryContainer,
                width: 1,
              ),
            ),
        enabledBorder: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.h),
              borderSide: BorderSide(
                color: AppColors.onPrimaryContainer,
                width: 1,
              ),
            ),
        focusedBorder: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.h),
            ).copyWith(
              borderSide: BorderSide(
                color: AppColors.primary,
                width: 1,
              ),
            ),
      );

  ///
}
