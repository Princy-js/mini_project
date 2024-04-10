import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/controller/todo_controller.dart';
import 'package:my_app/model/todomodel/todo_model.dart';
import 'package:my_app/view/custom_widgets/bottom_bar/bottom_bar.dart';
import 'package:my_app/view/custom_widgets/bottom_sheet/todo_bottomsheet.dart';
import 'package:my_app/view/custom_widgets/task_components/task_summary_tile.dart';
import 'package:my_app/view/custom_widgets/task_components/task_tile.dart';
import 'package:my_app/view/note_page/note_page.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key});

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {

@override
  void initState() {
    td_controller.loadData();
    super.initState();
  }
 
 

  //object creation for the controller page
  final td_controller = TodoController();

  //controller for the textfield
  final todoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print(td_controller.todoList);
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black12,
          appBar: AppBar(
            toolbarHeight: 70,
            centerTitle: true,
            backgroundColor: Colors.black,
            title: Text(
              'T O D O',
              style: GoogleFonts.laila(
                  fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            leading: Icon(
              Icons.menu,
              color: Colors.white70,
            ),
            actions: [
              FloatingActionButton(
                backgroundColor: Colors.black,
                mini: true,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                onPressed: () {
                  showtodoBox();
                },
                child: Icon(
                  Icons.add,
                  color: Colors.white70,
                ),
              )
            ],
          ),
          body: Column(
            children: [
            SummaryTile(
              total: '${td_controller.totalTask()}', 
              completed: '${td_controller.taskCountCompleted()}', 
              incompleted: '${td_controller.taskCountIncompleted()}'),
              Expanded(
                child: ListView.builder(
                    itemCount: td_controller.todoList.length,
                    itemBuilder: (context, index) {
                      return TaskTile(
                        taskName: td_controller.todoList[index].todo, 
                        taskStatus: td_controller.todoList[index].status, 
                        onTapping: (value)=> onTapping(index), 
                        onEdit: (context)=>onEdit(index), 
                        onDelete: (context) => onDelete(index));
                    }),
              )
            ],
          ),
          bottomNavigationBar: MyBottomBar()),
    );
  }
  
  //Alert box for creating tasks
  Future<dynamic> showtodoBox() {
    return showDialog(
      context: context, 
      builder: (context){
        return MyTodoSheet(
          taskController: todoController, 
          onsave: todoSave, 
          oncancel: cancel);
      });
  }

 //to save the task 
  void todoSave() {
   setState(() {
      td_controller.addTodo(
      TodoModel(
          todo: todoController.text,
       status: false));
      });
   todoController.clear();
   Navigator.pop(context);
  }
  
  //to cancel the alert box
  void cancel() {
    todoController.clear();
    Navigator.pop(context);
  }
 
 //to change the check box value
  void onTapping(int index) {
    setState(() {
      td_controller.todoList[index].status = !td_controller.todoList[index].status;
    });
  }

  //to edit the existing task
  void onEdit(int index) {
    showDialog(
      context: context,
       builder: (context){
        String task = td_controller.todoList[index].todo;
        todoController.text = task;
        return MyTodoSheet(
          taskController: todoController, 
          onsave: ()=>newTodoSave(index), 
          oncancel: cancel);
       });
  }

     //to save the edited task
      newTodoSave(int index) {
        td_controller.todoList[index].todo;
        setState(() {});
        Navigator.pop(context);
      }
  
  //to delete the task
  void onDelete(int index) {
    td_controller.deleteTodo(index);
    setState(() {});
   }
 
}


