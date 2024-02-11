import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kartal/kartal.dart';
import '../ui/general_radius.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final double? width;
  final double? height;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final Color? prefixIconColor;
  final Color? suffixIconColor;
  final TextStyle? hintTextStyle;
  final bool? canHaveSpace;
  final bool isObsecure;
  final TextInputType keyboardType;
  final Function()? onTap;
  final bool? isFilled;
  final bool? hasFocus;
  final bool? enabled;
  final List<TextInputFormatter>? inputFormatters;
  const CustomTextFormField(
      {super.key,
      required this.controller,
      this.validator,
      this.height,
      this.width,
      this.canHaveSpace = false,
      this.hintText,
      this.prefixIcon,
      this.prefixIconColor,
      this.suffixIcon,
      this.suffixIconColor,
      this.hintTextStyle,
      this.onTap,
      this.isFilled,
      this.hasFocus,
      this.enabled = true,
      required this.isObsecure,
      this.inputFormatters,
      this.keyboardType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: hasFocus == true
          ? AutovalidateMode.disabled
          : AutovalidateMode.onUserInteraction,
      onTap: onTap,
      cursorColor:const Color(0xFF717C84),
      enabled: enabled,
      style:
          context.general.textTheme.labelLarge?.copyWith(color: Colors.white),
      controller: controller,
      inputFormatters: inputFormatters,
      validator: validator,
      obscureText: isObsecure,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        errorMaxLines: 3,
        errorStyle: context.general.textTheme.bodyMedium
            ?.copyWith(color: context.general.colorScheme.error),
        hintStyle: const TextStyle(color: Color(0xFF717C84)),
        filled: true,
        fillColor: const Color(0xFF283948),
        enabledBorder: const OutlineInputBorder(
          borderRadius:  GeneralRadius.authTextFieldRadius(),
          borderSide: BorderSide.none,
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: const GeneralRadius.authTextFieldRadius(),
          borderSide:
              BorderSide(color: context.general.colorScheme.tertiaryContainer),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const GeneralRadius.authTextFieldRadius(),
          borderSide: BorderSide(color: context.general.colorScheme.primary),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: const GeneralRadius.authTextFieldRadius(),
          borderSide: BorderSide(color: context.general.colorScheme.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: const GeneralRadius.authTextFieldRadius(),
          borderSide: BorderSide(color: context.general.colorScheme.error),
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        prefixIconColor: prefixIconColor,
        suffixIconColor: suffixIconColor,
      ),
    );
  }
}
