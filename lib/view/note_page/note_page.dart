import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:my_app/constants/my_color/color_constants.dart';
import 'package:my_app/controller/note_controller/note_controller.dart';
import 'package:my_app/model/note_model/note_model.dart';
import 'package:my_app/view/custom_widgets/bottom_bar/bottom_bar.dart';
import 'package:my_app/view/custom_widgets/note_components/note_box.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final noteController = NoteController();

  int selectedColor = 0;

  final titleController = TextEditingController();
  final descController = TextEditingController();
  final dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black12,
        appBar: AppBar(
          toolbarHeight: 70,
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Text(
            'N O T E S',
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
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              onPressed: () {
                noteBottomSheet();
              },
              child: Icon(
                Icons.add,
                color: Colors.white70,
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: ListView.builder(
              itemCount: noteController.noteList.length,
              itemBuilder: (context, index) {
                return MyNoteBox(
                  noteTitle: noteController.noteList[index].noteTitle, 
                  noteDesc: noteController.noteList[index].noteDesc, 
                  date: noteController.noteList[index].date, 
                  myColor: noteController.noteList[index].mycolor,
                  onDelete:()=> delete(index));
              }),
        ),
        bottomNavigationBar: MyBottomBar(),
      ),
    );
  }

  Future<dynamic> noteBottomSheet() async{
    return showModalBottomSheet(
      isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, inSetState) {
            return Container(
              padding: EdgeInsets.all(8),
              child: Padding(
                padding:EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: titleController,
                        decoration: InputDecoration(
                            labelText: 'Title',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(color: Colors.white))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: descController,
                        maxLines: 4,
                        decoration: InputDecoration(
                            labelText: 'Description',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(color: Colors.white))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: dateController,
                        decoration: InputDecoration(
                            suffixIcon: InkWell(
                                onTap: () {
                                  selectDate(context);
                                }, child: Icon(Icons.calendar_month)),
                            labelText: 'Date',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5))),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Choose color',
                          style: GoogleFonts.laila(color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        height: 45,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: ColorConstants.myColorlist.length,
                            itemBuilder: (context, index) => Padding(
                                  padding:
                                      const EdgeInsets.only(left: 5, right: 5),
                                  child: InkWell(
                                    onTap: () {
                                    inSetState(() {
                                      selectedColor = index;});
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 4,
                                              color: selectedColor == index
                                                  ? ColorConstants
                                                      .myColorlistDark[index]
                                                  : Colors.transparent),
                                          borderRadius: BorderRadius.circular(6),
                                          color:
                                              ColorConstants.myColorlist[index]),
                                    ),
                                  ),
                                )),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          color: Colors.black,
                          onPressed: () {
                            onSave();
                          },
                          child: Text(
                            'Save',
                            style: GoogleFonts.laila(color: Colors.white),
                          ),
                        ),
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          color: Colors.black,
                          onPressed: () {
                            onCancel();
                          },
                          child: Text(
                            'Cancel',
                            style: GoogleFonts.laila(color: Colors.white),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          });
        });
  }

  // to save the new note
  void onSave() {
    setState(() {
      noteController.addNote(NoteModel(
        noteTitle: titleController.text,
        noteDesc: descController.text,
        date: dateController.text,
        mycolor: selectedColor));
    });
    cleardata();
    Navigator.pop(context);
  }

  //to cancel the bottom sheet
  void onCancel() {
    cleardata();
    Navigator.pop(context);
  }

  //to delete the note
  void delete(int index){
    noteController.deleteNote(index);
    setState(() {});
  }

  //to clear the data in the textfields
  void cleardata(){
    titleController.clear();
    descController.clear();
    dateController.clear();
  }

  //to picking date
  Future<void> selectDate (BuildContext context) async{
    final DateTime? pickedDate = await showDatePicker(
      context: context, 
      firstDate: DateTime(2015,1), 
      lastDate: DateTime(2150));

      if(pickedDate != null && pickedDate != DateTime.now()){
        setState(() {
          dateController.text = DateFormat("dd-MM-yyyy").format(pickedDate);
        });
      }
  }

}
