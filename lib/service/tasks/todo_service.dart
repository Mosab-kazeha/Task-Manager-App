import 'package:task_manager_app/model/error_model.dart';
import 'package:task_manager_app/model/exception_model.dart';
import 'package:task_manager_app/model/list_of_model.dart';
import 'package:task_manager_app/model/model.dart';
import 'package:task_manager_app/model/tasks/tasks_model.dart';
import 'package:task_manager_app/service/service.dart';

class TodoService extends Serivec {
  Future<Model> getTodo() async {
    try {
      response = await api.dio.get(baseUrl + todoUrl);
      if (response.statusCode == 200) {
        List<TodoModel> temp = List.generate(
          response.data.length,
          (index) => TodoModel.fromMap(response.data["todos"][index]),
        );
        ListOfModel result = ListOfModel(listOf: temp);
        return result;
      } else {
        ErrorModel error = ErrorModel(error: response.statusMessage!);
        return error;
      }
    } catch (e) {
      ExceptionMode exception = ExceptionMode(exception: e.toString());
      return exception;
    }
  }

  Future<Model> createTodo({required TodoModel todo}) async {
    try {
      response =
          await api.dio.post(baseUrl + createTodoUrl, data: todo.toJson());
      if (response.statusCode == 200) {
        TodoModel todo = TodoModel.fromJson(response.data);
        return todo;
      } else {
        ErrorModel error = ErrorModel(error: response.statusMessage!);
        return error;
      }
    } catch (e) {
      ExceptionMode exception = ExceptionMode(exception: e.toString());
      return exception;
    }
  }

  Future<Model> editTodo({required TodoModel todo, required int todoId}) async {
    //! remember you can edit if task from true to false or the title of task
    try {
      response =
          await api.dio.put("$baseUrl$todoUrl/$todoId", data: todo.toJson());
      if (response.statusCode == 200) {
        TodoModel todo = TodoModel.fromJson(response.data);
        return todo;
      } else {
        ErrorModel error = ErrorModel(error: response.statusMessage!);
        return error;
      }
    } catch (e) {
      ExceptionMode exception = ExceptionMode(exception: e.toString());
      return exception;
    }
  }

  Future<Model> deleteTodo({required int todoId}) async {
    try {
      response = await api.dio.delete("$baseUrl$todoUrl/$todoId");
      if (response.statusCode == 200) {
        TodoModel todo = TodoModel.fromJson(response.data);
        return todo;
      } else {
        ErrorModel error = ErrorModel(error: response.statusMessage!);
        return error;
      }
    } catch (e) {
      ExceptionMode exception = ExceptionMode(exception: e.toString());
      return exception;
    }
  }

  Future<Model> getPaginationTodo(
      {required String limit, required String skip}) async {
    try {
      response = await api.dio.get("$baseUrl$todoUrl?limit=$limit&skip=$skip");
      if (response.statusCode == 200) {
        List<TodoModel> temp = List.generate(
          response.data.length,
          (index) => TodoModel.fromMap(response.data["todos"][index]),
        );
        ListOfModel result = ListOfModel(listOf: temp);
        return result;
      } else {
        ErrorModel error = ErrorModel(error: response.statusMessage!);
        return error;
      }
    } catch (e) {
      ExceptionMode exception = ExceptionMode(exception: e.toString());
      return exception;
    }
  }
}
