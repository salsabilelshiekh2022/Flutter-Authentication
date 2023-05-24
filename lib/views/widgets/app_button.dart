import 'package:ecommerce_application/views/widgets/app_text.dart';
import 'package:flutter/material.dart';

import '../../constants.dart' as constants;

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, this.onTap, required this.title});
  final void Function()? onTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            color: constants.primaryAppColor),
        child: Align(
            alignment: Alignment.center,
            child: TextApp(
              text: title,
              color: constants.white,
            )),
      ),
    );
  }
}
