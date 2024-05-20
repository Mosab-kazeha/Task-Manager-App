// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_task_bloc.dart';

@immutable
sealed class GetTodoState {}

final class GetTodoInitial extends GetTodoState {}

// ignore: must_be_immutable
class GettingTodosSuccessfully extends GetTodoState {
  List<TodoModel> todo;
  GettingTodosSuccessfully({required this.todo});
}

// ignore: must_be_immutable
class ErrorInGettingTodos extends GetTodoState {
  ErrorModel error;
  ErrorInGettingTodos({required this.error});
}

// ignore: must_be_immutable
class ExceptionGettingTodos extends GetTodoState {
  ExceptionModel exception;
  ExceptionGettingTodos({required this.exception});
}

class GetLoadingState extends GetTodoState {}

// ignore: must_be_immutable
class PaginationTodosSuccessfully extends GetTodoState {
  List<TodoModel> todo;
  PaginationTodosSuccessfully({required this.todo});
}

// ignore: must_be_immutable
class ErrorInPaginationTodos extends GetTodoState {
  ErrorModel error;
  ErrorInPaginationTodos({required this.error});
}

// ignore: must_be_immutable
class ExceptionPaginationTodos extends GetTodoState {
  ExceptionModel exception;
  ExceptionPaginationTodos({required this.exception});
}

class PaginationLoadingState extends GetTodoState {}
