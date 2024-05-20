// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

class LoadingState extends LoginState {}

class LoginSuccessfully extends LoginState {}

// ignore: must_be_immutable
class ErrorInLogin extends LoginState {
  ErrorModel error;
  ErrorInLogin({required this.error});
}

// ignore: must_be_immutable
class ExceptionInLogin extends LoginState {
  ExceptionModel exception;
  ExceptionInLogin({required this.exception});
}
