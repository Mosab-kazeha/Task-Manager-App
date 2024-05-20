import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:task_manager_app/state_management/get_todo_bloc/get_task_bloc.dart';

// ignore: must_be_immutable
class TasksScreen extends StatelessWidget {
  TasksScreen({super.key});

  TextEditingController tasksController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    BuildContext appContext = context;

    return BlocProvider(
      create: (context) => GetTodoBloc()..add(ShowTodo()),
      child: Scaffold(
        floatingActionButton: IconButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    width: double.maxFinite,
                    height: 208,
                    padding: const EdgeInsets.all(10),
                    clipBehavior: Clip.antiAlias,
                    decoration: const ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(14),
                          topRight: Radius.circular(14),
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: width / 1.2,
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
                                hintText: 'Enter Your Tasks',
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
                        const SizedBox(height: 10),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            width: width / 1.2,
                            height: height / 13,
                            decoration: ShapeDecoration(
                              color: const Color(0xFF8AA7B4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'create task',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: 'Comfortaa',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                });
          },
          icon: const Icon(
            Icons.add_circle_outline,
            color: Color(0xFF8AA7B4),
            size: 65,
            weight: 5,
          ),
        ),
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
                padding: EdgeInsets.only(bottom: height / 40, top: height / 40),
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
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    child: Center(
                                        child: Text(
                                      index == 0 ? "all" : (index).toString(),
                                      style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 103, 156, 181),
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
                                /*dismissible: DismissiblePane(onDismissed: () {
                                                      setState(() {
                                                        Tasks().deleteTask(
                                                            idTodo: todoId,
                                                            idTask: tasks[index].taskId!);
                                                      });
                                                    }),*/
                                children: [
                                  SlidableAction(
                                    onPressed: (context) {
                                      //   /* setState(() {
                                      //                   tasks.removeAt(index);
                                      //                 });*/

                                      //   setState(() {
                                      //     /*print(tasks.length);
                                      //                   print(tasks);
                                      //                   print('object');*/
                                      //     Tasks().deleteTask(
                                      //         idTodo: widget.todoId,
                                      //         idTask: tasks[index].taskId!);
                                      //   });
                                    },
                                    backgroundColor: Colors.white,
                                    foregroundColor: const Color(0xFFFE4A49),
                                    icon: Icons.delete_outline_rounded,
                                  ),
                                ],
                              ),
                              child: ListTile(
                                title: Text(state.todo[index].todo!),
                                leading: Checkbox(
                                    activeColor: const Color(0xFF8AA7B4),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    value: state.todo[index].completed,
                                    onChanged: (value) async {
                                      // await Tasks().updateOldTask(
                                      //   idTodo: widget.todoId,
                                      //   idTask: tasks[index].taskId!,
                                      //   newTask: TasksModel(
                                      //       isComplete:
                                      //           !tasks[index].isComplete!,
                                      //       taskTitle: tasks[index].taskTitle,
                                      //       taskId: tasks[index].taskId,
                                      //       todoId: tasks[index].todoId),
                                      // );
                                      // setState(() {
                                      //   tasks[index].isComplete = value!;
                                      // });
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
                                /*dismissible: DismissiblePane(onDismissed: () {
                                                      setState(() {
                                                        Tasks().deleteTask(
                                                            idTodo: todoId,
                                                            idTask: tasks[index].taskId!);
                                                      });
                                                    }),*/
                                children: [
                                  SlidableAction(
                                    onPressed: (context) {
                                      //   /* setState(() {
                                      //                   tasks.removeAt(index);
                                      //                 });*/

                                      //   setState(() {
                                      //     /*print(tasks.length);
                                      //                   print(tasks);
                                      //                   print('object');*/
                                      //     Tasks().deleteTask(
                                      //         idTodo: widget.todoId,
                                      //         idTask: tasks[index].taskId!);
                                      //   });
                                    },
                                    backgroundColor: Colors.white,
                                    foregroundColor: const Color(0xFFFE4A49),
                                    icon: Icons.delete_outline_rounded,
                                  ),
                                ],
                              ),
                              child: ListTile(
                                title: Text(state.todo[index].todo!),
                                leading: Checkbox(
                                    activeColor: const Color(0xFF8AA7B4),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    value: state.todo[index].completed,
                                    onChanged: (value) async {
                                      // await Tasks().updateOldTask(
                                      //   idTodo: widget.todoId,
                                      //   idTask: tasks[index].taskId!,
                                      //   newTask: TasksModel(
                                      //       isComplete:
                                      //           !tasks[index].isComplete!,
                                      //       taskTitle: tasks[index].taskTitle,
                                      //       taskId: tasks[index].taskId,
                                      //       todoId: tasks[index].todoId),
                                      // );
                                      // setState(() {
                                      //   tasks[index].isComplete = value!;
                                      // });
                                    }),
                              ),
                            );
                          }),
                    );
                  } else if (state is GetLoadingState ||
                      state is PaginationLoadingState) {
                    return Center(
                        child: CircularProgressIndicator(
                      color: const Color(0xFF8AA7B4),
                    ));
                  } else if (state is ErrorInGettingTodos ||
                      state is ErrorInPaginationTodos) {
                    return Center(
                      child: Text("there is problem"),
                    );
                  } else {
                    return Center(
                      child: Text("there is no internet "),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
