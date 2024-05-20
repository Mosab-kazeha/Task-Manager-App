part of 'get_task_bloc.dart';

@immutable
sealed class GetTodoEvent {}

class ShowTodo extends GetTodoEvent {}


// ignore: must_be_immutable
class PaginationTheTodo extends GetTodoEvent {
  String skipNumber;
  PaginationTheTodo({required this.skipNumber});
}
