import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:task_manager_app/model/auth/login_request_model.dart';
import 'package:task_manager_app/model/auth/login_response_model.dart';
import 'package:task_manager_app/model/error_model.dart';
import 'package:task_manager_app/model/exception_model.dart';
import 'package:task_manager_app/model/model.dart';
import 'package:task_manager_app/service/auth/login_service.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginUser>((event, emit) async {
      emit(LoadingState());
      Model result = await LoginService().login(user: event.userData);
      if (result is LoginResponseModel) {
        emit(LoginSuccessfully());
      } else if (result is ErrorModel) {
        emit(ErrorInLogin(error: result));
      } else {
        emit(ExceptionInLogin(exception: result as ExceptionModel));
      }
    });
  }
}
