import 'package:ecommerce_application/core/router/routes.dart';
import 'package:ecommerce_application/views/forget_password/view.dart';
import 'package:ecommerce_application/views/home/view.dart';
import 'package:ecommerce_application/views/login/view.dart';
import 'package:ecommerce_application/views/register/view.dart';
import 'package:flutter/cupertino.dart';

Route<dynamic> onGenerate(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.loginPageRoute:
      return CupertinoPageRoute(
          builder: (_) => const LoginPage(), settings: settings);
    case AppRoutes.registerPageRoute:
      return CupertinoPageRoute(
          builder: (_) => const RegisterPage(), settings: settings);
    case AppRoutes.forgetPasswordRoute:
      return CupertinoPageRoute(
          builder: (_) => ForgetPasswordPage(), settings: settings);
    case AppRoutes.homePageRoute:
      return CupertinoPageRoute(
          builder: (_) => const HomePage(), settings: settings);

    default:
      return CupertinoPageRoute(
          builder: (_) => const LoginPage(), settings: settings);
  }
}
