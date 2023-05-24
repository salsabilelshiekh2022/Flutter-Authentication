import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerce_application/views/login/cubit/login_cubit.dart';
import 'package:ecommerce_application/views/login/cubit/login_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/app_loading_button.dart';

//import 'package:fluttertoast/fluttertoast.dart';

import '../../constants.dart' as constants;
import '../../constants.dart';
import '../../core/functions/navigation.dart';
import '../../core/functions/showSnacBar.dart';
import '../../core/functions/validator.dart';
import '../../core/utils/casheData/casheData.dart';
import '../../core/utils/routes.dart';
import '../widgets/app_button.dart';
import '../widgets/social_media_button.dart';
import '../widgets/app_text_form_field.dart';
import '../widgets/app_text.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final height = getHeight(context);

    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (state.user.status) {
              CasheData.setData(key: 'token', value: state.user.data!.token);

              Navigation.pushAndRemove(context, AppRoutes.homePageRoute);
            } else {
              showSnacBar(context, state.user.message, constants.error);
            }
          }
        },
        builder: (context, state) {
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
                    key: formKey,
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
                        ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder: (context) => CustomButton(
                            title: 'LOGIN',
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                try {
                                  formKey.currentState!.save();
                                  BlocProvider.of<LoginCubit>(context)
                                      .userLogin(
                                          email: emailController.text,
                                          password: passwordController.text);
                                } catch (e) {
                                  debugPrint(e.toString());
                                }
                              }
                            },
                          ),
                          fallback: (context) => const AppLoadingButton(),
                        ),
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
