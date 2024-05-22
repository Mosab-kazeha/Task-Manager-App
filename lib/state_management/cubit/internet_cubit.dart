import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  StreamSubscription? _subscription;
  InternetCubit() : super(InternetInitial());

  void connected() {
    emit(ConnectedState(message: "Connected"));
  }

  void notConnected() {
    emit(NotConnectedState(message: "Not Connected"));
  }

  void checkConnection() {
    _subscription = Connectivity().onConnectivityChanged.listen((event) {
      (ConnectivityResult result) async {
        try {
          final result = await InternetAddress.lookup('example.com');
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            print('connected');
            connected();
          }
        } on SocketException catch (_) {
          print('not connected');
          notConnected();
        }

        //   if (result == ConnectivityResult.wifi ||
        //     result == ConnectivityResult.mobile) {
        //   connected();
        // } else {
        //   notConnected();
        // }
      };
    });
  }


  

  @override
  Future<void> close() {
    _subscription!.cancel();
    return super.close();
  }
}
