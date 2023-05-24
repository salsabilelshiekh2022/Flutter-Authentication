import 'package:flutter/material.dart';
import '../../constants.dart' as constants;

class AppLoadingButton extends StatelessWidget {
  const AppLoadingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 48,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            color: constants.primaryAppColor),
        child: const Align(
          alignment: Alignment.center,
          child: CircularProgressIndicator(color: constants.white),
        ),
      ),
    );
  }
}
