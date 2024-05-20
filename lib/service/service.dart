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

// abstract class DioConusmer {
//   Future<Model> getPaginationTodo(
//       {required String limit, required String skip});
//   Future<Model> deleteTodo({required int todoId});
//   Future<Model> editTodo({required TodoModel todo, required int todoId});
//   Future<Model> createTodo({required TodoModel todo});
//   Future<Model> getTodo();
// }
