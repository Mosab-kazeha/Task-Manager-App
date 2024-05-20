// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'edit_todo_bloc.dart';

@immutable
sealed class EditTodoEvent {}

// ignore: must_be_immutable
class TodoEdited extends EditTodoEvent {
  TodoModel theNewTodo;
  int todoId;
  TodoEdited({
    required this.theNewTodo,
    required this.todoId,
  });
}
