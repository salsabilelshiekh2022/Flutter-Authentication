import 'package:ecommerce_application/core/utils/router.dart';
import 'package:ecommerce_application/core/utils/routes.dart';
import 'package:ecommerce_application/views/login/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'constants.dart' as constants;
import 'core/utils/casheData/casheData.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CasheData.cashInitialization();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'E-commerce App',
        theme: ThemeData(
          fontFamily: "Metropolis",
          appBarTheme: const AppBarTheme(
              backgroundColor: constants.lightScaffoldBackgroundColor,
              elevation: 0.0,
              iconTheme: IconThemeData(color: constants.black)),
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(primary: constants.primaryAppColor),
          scaffoldBackgroundColor: constants.lightScaffoldBackgroundColor,
        ),
        onGenerateRoute: onGenerate,
        initialRoute: CasheData.getData(key: 'token') == null
            ? AppRoutes.registerPageRoute
            : AppRoutes.homePageRoute,
      ),
    );
  }
}
