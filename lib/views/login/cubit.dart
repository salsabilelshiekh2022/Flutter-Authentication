import 'package:dio/dio.dart';
import 'package:ecommerce_application/views/login/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants.dart' as constants;
import '../../core/functions/navigation.dart';
import '../../core/functions/showSnacBar.dart';
import '../../core/casheData/casheData.dart';
import '../../core/router/routes.dart';
import '../../core/api_services/api_servers.dart';
import '../../core/api_services/user_model.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());
  User? user;

  static LoginCubit of(context) => BlocProvider.of(context);
  final GlobalKey<FormState> formKey = GlobalKey();

  String? email, password;

  static ApiServer apiServer = ApiServer(Dio());

  Future<void> login() async {
    formKey.currentState!.save();
    if (!formKey.currentState!.validate()) return;
    emit(LoginLoadingState());
    try {
      final Response<dynamic> response = await apiServer.postData(
          data: {"email": email!, "password": password!},
          url: 'https://student.valuxapps.com/api/login');

      user = User.fromJson(response.data);
      if (user!.status) {
        await CasheData.setData(key: 'token', value: user!.data!.token);
      }
      debugPrint('doneeeeeee');
      debugPrint(CasheData.getData(key: 'token'));
      if (CasheData.getData(key: 'token') == null) {
        showSnacBar(user!.message, constants.error);
        debugPrint(user!.message);
      } else {
        Navigation.navigateAndPopAll(AppRoutes.homePageRoute);
        //debugPrint(user!.message);
      }
    } catch (e) {
      showSnacBar(user!.message, constants.error);
      // debugPrint(e.toString());
      // debugPrint(user!.message);
    }
    emit(LoginInitialState());
  }
}
