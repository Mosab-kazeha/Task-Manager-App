import 'package:dio/dio.dart';

abstract class Model {
  getHeader({bool useToken = false}) {
    if (useToken) {
      return Options(headers: {
        "Authorization": "Bearer  "
      }); //todo : don't forget put the token
    } else {
      return Options(
        headers: {
          "content-type": "application/json",
        },
      );
    }
  }
}
