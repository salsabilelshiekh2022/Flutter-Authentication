import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../core/functions/navigation.dart';
import '../../core/functions/validator.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_text_form_field.dart';
import '../../widgets/app_text.dart';

class ForgetPasswordPage extends StatelessWidget {
  ForgetPasswordPage({super.key});
  final GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final height = getHeight(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigation.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.symmetric(vertical: height * .0418, horizontal: 14.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextApp(
                  text: "Forgot password",
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: height * .1071,
                ),
                const TextApp(
                    text:
                        'Please, enter your email address. You will receive a link to create a new password via email.'),
                const SizedBox(
                  height: 16,
                ),
                CustomTextFormField(
                    hintText: 'Email',
                    validator: (value) {
                      return Validator.validateEmail(value);
                    }),
                SizedBox(
                  height: height * .0862,
                ),
                CustomButton(
                  title: 'SEND',
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // String? emailValidate(String? value) {
  //   if (value!.isEmpty) {
  //     return "Field is required";
  //   } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
  //     return "Enter correct email";
  //   } else {
  //     return null;
  //   }
  // }
}
