import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/features/login/model/login_repo.dart';
import 'package:store_app/features/login/viewmodel/login_states.dart';


class LoginCubit extends Cubit<LoginStates> {
  // الـ Cubit هنا بيعتمد على الـ Repo بدل الـ Dio
  final LoginRepo loginRepo;

  LoginCubit(this.loginRepo) : super(InitialState());

  Future<void> login({required String name, required String password}) async {
    emit(LoadingState());
    try {
      await loginRepo.loginUser(name: name, password: password);
      
      emit(SuccessState());
    } catch (error) {
      emit(FailedState(errMsg: error.toString()));
    }
  }
}