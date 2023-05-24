import 'package:dio/dio.dart';
import 'package:ecommerce_application/views/login/cubit/login_states.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';
import '../../../core/utils/services/api_servers.dart';
import '../../../models/user.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());
  User? user;

  static LoginCubit get(context) => BlocProvider.of(context);
  static ApiServer apiServer = ApiServer(Dio());
  void userLogin({required String email, required String password}) {
    emit(LoginLoadingState());
    apiServer.postData(
        data: {"email": email, "password": password},
        url: loginUrl).then((value) {
      user = User.fromJson(value.data);
      print(value.data);
      emit(LoginSuccessState(user: user!));
    }).catchError((error) {
      print(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }
}
