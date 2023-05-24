import 'package:dio/dio.dart';
import 'package:ecommerce_application/views/register/cubit/register_states.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';
import '../../../core/utils/services/api_servers.dart';
import '../../../models/user.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());
  User? user;

  static RegisterCubit get(context) => BlocProvider.of(context);
  static ApiServer apiServer = ApiServer(Dio());
  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(RegisterLoadingState());
    apiServer.postData(data: {
      "email": email,
      "password": password,
      "name": name,
      "phone": phone,
    }, url: registerUrl).then((value) {
      user = User.fromJson(value.data);
      //debugPrint(value.data);
      emit(RegisterSuccessState(user: user!));
    }).catchError((error) {
      debugPrint(error.toString());
      emit(RegisterErrorState('error is ${error.toString()}'));
    });
  }
}
