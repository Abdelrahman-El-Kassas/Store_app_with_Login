import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/features/login/cubit/login_states.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit(this.dio) : super(InitialState());
  final Dio dio;

  Future<void> login({required String name, required String password}) async {
    emit(LoadingState());
    try {
      final res = await dio.post(
        'https://dummyjson.com/auth/login',
        data: {"username": name, "password": password},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      if (res.statusCode == 200) {
        String usertoken = res.data['accessToken'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token_key', usertoken);

        emit(SuccessState());
      } else {
        emit(FailedState(errMsg: 'There is error'));
      }
    } catch (error) {
      emit(FailedState(errMsg: error.toString()));
    }
  }
}
