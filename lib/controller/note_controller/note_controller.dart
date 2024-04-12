import 'package:hive/hive.dart';
import 'package:my_app/model/note_model/note_model.dart';

class NoteController {
  List<NoteModel> noteList = [];

  //refering the hive box
  final mynotebox = Hive.box('noteBox');

  //to add notes in the list
  void addNote(NoteModel newNote) {
    noteList.add(newNote);
    updateDataBase();
  }

  //to delete the note from the list
  void deleteNote(int index) {
    noteList.removeAt(index);
    updateDataBase();
  }

  //to edit the note
  void edit(int index, NoteModel editedNote) {
    noteList[index] = editedNote;
    updateDataBase();
  }

  //to load data from the database
  void loadNotes() {
    final loadData = mynotebox.get('NOTELIST') ?? [];
    //type casting
    noteList = loadData.cast<NoteModel>();
  }

  //to update database
  void updateDataBase() {
    mynotebox.put('NOTELIST', noteList);
  }
}
