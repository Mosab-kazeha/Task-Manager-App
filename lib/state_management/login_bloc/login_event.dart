// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

// ignore: must_be_immutable
class LoginUser extends LoginEvent {
  LoginRequestModel userData;
  LoginUser({required this.userData});
}
