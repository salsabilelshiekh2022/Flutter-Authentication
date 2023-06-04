import 'dart:core';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerce_application/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants.dart';
import '../../core/functions/navigation.dart';
import '../../core/functions/validator.dart';
import '../../core/router/routes.dart';
import '../../widgets/app_button.dart';
import '../../widgets/social_media_button.dart';
import '../../widgets/app_text_form_field.dart';
import 'cubit.dart';
import 'states.dart';
import '../../widgets/app_loading_button.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = getHeight(context);

    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: Builder(builder: (context) {
        final cubit = RegisterCubit.of(context);
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                  top: height * .11,
                  left: 14.0,
                  right: 14,
                  bottom: height * .0418),
              child: SingleChildScrollView(
                child: Form(
                  key: cubit.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextApp(
                        text: "Sign up",
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(
                        height: height * .0899,
                      ),
                      CustomTextFormField(
                          onSave: (data) {
                            cubit.name = data;
                          },
                          hintText: 'Name',
                          validator: (value) {
                            return Validator.validateName(value);
                          }),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomTextFormField(
                          onSave: (data) {
                            cubit.phone = data;
                          },
                          hintText: 'Phone',
                          validator: (value) {
                            return Validator.validatePhone(value);
                          }),
                      CustomTextFormField(
                          onSave: (data) {
                            cubit.email = data;
                          },
                          hintText: 'Email',
                          validator: (value) {
                            return Validator.validateEmail(value);
                          }),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomTextFormField(
                          onSave: (data) {
                            cubit.password = data;
                          },
                          hintText: 'Password',
                          validator: (value) {
                            return Validator.validatePassword(value);
                          }),
                      const SizedBox(
                        height: 16,
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: () {
                            Navigation.pushNamed(
                                context, AppRoutes.loginPageRoute);
                          },
                          child: const TextApp(
                            text: 'Already have an account? ',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * .034482,
                      ),
                      BlocBuilder(
                          bloc: cubit,
                          builder: (context, state) {
                            return ConditionalBuilder(
                              condition: state is! RegisterLoadingState,
                              builder: (context) => CustomButton(
                                  title: 'SIGNUP',
                                  onTap: () {
                                    cubit.register();
                                  }),
                              fallback: (context) => const AppLoadingButton(),
                            );
                          }),
                      SizedBox(
                        height: height * .085,
                      ),
                      const Align(
                        alignment: Alignment.center,
                        child: TextApp(
                          text: 'Or sign up with social account ',
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SocialMediaButton(
                              imagePath:
                                  'assets/images/google-svgrepo-com.svg'),
                          SizedBox(
                            width: 16,
                          ),
                          SocialMediaButton(
                            imagePath: 'assets/images/facebook-svgrepo-com.svg',
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
