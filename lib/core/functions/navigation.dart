import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';

class Navigation {
  static Future<dynamic> pushNamed(BuildContext context, String routeName,
      {Map<String, dynamic>? arguments}) async {
    Navigator.of(context).pushNamed(routeName, arguments: arguments);
  }

  static Future<dynamic> pop(BuildContext context) async {
    Navigator.of(context).pop();
  }

  static Future<dynamic> pushAndRemove(BuildContext context, String routeName,
      {RouteSettings? settings}) async {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        routeName,
        (Route<dynamic> route) => false,
      );
    });
  }
}
