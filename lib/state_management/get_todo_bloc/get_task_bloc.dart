import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:task_manager_app/model/error_model.dart';
import 'package:task_manager_app/model/exception_model.dart';
import 'package:task_manager_app/model/list_of_model.dart';
import 'package:task_manager_app/model/model.dart';
import 'package:task_manager_app/model/tasks/tasks_model.dart';
import 'package:task_manager_app/service/tasks/todo_service.dart';

part 'get_task_event.dart';
part 'get_task_state.dart';

class GetTodoBloc extends Bloc<GetTodoEvent, GetTodoState> {
  GetTodoBloc() : super(GetTodoInitial()) {
    on<ShowTodo>((event, emit) async {
      emit(GetLoadingState());
      Model result = await TodoService().getTodo();
      if (result is ListOf<TodoModel>) {
        emit(GettingTodosSuccessfully(todo: result.model));
      } else if (result is ErrorModel) {
        emit(ErrorInGettingTodos(error: result));
      } else {
        emit(ExceptionGettingTodos(exception: result as ExceptionModel));
      }
    });

    on<PaginationTheTodo>((event, emit) async {
      emit(PaginationLoadingState());
      Model result =
          await TodoService().getPaginationTodo(skip: event.skipNumber);
      if (result is ListOf<TodoModel>) {
        emit(PaginationTodosSuccessfully(todo: result.model));
      } else if (result is ErrorModel) {
        emit(ErrorInPaginationTodos(error: result));
      } else {
        emit(ExceptionPaginationTodos(exception: result as ExceptionModel));
      }
    });
  }
}
