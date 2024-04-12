import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:my_app/constants/my_color/color_constants.dart';
import 'package:my_app/controller/note_controller/note_controller.dart';
import 'package:my_app/model/note_model/note_model.dart';
import 'package:my_app/view/custom_widgets/bottom_bar/bottom_bar.dart';
import 'package:my_app/view/custom_widgets/note_components/note_box.dart';
import 'package:my_app/view/drawer_pages/privacy_policy.dart';
import 'package:my_app/view/drawer_pages/support_page.dart';
import 'package:my_app/view/drawer_pages/terms_and_condition.dart';
import 'package:my_app/view/todo_page/todo_page.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  @override
  void initState() {
    noteController.loadNotes();
    super.initState();
  }

  //object for the note controller page
  final noteController = NoteController();

  int selectedColor = 0;

  final titleController = TextEditingController();
  final descController = TextEditingController();
  final dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print(noteController.noteList);
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
          actions: [
            FloatingActionButton(
              backgroundColor: Colors.black,
              mini: true,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              onPressed: () {
                noteBottomSheet();
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
                      style:
                          GoogleFonts.laila(fontSize: 20, color: Colors.white)),
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
                      style:
                          GoogleFonts.laila(fontSize: 18, color: Colors.white)),
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
                      style:
                          GoogleFonts.laila(fontSize: 18, color: Colors.white)),
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
                      style:
                          GoogleFonts.laila(fontSize: 18, color: Colors.white)),
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
                      style:
                          GoogleFonts.laila(fontSize: 18, color: Colors.white)),
                ),
              )
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView.builder(
              itemCount: noteController.noteList.length,
              itemBuilder: (context, index) {
                return MyNoteBox(
                    noteTitle: noteController.noteList[index].noteTitle,
                    noteDesc: noteController.noteList[index].noteDesc,
                    date: noteController.noteList[index].date,
                    myColor: noteController.noteList[index].mycolor,
                    view: () => viewNote(index),
                    onEdit: () => editNote(index),
                    onDelete: () => delete(index));
              }),
        ),
        bottomNavigationBar: const MyBottomBar(),
      ),
    );
  }

  noteBottomSheet() {
    return showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, inSetState) {
            return Container(
              padding: const EdgeInsets.all(8),
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
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
                                borderSide:
                                    const BorderSide(color: Colors.white))),
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
                                borderSide:
                                    const BorderSide(color: Colors.white))),
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
                                },
                                child: const Icon(Icons.calendar_month)),
                            labelText: 'Date',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5))),
                      ),
                    ),
                    const SizedBox(
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
                    const SizedBox(
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
                                        selectedColor = index;
                                      });
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
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          color: ColorConstants
                                              .myColorlist[index]),
                                    ),
                                  ),
                                )),
                      ),
                    ),
                    const SizedBox(
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
          noteTitle: titleController.text.toUpperCase(),
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
  void delete(int index) {
    noteController.deleteNote(index);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Deleted Successfully'),
      duration: Duration(seconds: 3),
    ));
    setState(() {});
  }

  //to clear the data in the textfields
  void cleardata() {
    titleController.clear();
    descController.clear();
    dateController.clear();
  }

  //to picking date
  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        firstDate: DateTime(2015, 1),
        lastDate: DateTime(2150));

    if (pickedDate != null && pickedDate != DateTime.now()) {
      setState(() {
        dateController.text = DateFormat("dd-MM-yyyy").format(pickedDate);
      });
    }
  }

  void editNote(int index) {
    editNoteBottomSheet(index);
  }

  editNoteBottomSheet(int index) {
    return showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        context: context,
        builder: (context) {
          String title = noteController.noteList[index].noteTitle;
          String des = noteController.noteList[index].noteDesc;
          String date = noteController.noteList[index].date;
          int color = noteController.noteList[index].mycolor;

          titleController.text = title;
          descController.text = des;
          dateController.text = date;
          selectedColor = color;
          return StatefulBuilder(builder: (context, inSetState) {
            return Container(
              padding: const EdgeInsets.all(8),
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
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
                                borderSide:
                                    const BorderSide(color: Colors.white))),
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
                                borderSide:
                                    const BorderSide(color: Colors.white))),
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
                                },
                                child: const Icon(Icons.calendar_month)),
                            labelText: 'Date',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5))),
                      ),
                    ),
                    const SizedBox(
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
                    const SizedBox(
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
                                        selectedColor = index;
                                      });
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
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          color: ColorConstants
                                              .myColorlist[index]),
                                    ),
                                  ),
                                )),
                      ),
                    ),
                    const SizedBox(
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
                            newNoteSave(index);
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

  void newNoteSave(int index) {
    setState(() {
      noteController.edit(
          index,
          NoteModel(
              noteTitle: titleController.text.toUpperCase(),
              noteDesc: descController.text,
              date: dateController.text,
              mycolor: selectedColor));
    });
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Updated Successfully'),
      duration: Duration(seconds: 1),
    ));
  }

  viewNote(int index) {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  // color: noteController.noteList[index].mycolor as Color,
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        noteController.noteList[index].noteTitle,
                        style: GoogleFonts.laila(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    noteController.noteList[index].noteDesc,
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.laila(color: Colors.black, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      noteController.noteList[index].date,
                      style: GoogleFonts.laila(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
