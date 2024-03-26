import 'package:hive_flutter/hive_flutter.dart';
part 'todo_model.g.dart';

@HiveType(typeId: 1)
class TodoModel {
 @HiveField(0)
 final String todo;
 @HiveField(1)
 bool status;

 TodoModel({
  required this.todo,
  required this.status
 });

}