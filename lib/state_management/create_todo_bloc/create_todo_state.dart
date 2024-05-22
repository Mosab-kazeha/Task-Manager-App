// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'create_todo_bloc.dart';

@immutable
sealed class CreateTodoState {}

final class CreateTodoInitial extends CreateTodoState {}

class CreateTodoSuccessfully extends CreateTodoState {}

// ignore: must_be_immutable
class ErrorInCreateTodo extends CreateTodoState {
  ErrorModel error;
  ErrorInCreateTodo({required this.error});
}

class OffLineCreateState extends CreateTodoState {
  TodoModel todo;
  OffLineCreateState({
    required this.todo,
  });
}

class LoadingState extends CreateTodoState {}
