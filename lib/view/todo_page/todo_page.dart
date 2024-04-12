import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/controller/todo_controller/todo_controller.dart';
import 'package:my_app/model/todomodel/todo_model.dart';
import 'package:my_app/view/custom_widgets/bottom_bar/bottom_bar.dart';
import 'package:my_app/view/custom_widgets/bottom_sheet/todo_bottomsheet.dart';
import 'package:my_app/view/custom_widgets/task_components/task_summary_tile.dart';
import 'package:my_app/view/custom_widgets/task_components/task_tile.dart';
import 'package:my_app/view/drawer_pages/privacy_policy.dart';
import 'package:my_app/view/drawer_pages/support_page.dart';
import 'package:my_app/view/drawer_pages/terms_and_condition.dart';
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

  //object for the controller page
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
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
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
                child: const Icon(
                  Icons.add,
                  color: Colors.white70,
                ),
              )
            ],
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          drawer: Drawer(
            backgroundColor: const Color.fromARGB(255, 29, 28, 28),
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/images/.gif',
                      width: 100,
                      height: 100,
                    ),
                    Text("Hello User!",
                        style: GoogleFonts.laila(
                            fontSize: 20, color: Colors.white)),
                  ],
                ),
                const SizedBox(
                  height: 100,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ToDoPage()));
                  },
                  child: ListTile(
                    leading: const Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    title: Text("Home",
                        style: GoogleFonts.laila(
                            fontSize: 18, color: Colors.white)),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PrivacyPolicyPage()));
                  },
                  child: ListTile(
                    leading: const Icon(
                      Icons.privacy_tip,
                      color: Colors.white,
                    ),
                    title: Text("Privacy Policy",
                        style: GoogleFonts.laila(
                            fontSize: 18, color: Colors.white)),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TermsAndCondition()));
                  },
                  child: ListTile(
                    leading: const Icon(
                      Icons.rule,
                      color: Colors.white,
                    ),
                    title: Text("Terms and Conditions",
                        style: GoogleFonts.laila(
                            fontSize: 18, color: Colors.white)),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SupportPage()));
                  },
                  child: ListTile(
                    leading: const Icon(
                      Icons.contact_support,
                      color: Colors.white,
                    ),
                    title: Text("Support",
                        style: GoogleFonts.laila(
                            fontSize: 18, color: Colors.white)),
                  ),
                )
              ],
            ),
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
                          onTapping: (value) => onTapping(index),
                          onEdit: (context) => onEdit(index),
                          onDelete: (context) => onDelete(index));
                    }),
              )
            ],
          ),
          bottomNavigationBar: const MyBottomBar()),
    );
  }

  //Alert box for creating tasks
  Future<dynamic> showtodoBox() {
    return showDialog(
        context: context,
        builder: (context) {
          return MyTodoSheet(
              taskController: todoController,
              onsave: todoSave,
              oncancel: cancel);
        });
  }

  //to save the task
  void todoSave() {
    setState(() {
      td_controller
          .addTodo(TodoModel(todo: todoController.text, status: false));
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
      td_controller.todoList[index].status =
          !td_controller.todoList[index].status;
    });
  }

  //to edit the existing task
  void onEdit(int index) {
    showDialog(
        context: context,
        builder: (context) {
          String task = td_controller.todoList[index].todo;
          todoController.text = task;
          return MyTodoSheet(
              taskController: todoController,
              onsave: () => newTodoSave(index),
              oncancel: cancel);
        });
  }

  //to save the edited task
  newTodoSave(int index) {
    setState(() {
      td_controller.editTodo(
          index,
          TodoModel(
              todo: todoController.text,
              status: td_controller.todoList[index].status));
    });
    Navigator.pop(context);
    todoController.clear();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Updated Successfully'),
      duration: Duration(seconds: 3),
    ));
  }

  //to delete the task
  void onDelete(int index) {
    td_controller.deleteTodo(index);
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Deleted Successfully'),
      duration: Duration(seconds: 3),
    ));
  }
}
