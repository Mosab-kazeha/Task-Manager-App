import 'package:dio/dio.dart';

abstract class Serivec {
  ApiConusmer api = ApiConusmer();
  late Response response;
  final String baseUrl = "https://dummyjson.com/";
  final String loginUrl = "auth/login";
  final String todoUrl = "todos";
  final String createTodoUrl = "/add";
}

class ApiConusmer {
  Dio dio = Dio();
}
