import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:task_manager_app/model/error_model.dart';
import 'package:task_manager_app/model/model.dart';
import 'package:task_manager_app/model/tasks/tasks_model.dart';
import 'package:task_manager_app/service/tasks/todo_service.dart';

part 'edit_todo_event.dart';
part 'edit_todo_state.dart';

class EditTodoBloc extends Bloc<EditTodoEvent, EditTodoState> {
  EditTodoBloc() : super(EditTodoInitial()) {
    on<TodoEdited>((event, emit) async {
      emit(LoadingState());
      Model result = await TodoService()
          .editTodo(todo: event.theNewTodo, todoId: event.todoId);
      if (result is TodoModel) {
        emit(EditTodoSuccessfully());
      } else if (result is ErrorModel) {
        emit(ErrorInEditTodo(error: result));
      } else {
        emit(OffLineState());
      }
    });
  }
}
