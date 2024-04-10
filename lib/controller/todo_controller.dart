import 'package:hive/hive.dart';
import 'package:my_app/model/todomodel/todo_model.dart';

class TodoController{

 List<TodoModel> todoList =[];
 //refering the hive box
 final mytodobox = Hive.box('todoBox');

 //to add tasks in the todo list
 void addTodo(TodoModel newtodo){
  todoList.add(newtodo);
  updateDataBase();
 }

 //to remove tasks from the list
 void deleteTodo(int index){
  todoList.removeAt(index);
  updateDataBase();
 }


 //to load data from the database
 void loadData() {
  final retrievedData = mytodobox.get('TODOLIST') ?? [];
  todoList = retrievedData.cast<TodoModel>(); // Type casting for safety
 }

//to update the database
 void updateDataBase(){
  mytodobox.put('TODOLIST', todoList);
 }
   
  //to count the completed tasks
  int taskCountCompleted(){
    int taskCompleted = 0;

    for (int i = 0; i < todoList.length; i++) {
      if (todoList[i].status == true) {
        taskCompleted++;
      }
    }
     return taskCompleted;
  } 

  //to count the incompleted tasks
  int taskCountIncompleted(){
    int taskCompleted = 0;
    int taskIncompleted;
      for (int i = 0; i < todoList.length; i++) {
      if (todoList[i].status == true) {
        taskCompleted++;
      }
      }
     taskIncompleted = todoList.length-taskCompleted;
     return taskIncompleted;
  }

  //total task
  int totalTask(){
    int totalTask = 0;
    totalTask = todoList.length;
    return totalTask;
  }

}

// import 'package:hive/hive.dart';
// import 'package:my_app/model/todomodel/todo_model.dart';

// class TodoController{

//  List<TodoModel> todoList =[];
//  //refering the hive box
//  final mytodobox = Hive.box('todoBox');

//  // Constructor
//  TodoController() {
//    // Load data from the database when the controller is initialized
//    loadData();
//  }

//  //to add tasks in the todo list
//  void addTodo(TodoModel newtodo){
//   todoList.add(newtodo);
//   updateDataBase();
//  }

//  //to remove tasks from the list
//  void deleteTodo(int index){
//   todoList.removeAt(index);
//   updateDataBase();
//  }


//  //to load data from the database
//   Future<void> loadData() async {
//      await mytodobox.get('tododata') ?? [];
//     // final List dbdata = await mytodobox.get('tododata') ?? [];
//     // todoList = dbdata.map((element) => TodoModel(
//     //   todo: element.todo, 
//     //   status: element.status)).toList();
//  }

//  //to update the database
//  void updateDataBase(){
//   mytodobox.put('tododata', todoList);
//  }
   
//   //to count the completed tasks
//   int taskCountCompleted(){
//     int taskCompleted = 0;

//     for (int i = 0; i < todoList.length; i++) {
//       if (todoList[i].status == true) {
//         taskCompleted++;
//       }
//     }
//      return taskCompleted;
//   } 

//   //to count the incompleted tasks
//   int taskCountIncompleted(){
//     int taskCompleted = 0;
//     int taskIncompleted;
//       for (int i = 0; i < todoList.length; i++) {
//       if (todoList[i].status == true) {
//         taskCompleted++;
//       }
//       }
//      taskIncompleted = todoList.length-taskCompleted;
//      return taskIncompleted;
//   }

//   //total task
//   int totalTask(){
//     int totalTask = 0;
//     totalTask = todoList.length;
//     return totalTask;
//   }

// }
