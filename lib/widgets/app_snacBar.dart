import 'package:flutter/material.dart';

import '../views/login/states.dart';

class AppSnacBar extends StatelessWidget {
  const AppSnacBar({super.key, required this.state, required this.color});
  final LoginSuccessState state;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Text(
        state.user.message,
        style: const TextStyle(fontSize: 16),
        textAlign: TextAlign.center,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      backgroundColor: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
