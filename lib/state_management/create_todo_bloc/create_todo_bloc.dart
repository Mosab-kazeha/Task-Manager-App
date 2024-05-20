import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:task_manager_app/model/error_model.dart';
import 'package:task_manager_app/model/model.dart';
import 'package:task_manager_app/model/tasks/tasks_model.dart';
import 'package:task_manager_app/service/tasks/todo_service.dart';

part 'create_todo_event.dart';
part 'create_todo_state.dart';

class CreateTodoBloc extends Bloc<CreateTodoEvent, CreateTodoState> {
  CreateTodoBloc() : super(CreateTodoInitial()) {
    on<CreateNewTodo>((event, emit) async {
      emit(LoadingState());
      Model result = await TodoService().createTodo(todo: event.theNewTodo);

      if (result is TodoModel) {
        emit(CreateTodoSuccessfully());
      } else if (result is ErrorModel) {
        emit(ErrorInCreateTodo(error: result));
      } else {
        emit(OffLineState(todo: event.theNewTodo));
      }
    });
  }
}
