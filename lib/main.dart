import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_app/model/note_model/note_model.dart';
import 'package:my_app/model/todomodel/todo_model.dart';
import 'package:my_app/view/splash_page.dart';
import 'package:my_app/view/todo_page/todo_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Hive initialization
  await Hive.initFlutter();

  //register adapter for todo
  Hive.registerAdapter<TodoModel>(TodoModelAdapter());

  //register adapter for note
  Hive.registerAdapter<NoteModel>(NoteModelAdapter());

  //open box for todo
  var mytodobox = await Hive.openBox('todoBox');
  //open box for notes
  var mynotebox = await Hive.openBox('noteBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
    );
  }
}
