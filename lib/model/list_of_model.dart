import 'package:task_manager_app/model/model.dart';

class ListOf<T extends Model> extends Model {
  List<T> model;
  ListOf({required this.model});
}
