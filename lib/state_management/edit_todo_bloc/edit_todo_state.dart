part of 'edit_todo_bloc.dart';

@immutable
sealed class EditTodoState {}

final class EditTodoInitial extends EditTodoState {}


class EditTodoSuccessfully extends EditTodoState{}

// ignore: must_be_immutable
class ErrorInEditTodo extends EditTodoState{
  ErrorModel error;
  ErrorInEditTodo({required this.error});
}

class OffLineState extends EditTodoState{}

class LoadingState extends EditTodoState {}