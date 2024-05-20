// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'delete_todo_bloc.dart';

@immutable
sealed class DeleteTodoState {}

final class DeleteTodoInitial extends DeleteTodoState {}

class DeleteTodoSuccessfully extends DeleteTodoState {}

// ignore: must_be_immutable
class ErrorInDeleteTodo extends DeleteTodoState {
  ErrorModel error;
  ErrorInDeleteTodo({required this.error});
}

class OffLineState extends DeleteTodoState {
  int todoId;
  OffLineState({
    required this.todoId,
  });
}

class LoadingState extends DeleteTodoState {}
