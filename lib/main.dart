import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_app/model/todomodel/todo_model.dart';
import 'package:my_app/view/todo_page/todo_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //Hive initialization
  await Hive.initFlutter();

  //register adapter for todo
  Hive.registerAdapter(TodoModelAdapter());
  
  //open box for todo
  var mytodobox = await Hive.openBox('todoBox');
  //open box for notes
  var box2 = await Hive.openBox('noteBox');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ToDoPage(),
    );
  }
}
