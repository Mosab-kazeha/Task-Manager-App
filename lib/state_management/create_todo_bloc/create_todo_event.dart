part of 'create_todo_bloc.dart';

@immutable
sealed class CreateTodoEvent {}

// ignore: must_be_immutable
class CreateNewTodo extends CreateTodoEvent {
  TodoModel theNewTodo;
  CreateNewTodo({required this.theNewTodo});
}
