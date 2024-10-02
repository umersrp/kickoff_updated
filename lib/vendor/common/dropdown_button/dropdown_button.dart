import 'package:appkickoff/vendor/utils/constants/app_colors.dart';
import 'package:appkickoff/vendor/utils/constants/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectionPopupModel {
  SelectionPopupModel(
      {this.id, required this.title, this.value, this.isSelected = false});

  int? id;
  String title;
  dynamic value;
  bool isSelected;
}

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({
    super.key,
    this.value,
    this.alignment,
    this.width,
    this.boxDecoration,
    this.focusNode,
    this.icon,
    this.iconSize,
    this.autofocus = false,
    this.textStyle,
    this.hintText,
    this.hintStyle,
    this.items,
    this.prefix,
    this.prefixConstraints,
    this.contentPadding,
    this.borderDecoration,
    this.fillColor,
    this.filled = true,
    this.validator,
    this.onChanged,
  });

  final String? value;
  final Alignment? alignment;
  final double? width;
  final BoxDecoration? boxDecoration;
  final FocusNode? focusNode;
  final Widget? icon;
  final double? iconSize;
  final bool? autofocus;
  final TextStyle? textStyle;
  final String? hintText;
  final TextStyle? hintStyle;
  final List<String>? items;
  final Widget? prefix;
  final BoxConstraints? prefixConstraints;
  final EdgeInsets? contentPadding;
  final InputBorder? borderDecoration;
  final Color? fillColor;
  final bool? filled;
  final FormFieldValidator<String>? validator;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(alignment: alignment ?? Alignment.center, child: dropDownWidget)
        : dropDownWidget;
  }

  Widget get dropDownWidget => Container(
        // color: Colors.red,
        width: width ?? double.maxFinite,
        decoration: boxDecoration,
        child: DropdownButtonFormField<String>(
          value: value,
          focusNode: focusNode,
          icon: icon,
          iconSize: iconSize ?? 24,
          autofocus: autofocus!,
          isExpanded: true,
          style: textStyle ??
              Theme.of(Get.context!).textTheme.labelLarge!.copyWith(
                    fontFamily: 'Inter',
                    fontSize: 15.h,
                  ),
          hint: Text(
            hintText ?? "",
            style: hintStyle ??
                Theme.of(Get.context!).textTheme.labelLarge!.copyWith(
                      fontFamily: 'Inter',
                      fontSize: 15.h,
                    ),
            overflow: TextOverflow.ellipsis,
          ),
          items: items?.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                overflow: TextOverflow.ellipsis,
                style: hintStyle ??
                    Theme.of(Get.context!).textTheme.labelLarge!.copyWith(
                          fontFamily: 'Inter',
                          fontSize: 15.h,
                        ),
              ),
            );
          }).toList(),
          validator: validator,
          decoration: decoration,
          onChanged: (String? value) {
            onChanged!(value!);
          },
        ),
      );

  InputDecoration get decoration => InputDecoration(
        prefixIcon: prefix,
        prefixIconConstraints: prefixConstraints,
        isDense: true,
        contentPadding: contentPadding ?? EdgeInsets.all(0.h),
        fillColor: fillColor ?? AppColors.gray50,
        filled: filled,
        // border: InputBorder.none,
        // errorBorder: InputBorder.none,
        // enabledBorder: InputBorder.none,
        // focusedBorder: InputBorder.none,
        // border: borderDecoration ??
        //     OutlineInputBorder(
        //       borderRadius: BorderRadius.circular(0.h),
        //       borderSide: BorderSide(
        //         color: AppColors.primary,
        //         width: 1,
        //       ),
        //     ),
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
}
