import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:task_manager_app/config/get_it.dart';
import '../model/tasks/tasks_model.dart';
import '../state_management/create_todo_bloc/create_todo_bloc.dart';
import '../state_management/cubit/internet_cubit.dart';
import '../state_management/delete_todo_bloc/delete_todo_bloc.dart';
import '../state_management/edit_todo_bloc/edit_todo_bloc.dart';
import '../state_management/get_todo_bloc/get_task_bloc.dart';

// ignore: must_be_immutable
class TasksScreen extends StatelessWidget {
  TasksScreen({super.key});

  TextEditingController tasksController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => InternetCubit()..checkConnection(),
        ),
        BlocProvider(
          create: (context) => GetTodoBloc()..add(ShowTodo()),
        ),
        BlocProvider(
          create: (context) => CreateTodoBloc(),
        ),
        BlocProvider(
          create: (context) => DeleteTodoBloc(),
        ),
        BlocProvider(
          create: (context) => EditTodoBloc(),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<DeleteTodoBloc, DeleteTodoState>(
            listener: (context, state) {
              if (state is DeleteTodoSuccessfully) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  duration: Duration(seconds: 10),
                  content: Text(' Task Deleted Successfully'),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                ));
              }
            },
          ),
          BlocListener<InternetCubit, InternetState>(
              listener: (context, state) {
            if (state is ConnectedState) {
              readSecureData("todo_ofline") == null
                  ? print('')
                  : BlocProvider.of<CreateTodoBloc>(context).add(CreateNewTodo(
                      theNewTodo:
                          TodoModel.fromJson(readSecureData("todo_ofline"))));
            }
          }),
          BlocListener<EditTodoBloc, EditTodoState>(
            listener: (context, state) {
              if (state is EditTodoSuccessfully) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  duration: Duration(seconds: 10),
                  content: Text('Task Updated Successfully'),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                ));
              }
            },
          ),
          BlocListener<CreateTodoBloc, CreateTodoState>(
            listener: (context, state) {
              if (state is CreateTodoSuccessfully) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  duration: Duration(seconds: 10),
                  content: Text('Task Created Successfully'),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                ));
              } else if (state is OffLineCreateState) {
                writeSecureData("todo_ofline", state.todo.toJson());
              }
            },
          ),
        ],
        child: Builder(builder: (context) {
          return Scaffold(
            body: Padding(
              padding: EdgeInsets.only(top: width / 20, left: width / 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 35),
                    child: Text(
                      'Your Tasks',
                      style: TextStyle(
                        color: Color(0xFF8AA7B4),
                        fontSize: 34,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(bottom: height / 40, top: height / 40),
                    child: Row(
                      children: [
                        SizedBox(
                            width: width / 1.07,
                            height: width / 14,
                            child: ListView.builder(
                                itemCount: 100,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width / 100),
                                    child: InkWell(
                                      onTap: () {
                                        if (index == 0) {
                                          context
                                              .read<GetTodoBloc>()
                                              .add(ShowTodo());
                                        } else {
                                          context.read<GetTodoBloc>().add(
                                              PaginationTheTodo(
                                                  skipNumber:
                                                      (index * 10).toString()));
                                        }
                                      },
                                      child: Container(
                                        width: width / 12,
                                        height: width / 14,
                                        decoration: ShapeDecoration(
                                          color: const Color.fromARGB(
                                              97, 196, 209, 215),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                        child: Center(
                                            child: Text(
                                          index == 0
                                              ? "all"
                                              : (index).toString(),
                                          style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 103, 156, 181),
                                            fontSize: 15,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.normal,
                                            height: 0,
                                          ),
                                        )),
                                      ),
                                    ),
                                  );
                                })),
                      ],
                    ),
                  ),
                  BlocBuilder<GetTodoBloc, GetTodoState>(
                    builder: (context, state) {
                      if (state is GettingTodosSuccessfully) {
                        return Expanded(
                          child: ListView.builder(
                              itemCount: state.todo.length,
                              itemBuilder: (context, index) {
                                return Slidable(
                                  key: UniqueKey(),
                                  endActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (context) {
                                          BlocProvider.of<DeleteTodoBloc>(
                                                  context)
                                              .add(TodoDeleted(
                                                  todoId:
                                                      state.todo[index].id!));
                                        },
                                        backgroundColor: Colors.white,
                                        foregroundColor:
                                            const Color(0xFFFE4A49),
                                        icon: Icons.delete_outline_rounded,
                                      ),
                                    ],
                                  ),
                                  child: ListTile(
                                    title: Text(state.todo[index].todo!),
                                    leading: Checkbox(
                                        activeColor: const Color(0xFF8AA7B4),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        value: state.todo[index].completed,
                                        onChanged: (value) {
                                          BlocProvider.of<EditTodoBloc>(context)
                                              .add(TodoEdited(
                                                  theNewTodo: TodoModel(
                                                      todo: state
                                                          .todo[index].todo,
                                                      completed: !state
                                                          .todo[index]
                                                          .completed!),
                                                  todoId:
                                                      state.todo[index].id!));
                                        }),
                                  ),
                                );
                              }),
                        );
                      }
                      if (state is PaginationTodosSuccessfully) {
                        return Expanded(
                          child: ListView.builder(
                              itemCount: state.todo.length,
                              itemBuilder: (context, index) {
                                return Slidable(
                                  key: UniqueKey(),
                                  endActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (context) {
                                          BlocProvider.of<DeleteTodoBloc>(
                                                  context)
                                              .add(TodoDeleted(
                                                  todoId:
                                                      state.todo[index].id!));
                                        },
                                        backgroundColor: Colors.white,
                                        foregroundColor:
                                            const Color(0xFFFE4A49),
                                        icon: Icons.delete_outline_rounded,
                                      ),
                                    ],
                                  ),
                                  child: ListTile(
                                    title: Text(state.todo[index].todo!),
                                    leading: Checkbox(
                                        activeColor: const Color(0xFF8AA7B4),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        value: state.todo[index].completed,
                                        onChanged: (value) async {
                                          BlocProvider.of<EditTodoBloc>(context)
                                              .add(TodoEdited(
                                                  theNewTodo: TodoModel(
                                                      todo: state
                                                          .todo[index].todo,
                                                      completed: !state
                                                          .todo[index]
                                                          .completed!),
                                                  todoId:
                                                      state.todo[index].id!));
                                        }),
                                  ),
                                );
                              }),
                        );
                      } else if (state is GetLoadingState ||
                          state is PaginationLoadingState) {
                        return const Center(
                            child: CircularProgressIndicator(
                          color: Color(0xFF8AA7B4),
                        ));
                      } else if (state is ErrorInGettingTodos ||
                          state is ErrorInPaginationTodos) {
                        return const Center(
                          child: Text("there is problem"),
                        );
                      } else {
                        return const Center(
                          child: Text("there is no internet "),
                        );
                      }
                    },
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: width / 1.4,
                        height: height / 13,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFF5F4F4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: TextField(
                          controller: tasksController,
                          decoration: InputDecoration(
                              hintText: 'Add New Task',
                              hintStyle: const TextStyle(
                                color: Color(0xFF999999),
                                fontSize: 18,
                                fontFamily: 'Comfortaa',
                                fontWeight: FontWeight.w300,
                                height: 0,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              )),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          if (tasksController.text.isNotEmpty) {
                            BlocProvider.of<CreateTodoBloc>(context).add(
                              CreateNewTodo(
                                theNewTodo: TodoModel(
                                    todo: tasksController.text,
                                    completed: false,
                                    userId: 5),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              duration: Duration(seconds: 10),
                              content: Text('enter your new task'),
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                            ));
                          }
                        },
                        icon: const Icon(
                          Icons.add_circle_outline,
                          color: Color(0xFF8AA7B4),
                          size: 65,
                          weight: 5,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
