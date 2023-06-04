import 'package:flutter/material.dart';

import '../constants.dart' as constants;
import '../core/functions/input_border.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.hintText,
    this.validator,
    this.onSave,
    this.controller,
    this.onChange,
    this.onSubmitted,
  });
  final String? hintText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function(String?)? onSave;
  final void Function(String)? onChange;
  final void Function(String?)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadiusDirectional.circular(4),
      child: TextFormField(
        enabled: true,
        onSaved: onSave,
        onFieldSubmitted: onSubmitted,
        onChanged: onChange,
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          hintText: hintText,
          fillColor: constants.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: const BorderSide(
              color: constants.white,
            ),
          ),
          enabledBorder: inputBorder(constants.white),
          focusedBorder: inputBorder(constants.primaryAppColor),
          errorBorder: inputBorder(constants.error),
          focusedErrorBorder: inputBorder(constants.error),
        ),
      ),
    );
  }
}
