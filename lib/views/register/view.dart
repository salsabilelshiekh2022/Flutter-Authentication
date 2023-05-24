import 'dart:core';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerce_application/views/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants.dart';
import '../../core/functions/navigation.dart';
import '../../core/functions/showSnacBar.dart';
import '../../core/functions/validator.dart';
import '../../core/utils/casheData/casheData.dart';
import '../../core/utils/routes.dart';
import '../widgets/app_button.dart';
import '../widgets/social_media_button.dart';
import '../widgets/app_text_form_field.dart';
import 'cubit/register_cubit.dart';
import 'cubit/register_states.dart';
import '../../constants.dart' as constants;
import '../widgets/app_loading_button.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final height = getHeight(context);

    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
          listener: (context, state) {
        if (state is RegisterSuccessState) {
          if (state.user.status) {
            CasheData.setData(key: 'token', value: state.user.data!.token);
            debugPrint('save');
            Navigation.pushAndRemove(context, AppRoutes.homePageRoute);
          } else {
            showSnacBar(context, state.user.message, constants.error);
          }
        }
      }, builder: (context, state) {
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
                  key: formKey,
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
                          controller: nameController,
                          hintText: 'Name',
                          validator: (value) {
                            return Validator.validateName(value);
                          }),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomTextFormField(
                          controller: phoneController,
                          hintText: 'Phone',
                          validator: (value) {
                            return Validator.validatePhone(value);
                          }),
                      CustomTextFormField(
                          controller: emailController,
                          hintText: 'Email',
                          validator: (value) {
                            return Validator.validateEmail(value);
                          }),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomTextFormField(
                          controller: passwordController,
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
                      ConditionalBuilder(
                        condition: state is! RegisterLoadingState,
                        builder: (context) => CustomButton(
                          title: 'SIGNUP',
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              try {
                                formKey.currentState!.save();
                                BlocProvider.of<RegisterCubit>(context)
                                    .userRegister(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        name: nameController.text,
                                        phone: phoneController.text);
                              } catch (e) {
                                debugPrint('error is ${e.toString()}');
                              }
                            }
                          },
                        ),
                        fallback: (context) => const AppLoadingButton(),
                      ),
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
