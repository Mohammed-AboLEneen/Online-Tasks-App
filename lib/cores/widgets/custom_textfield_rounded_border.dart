import 'package:flutter/material.dart';

import '../../constents.dart';
import '../utlis/app_fonts.dart';

class CustomTextFieldRoundedBorder extends StatelessWidget {
  final String? hint;
  final double? hintTextSize;
  final TextStyle? hintStyle;
  final String? labelText;
  final void Function()? onTap;
  final EdgeInsetsGeometry? padding;
  final Icon? icon;
  final Color? textColor;
  final Color? borderColor;
  final Color? errorBorderColor;
  final Color? focusedBorderColor;
  final Color? enabledBorderColor;
  final int? maxLines;
  final int? minLines;
  final TextInputAction? textInputAction;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final double? topRight;
  final double? topLeft;
  final double? bottomRight;
  final double? bottomLeft;
  final TextInputType? keyboardType;
  final double? textFieldHeight;
  final double? textFieldWidth;
  final EdgeInsetsGeometry? textFieldMargin;
  final TextDirection? textDirection;
  final TextAlign? textAlign;
  final bool? obscureText;
  final bool? isReadOnly;
  final Color? backgroundColor;
  final double? textSize;
  final String? Function(String?)? validator;
  final void Function(PointerDownEvent)? onTapOutside;

  const CustomTextFieldRoundedBorder(
      {super.key,
      this.hint,
      this.padding,
      this.icon,
      this.onChanged,
      this.borderColor,
      this.controller,
      this.onTap,
      this.maxLines,
      this.minLines,
      this.textInputAction,
      this.suffixIcon,
      this.topRight,
      this.topLeft,
      this.bottomRight,
      this.bottomLeft,
      this.hintTextSize,
      this.keyboardType,
      this.textFieldHeight,
      this.textFieldWidth,
      this.textFieldMargin,
      this.textDirection,
      this.textAlign,
      this.textColor,
      this.obscureText,
      this.prefixIcon,
      this.isReadOnly,
      this.backgroundColor,
      this.textSize,
      this.validator,
      this.onTapOutside,
      this.hintStyle,
      this.errorBorderColor,
      this.focusedBorderColor,
      this.enabledBorderColor,
      this.labelText});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: textFieldWidth ?? MediaQuery.sizeOf(context).width,
      height: textFieldHeight,
      margin: textFieldMargin ?? EdgeInsets.zero,
      child: Align(
        alignment: Alignment.topCenter,
        child: TextFormField(
            textAlign: textAlign ?? TextAlign.start,
            obscureText: obscureText ?? false,
            onTapOutside: onTapOutside,
            readOnly: isReadOnly ?? false,
            validator: validator,
            textInputAction: textInputAction ?? TextInputAction.next,
            textDirection: textDirection,
            onTap: onTap,
            keyboardType: keyboardType,
            controller: controller,
            maxLines: maxLines,
            minLines: minLines,
            textAlignVertical: TextAlignVertical.top,
            cursorColor: mainColor,
            onChanged: onChanged,
            style: AppFonts.textStyle15Regular
                ?.copyWith(color: textColor ?? Colors.black.withOpacity(.8)),
            decoration: InputDecoration(
              filled: true,
              fillColor: backgroundColor ?? Colors.transparent,

              label: labelText == null
                  ? null
                  : Text(
                      labelText!,
                      style: AppFonts.textStyle15Regular
                          ?.copyWith(color: Colors.grey.withOpacity(.9)),
                    ),

              // Change this
              hintText: hint,
              errorStyle: TextStyle(
                color: Colors.red.withOpacity(.7),
              ),
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: borderColor ?? Colors.black.withOpacity(.7),
                  ),
                  borderRadius: borderRadius()),
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: errorBorderColor ?? errorTextFormFieldColorBorder,
                  ),
                  borderRadius: borderRadius()),
              focusedBorder: OutlineInputBorder(
                  borderRadius: borderRadius(),
                  borderSide: BorderSide(
                      color:
                          focusedBorderColor ?? focusTextFormFieldColorBorder,
                      width: 2)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: borderRadius(),
                  borderSide: BorderSide(
                      color:
                          enabledBorderColor ?? enableTextFormFieldColorBorder,
                      width: 1.2)),

              hintStyle: hintStyle ??
                  AppFonts.textStyle15Regular?.copyWith(
                      color: Colors.grey.withOpacity(.9),
                      fontSize: hintTextSize,
                      fontWeight: FontWeight.normal),
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
              contentPadding: padding,
            )),
      ),
    );
  }

  BorderRadius borderRadius() {
    return BorderRadius.only(
      topLeft: Radius.circular(topLeft ?? 20),
      topRight: Radius.circular(topRight ?? 20),
      bottomLeft: Radius.circular(bottomLeft ?? 20),
      bottomRight: Radius.circular(bottomRight ?? 20),
    );
  }
}
