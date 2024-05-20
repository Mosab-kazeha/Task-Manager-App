import 'package:task_manager_app/model/tasks/tasks_model.dart';

class ListOf<T extends TodoModel> extends TodoModel {
  List<T> model;
  ListOf({required this.model});
}
