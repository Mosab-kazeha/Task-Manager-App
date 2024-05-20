// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'delete_todo_bloc.dart';

@immutable
sealed class DeleteTodoEvent {}

// ignore: must_be_immutable
class TodoDeleted extends DeleteTodoEvent {
  int todoId;
  TodoDeleted({
    required this.todoId,
  });
 
  
}
