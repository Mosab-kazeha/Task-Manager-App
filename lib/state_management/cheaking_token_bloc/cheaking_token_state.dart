part of 'cheaking_token_bloc.dart';

@immutable
sealed class CheakingTokenState {}

final class CheakingTokenInitial extends CheakingTokenState {}

class TokenExisted extends CheakingTokenState {}

class TokenNotExisted extends CheakingTokenState {}
