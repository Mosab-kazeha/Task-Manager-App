import 'dart:convert';
import 'package:task_manager_app/model/model.dart';

class TodoModel extends Model {
  int? id;
  String? todo;
  bool? completed;
  int? userId;

  TodoModel({
    this.id,
    this.todo,
    this.completed,
    this.userId,
  });

  TodoModel copyWith({
    int? id,
    String? todo,
    bool? completed,
    int? userId,
  }) =>
      TodoModel(
        id: id ?? this.id,
        todo: todo ?? this.todo,
        completed: completed ?? this.completed,
        userId: userId ?? this.userId,
      );

  factory TodoModel.fromJson(String str) => TodoModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TodoModel.fromMap(Map<String, dynamic> json) => TodoModel(
        id: json["id"],
        todo: json["todo"],
        completed: json["completed"],
        userId: json["userId"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "todo": todo,
        "completed": completed,
        "userId": userId,
      };
}
