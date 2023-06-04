import 'package:dio/dio.dart';
import 'package:ecommerce_application/views/register/states.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants.dart' as constants;
import '../../core/functions/navigation.dart';
import '../../core/functions/showSnacBar.dart';
import '../../core/casheData/casheData.dart';
import '../../core/router/routes.dart';
import '../../core/api_services/api_servers.dart';
import '../../core/api_services/user_model.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());
  User? user;
  final GlobalKey<FormState> formKey = GlobalKey();
  String? email, password, name, phone;
  static RegisterCubit of(context) => BlocProvider.of(context);
  static ApiServer apiServer = ApiServer(Dio());

  Future<void> register() async {
    formKey.currentState!.save();
    if (!formKey.currentState!.validate()) return;
    emit(RegisterLoadingState());
    try {
      final Response<dynamic> response = await apiServer.postData(data: {
        "email": email!,
        "password": password!,
        "name": name!,
        "phone": phone!,
      }, url: 'https://student.valuxapps.com/api/register');
      user = User.fromJson(response.data);
      if (user!.status) {
        await CasheData.setData(key: 'token', value: user!.data!.token);
        debugPrint('doneeeeeee');
        debugPrint(CasheData.getData(key: 'token'));
        if (CasheData.getData(key: 'token') == null) {
          showSnacBar(user!.message, constants.error);
          debugPrint(user!.message);
        } else {
          Navigation.navigateAndPopAll(AppRoutes.homePageRoute);
          //debugPrint(user!.message);
        }
      }
    } catch (e) {
      showSnacBar(user!.message, constants.error);
      // debugPrint(e.toString());
      // debugPrint(user!.message);
    }
    emit(RegisterInitialState());
  }
}
