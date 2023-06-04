import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerce_application/views/login/cubit.dart';
import 'package:ecommerce_application/views/login/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/app_loading_button.dart';
import '../../constants.dart';
import '../../core/functions/navigation.dart';
import '../../core/functions/validator.dart';
import '../../core/router/routes.dart';
import '../../widgets/app_button.dart';
import '../../widgets/social_media_button.dart';
import '../../widgets/app_text_form_field.dart';
import '../../widgets/app_text.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = getHeight(context);

    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Builder(
        builder: (context) {
          final cubit = LoginCubit.of(context);
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
                padding: EdgeInsets.symmetric(
                    vertical: height * .0418, horizontal: 14.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: cubit.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TextApp(
                          text: "Login",
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(
                          height: 73,
                        ),
                        CustomTextFormField(
                            hintText: 'Email',
                            onSave: (data) {
                              cubit.email = data;
                            },
                            validator: (value) {
                              return Validator.validateEmail(value);
                            }),
                        const SizedBox(
                          height: 8,
                        ),
                        CustomTextFormField(
                            hintText: 'Password',
                            onSave: (data) {
                              cubit.password = data;
                            },
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
                                  context, AppRoutes.forgetPasswordRoute);
                            },
                            child: const TextApp(
                              text: 'Forgot your password? ',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * .03448,
                        ),
                        BlocBuilder(
                            bloc: cubit,
                            builder: (context, state) {
                              return ConditionalBuilder(
                                condition: state is! LoginLoadingState,
                                builder: (context) => CustomButton(
                                  title: 'LOGIN',
                                  onTap: () {
                                    cubit.login();
                                  },
                                ),
                                fallback: (context) => const AppLoadingButton(),
                              );
                            }),
                        SizedBox(
                          height: height * .2339,
                        ),
                        const Align(
                          alignment: Alignment.center,
                          child: TextApp(
                            text: 'Or login with social account',
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
                              imagePath:
                                  'assets/images/facebook-svgrepo-com.svg',
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
        },
      ),
    );
  }
}
