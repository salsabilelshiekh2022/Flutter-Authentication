import 'package:ecommerce_application/core/functions/navigation.dart';
import 'package:ecommerce_application/core/casheData/casheData.dart';
import 'package:ecommerce_application/core/router/routes.dart';
import 'package:flutter/material.dart';

import '../../widgets/app_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomButton(
          title: 'SIGN OUT',
          onTap: () async {
            await CasheData.removeItem(key: 'token').then((value) {
              Navigation.navigateAndPopAll(AppRoutes.registerPageRoute);
              setState(() {});
            });
          },
        ),
      ),
    );
  }
}
