import 'package:dio/dio.dart';
import 'package:task_manager_app/model/error_model.dart';
import 'package:task_manager_app/model/exception_model.dart';
import 'package:task_manager_app/model/list_of_model.dart';
import 'package:task_manager_app/model/model.dart';
import 'package:task_manager_app/model/tasks/tasks_model.dart';
import 'package:task_manager_app/service/service.dart';

class TodoService extends Serivec {
  Future<Model> createTodo({required TodoModel todo}) async {
    try {
      response = await api.dio
          .post(baseUrl + todoUrl + createTodoUrl, data: todo.toJson());

      if (response.statusCode == 200) {
        TodoModel todo = TodoModel.fromMap(response.data);
        return todo;
      } else {
        ErrorModel error = ErrorModel(error: response.statusMessage!);
        return error;
      }
    } catch (e) {
      ExceptionModel exception = ExceptionModel(exception: e.toString());
      return exception;
    }
  }

  Future<Model> editTodo({required TodoModel todo, required int todoId}) async {
//final body = FormData.fromMap(todo.toMap());
    try {
      response = await api.dio.put("$baseUrl$todoUrl/$todoId",
          data: todo.toJson(),
          options: Options(headers: {"Content-Type": "x-www-form-urlencoded"}));

      if (response.statusCode == 200) {
        TodoModel todo = TodoModel.fromMap(response.data);
        return todo;
      } else {
        ErrorModel error = ErrorModel(error: response.statusMessage!);
        return error;
      }
    } catch (e) {
      ExceptionModel exception = ExceptionModel(exception: e.toString());
      return exception;
    }
  }

  Future<Model> deleteTodo({required int todoId}) async {
    try {
      response = await api.dio.delete("$baseUrl$todoUrl/$todoId");
      if (response.statusCode == 200) {
        TodoModel todo = TodoModel.fromMap(response.data);
        return todo;
      } else {
        ErrorModel error = ErrorModel(error: response.statusMessage!);
        return error;
      }
    } catch (e) {
      ExceptionModel exception = ExceptionModel(exception: e.toString());
      return exception;
    }
  }

  Future<Model> getPaginationTodo({required String skip}) async {
    try {
      response = await api.dio.get("$baseUrl$todoUrl?limit=10&skip=$skip");
      if (response.statusCode == 200) {
        print(response.data.length);
        List<TodoModel> temp = List.generate(
          response.data["todos"].length,
          (index) => TodoModel.fromMap(response.data["todos"][index]),
        );
        ListOf<TodoModel> result = ListOf(model: temp);
        return result;
      } else {
        ErrorModel error = ErrorModel(error: response.statusMessage!);
        return error;
      }
    } catch (e) {
      ExceptionModel exception = ExceptionModel(exception: e.toString());
      return exception;
    }
  }

  Future<Model> getTodo() async {
    try {
      response = await api.dio.get(baseUrl + todoUrl);
      if (response.statusCode == 200) {
        List<TodoModel> temp = List.generate(
          response.data["todos"].length,
          (index) => TodoModel.fromMap(response.data["todos"][index]),
        );
        ListOf<TodoModel> result = ListOf(model: temp);
        return result;
      } else {
        ErrorModel error = ErrorModel(error: response.statusMessage!);
        return error;
      }
    } catch (e) {
      ExceptionModel exception = ExceptionModel(exception: e.toString());
      return exception;
    }
  }
}
