import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:task_manager_app/model/error_model.dart';
import 'package:task_manager_app/model/model.dart';
import 'package:task_manager_app/model/tasks/tasks_model.dart';
import 'package:task_manager_app/service/tasks/todo_service.dart';

part 'delete_todo_event.dart';
part 'delete_todo_state.dart';

class DeleteTodoBloc extends Bloc<DeleteTodoEvent, DeleteTodoState> {
  DeleteTodoBloc() : super(DeleteTodoInitial()) {
    on<TodoDeleted>((event, emit) async {
      emit(LoadingState());
      Model result = await TodoService().deleteTodo(todoId: event.todoId);

      if (result is TodoModel) {
        emit(DeleteTodoSuccessfully());
      } else if (result is ErrorModel) {
        emit(ErrorInDeleteTodo(error: result));
      } else {
        emit(OffLineState(todoId: event.todoId));
      }
    });
  }
}
