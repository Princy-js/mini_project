import 'package:my_app/model/note_model/note_model.dart';

class NoteController {
  List<NoteModel> noteList = [];

  //to add notes in the list
  void addNote(NoteModel newNote){
    noteList.add(newNote);
  }

  //to delete the note from the list
  void deleteNote(int index){
    noteList.removeAt(index);
  }

}