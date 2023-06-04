import 'package:flutter/cupertino.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Navigation {
  static BuildContext context = navigatorKey.currentContext!;
  static Future<dynamic> pushNamed(BuildContext context, String routeName,
      {Map<String, dynamic>? arguments}) async {
    Navigator.of(context).pushNamed(routeName, arguments: arguments);
  }

  static Future<dynamic> pop(BuildContext context) async {
    Navigator.of(context).pop();
  }

  static Future<dynamic> navigateAndPopAll(String routeName,
      {RouteSettings? settings}) async {
    navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      (_) => false,
    );
  }
}
