import 'package:flutter/material.dart';

final scaffoldKey = GlobalKey<ScaffoldMessengerState>();
void showSnacBar2(BuildContext context, String msg, Color color) {
  scaffoldKey.currentState!.showSnackBar(SnackBar(
    content: Text(
      msg,
      style: const TextStyle(fontSize: 16),
      textAlign: TextAlign.center,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    ),
    backgroundColor: color,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ));
}

void showSnacBar(String msg, Color color) {
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  final SnackBar snackBar = SnackBar(
    content: Text(
      msg,
      style: const TextStyle(fontSize: 16),
      textAlign: TextAlign.center,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    ),
    backgroundColor: color,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  );

  scaffoldKey.currentState?.showSnackBar(snackBar);
}
