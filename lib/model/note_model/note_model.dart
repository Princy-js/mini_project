import 'package:hive_flutter/hive_flutter.dart';
part 'note_model.g.dart';

@HiveType(typeId: 2)
class NoteModel{
  @HiveField(0)
  final String noteTitle;
  @HiveField(1)
  final String noteDesc;
  @HiveField(2)
  final String date;
  @HiveField(3)
  final int mycolor;

  NoteModel({
    required this.noteTitle,
    required this.noteDesc,
    required this.date,
    required this.mycolor
  });
}