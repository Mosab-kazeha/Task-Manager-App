import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:task_manager_app/config/get_it.dart';

part 'cheaking_token_event.dart';
part 'cheaking_token_state.dart';

class CheakingTokenBloc extends Bloc<CheakingTokenEvent, CheakingTokenState> {
  CheakingTokenBloc() : super(CheakingTokenInitial()) {
    on<CheakingToken>((event, emit) async {
      bool result = await readSecureData("token");
      if (result == true) {
        emit(TokenExisted());
      } else if (result == false) {
        emit(TokenNotExisted());
      }
    });
  }
}
